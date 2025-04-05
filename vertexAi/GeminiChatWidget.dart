import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/components/audio_chip/audio_chip_widget.dart';
import '/components/empty_chats/empty_chats_widget.dart';
import '/components/message/message_widget.dart';
import '/components/usage_credit_exceeded/usage_credit_exceeded_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import 'gemini_chat_model.dart';
export 'gemini_chat_model.dart';

class GeminiChatWidget extends StatefulWidget {
  const GeminiChatWidget({
    super.key,
    required this.modelConfiguration,
    required this.userProfile,
    this.responseSchemaDefinition,
  });

  final ModelConfigurationStruct? modelConfiguration;
  final UserProfileStruct? userProfile;
  final dynamic responseSchemaDefinition;

  @override
  State<GeminiChatWidget> createState() => _GeminiChatWidgetState();
}

class _GeminiChatWidgetState extends State<GeminiChatWidget> {
  late GeminiChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GeminiChatModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Builder(
            builder: (context) {
              final message = _model.messages.toList();
              if (message.isEmpty) {
                return EmptyChatsWidget();
              }

              return ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  0,
                  100,
                  0,
                  150,
                ),
                reverse: true,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: message.length,
                separatorBuilder: (_, __) => SizedBox(height: 24),
                itemBuilder: (context, messageIndex) {
                  final messageItem = message[messageIndex];
                  return wrapWithModel(
                    model: _model.messageModels.getModel(
                      messageIndex.toString(),
                      messageIndex,
                    ),
                    updateCallback: () => safeSetState(() {}),
                    child: MessageWidget(
                      key: Key(
                        'Key0gr_${messageIndex.toString()}',
                      ),
                      message: messageItem,
                      userProfile: widget!.userProfile!,
                      modelConfiguration: widget!.modelConfiguration!,
                      callback: (message) async {
                        // Add the user message
                        _model.insertAtIndexInMessages(
                            0,
                            MessageStruct(
                              role: FFAppConstants.RoleUser,
                              type: 'TextMessage',
                              dataJson:
                                  functions.textMessageEncodedJson(message),
                              createdAt: getCurrentTimestamp,
                            ));
                        safeSetState(() {});
                        // Add a blank agent message
                        _model.insertAtIndexInMessages(
                            0,
                            MessageStruct(
                              role: FFAppConstants.RoleAgent,
                              type: 'TextMessage',
                            ));
                        safeSetState(() {});
                        // Call Gemini
                        _model.geminiResponseInCallback =
                            await actions.callGemini(
                          getJsonField(
                            functions.jsonDecode(
                                _model.messages.firstOrNull!.dataJson),
                            r'''$.TextMessage.text''',
                          ).toString(),
                          _model.messages.elementAtOrNull(1)?.images?.toList(),
                          widget!.modelConfiguration!,
                          _model.messages.elementAtOrNull(1)?.audios?.toList(),
                          FFAppState().GeminiResponseSchema,
                        );
                        // Parse the Gemini Response
                        _model.geminiMessageInCallback =
                            await actions.parseGeminiResponse(
                          _model.geminiResponseInCallback!,
                        );
                        // Update the blank agent message, clear the prompt, and reset the images
                        _model.updateMessagesAtIndex(
                          0,
                          (e) => e
                            ..createdAt =
                                _model.geminiMessageInCallback?.createdAt
                            ..type = _model.geminiMessageInCallback?.type
                            ..dataJson =
                                _model.geminiMessageInCallback?.dataJson,
                        );
                        _model.prompt = null;
                        _model.uploadedImagePaths = [];
                        safeSetState(() {});

                        safeSetState(() {});
                      },
                    ),
                  );
                },
              );
            },
          ),
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2,
                  sigmaY: 2,
                ),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Builder(
                          builder: (context) {
                            final imagePath =
                                _model.uploadedImagePaths.toList();

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(imagePath.length,
                                      (imagePathIndex) {
                                final imagePathItem = imagePath[imagePathIndex];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imagePathItem,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              })
                                  .divide(SizedBox(width: 16))
                                  .around(SizedBox(width: 16)),
                            );
                          },
                        ),
                        Builder(
                          builder: (context) {
                            final audioPath =
                                _model.uploadedAudioPaths.toList();

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(audioPath.length,
                                      (audioPathIndex) {
                                final audioPathItem = audioPath[audioPathIndex];
                                return AudioChipWidget(
                                  key: Key(
                                      'Key8uk_${audioPathIndex}_of_${audioPath.length}'),
                                  parameter1: audioPathIndex,
                                  parameter2: audioPathItem,
                                );
                              })
                                  .divide(SizedBox(width: 16))
                                  .around(SizedBox(width: 16)),
                            );
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flex(
                              direction: () {
                                if (MediaQuery.sizeOf(context).width <
                                    kBreakpointSmall) {
                                  return false;
                                } else if (MediaQuery.sizeOf(context).width <
                                    kBreakpointMedium) {
                                  return false;
                                } else if (MediaQuery.sizeOf(context).width <
                                    kBreakpointLarge) {
                                  return true;
                                } else {
                                  return true;
                                }
                              }()
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 16,
                                  buttonSize: 32,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.image,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 12,
                                  ),
                                  onPressed: () async {
                                    // Upload image to Firebase
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      maxWidth: 600.00,
                                      allowPhoto: true,
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      textColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      safeSetState(
                                          () => _model.isDataUploading1 = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        showUploadMessage(
                                          context,
                                          'Uploading file...',
                                          showLoading: true,
                                        );
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        _model.isDataUploading1 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile1 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl1 =
                                              downloadUrls.first;
                                        });
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        safeSetState(() {});
                                        showUploadMessage(
                                            context, 'Failed to upload data');
                                        return;
                                      }
                                    }

                                    // Add image path to list
                                    _model.addToUploadedImagePaths(
                                        _model.uploadedFileUrl1);
                                    safeSetState(() {});
                                  },
                                ),
                                Builder(
                                  builder: (context) {
                                    if (!_model.isRecording) {
                                      return FlutterFlowIconButton(
                                        borderRadius: 16,
                                        buttonSize: 32,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        icon: Icon(
                                          Icons.graphic_eq_rounded,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 16,
                                        ),
                                        onPressed: () async {
                                          // Set isRecording to true
                                          _model.isRecording = true;
                                          safeSetState(() {});
                                          // Start the recording
                                          await startAudioRecording(
                                            context,
                                            audioRecorder:
                                                _model.audioRecorder ??=
                                                    AudioRecorder(),
                                          );
                                        },
                                      );
                                    } else {
                                      return FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 16,
                                        buttonSize: 32,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        icon: Icon(
                                          Icons.stop_rounded,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 16,
                                        ),
                                        onPressed: () async {
                                          // Set isRecording to false
                                          _model.isRecording = false;
                                          safeSetState(() {});
                                          // Stop recording
                                          await stopAudioRecording(
                                            audioRecorder: _model.audioRecorder,
                                            audioName: 'recordedFileBytes',
                                            onRecordingComplete:
                                                (audioFilePath, audioBytes) {
                                              _model.recordedUserAudio =
                                                  audioFilePath;
                                              _model.recordedFileBytes =
                                                  audioBytes;
                                            },
                                          );

                                          // Set audio file format
                                          _model.renamedAudioFile =
                                              await actions.renameAudio(
                                            _model.recordedFileBytes,
                                            _model.recordedUserAudio!,
                                          );
                                          // Upload recording to firebase
                                          {
                                            safeSetState(() =>
                                                _model.isDataUploading2 = true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];
                                            var selectedFiles =
                                                <SelectedFile>[];
                                            var downloadUrls = <String>[];
                                            try {
                                              showUploadMessage(
                                                context,
                                                'Uploading file...',
                                                showLoading: true,
                                              );
                                              selectedUploadedFiles = _model
                                                      .renamedAudioFile!
                                                      .bytes!
                                                      .isNotEmpty
                                                  ? [_model.renamedAudioFile!]
                                                  : <FFUploadedFile>[];
                                              selectedFiles =
                                                  selectedFilesFromUploadedFiles(
                                                selectedUploadedFiles,
                                              );
                                              downloadUrls = (await Future.wait(
                                                selectedFiles.map(
                                                  (f) async => await uploadData(
                                                      f.storagePath, f.bytes),
                                                ),
                                              ))
                                                  .where((u) => u != null)
                                                  .map((u) => u!)
                                                  .toList();
                                            } finally {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              _model.isDataUploading2 = false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                    selectedFiles.length &&
                                                downloadUrls.length ==
                                                    selectedFiles.length) {
                                              safeSetState(() {
                                                _model.uploadedLocalFile2 =
                                                    selectedUploadedFiles.first;
                                                _model.uploadedFileUrl2 =
                                                    downloadUrls.first;
                                              });
                                              showUploadMessage(
                                                context,
                                                'Success!',
                                              );
                                            } else {
                                              safeSetState(() {});
                                              showUploadMessage(
                                                context,
                                                'Failed to upload file',
                                              );
                                              return;
                                            }
                                          }

                                          // Update the uploadedAudioPaths
                                          _model.addToUploadedAudioPaths(
                                              _model.uploadedFileUrl2);
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                      );
                                    }
                                  },
                                ),
                              ].divide(() {
                                if (MediaQuery.sizeOf(context).width <
                                    kBreakpointSmall) {
                                  return false;
                                } else if (MediaQuery.sizeOf(context).width <
                                    kBreakpointMedium) {
                                  return false;
                                } else if (MediaQuery.sizeOf(context).width <
                                    kBreakpointLarge) {
                                  return true;
                                } else {
                                  return true;
                                }
                              }()
                                  ? SizedBox(width: 4)
                                  : SizedBox(height: 4)),
                            ),
                            Expanded(
                              child: Stack(
                                alignment: AlignmentDirectional(1, 0),
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Builder(
                                        builder: (context) {
                                          if (!_model.isRecording) {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 54, 0),
                                              child: TextFormField(
                                                controller:
                                                    _model.textController,
                                                focusNode:
                                                    _model.textFieldFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  hintText: 'Ask anything',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                maxLines: 6,
                                                minLines: 1,
                                                cursorColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                validator: _model
                                                    .textControllerValidator
                                                    .asValidator(context),
                                              ),
                                            );
                                          } else {
                                            return Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Padding(
                                                padding: EdgeInsets.all(12),
                                                child: Text(
                                                  'Listening...',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) => Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 8, 0),
                                      child: FlutterFlowIconButton(
                                        borderRadius: 16,
                                        buttonSize: 32,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        disabledColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        disabledIconColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                        icon: Icon(
                                          Icons.arrow_upward,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 12,
                                        ),
                                        onPressed: (_model
                                                        .textController.text ==
                                                    null ||
                                                _model.textController.text ==
                                                    '')
                                            ? null
                                            : () async {
                                                // Update the total number of user calls

                                                await currentUserReference!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'total_calls':
                                                          FieldValue.increment(
                                                              1.0),
                                                    },
                                                  ),
                                                });
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.totalCalls,
                                                        0.0) <
                                                    10.0) {
                                                  // Add the user message
                                                  _model
                                                      .insertAtIndexInMessages(
                                                          0,
                                                          MessageStruct(
                                                            role: FFAppConstants
                                                                .RoleUser,
                                                            createdAt:
                                                                getCurrentTimestamp,
                                                            images: _model
                                                                .uploadedImagePaths,
                                                            type: 'TextMessage',
                                                            dataJson: functions
                                                                .textMessageEncodedJson(
                                                                    _model
                                                                        .textController
                                                                        .text),
                                                            audios: _model
                                                                .uploadedAudioPaths,
                                                          ));
                                                  _model.prompt = _model
                                                      .textController.text;
                                                  _model.uploadedImagePaths =
                                                      _model.uploadedImagePaths
                                                          .toList()
                                                          .cast<String>();
                                                  _model.uploadedAudioPaths =
                                                      _model.uploadedAudioPaths
                                                          .toList()
                                                          .cast<String>();
                                                  safeSetState(() {});
                                                  // Clear the user message
                                                  safeSetState(() {
                                                    _model.textController
                                                        ?.clear();
                                                  });
                                                  // Clear user images & audio
                                                  _model.uploadedImagePaths =
                                                      [];
                                                  _model.uploadedAudioPaths =
                                                      [];
                                                  safeSetState(() {});
                                                  // Add a blank agent message
                                                  _model
                                                      .insertAtIndexInMessages(
                                                          0,
                                                          MessageStruct(
                                                            role: FFAppConstants
                                                                .RoleAgent,
                                                            type: 'TextMessage',
                                                          ));
                                                  safeSetState(() {});
                                                  // Call Gemini
                                                  _model.geminiResponse =
                                                      await actions.callGemini(
                                                    _model.prompt!,
                                                    _model.messages
                                                        .elementAtOrNull(1)
                                                        ?.images
                                                        ?.toList(),
                                                    widget!.modelConfiguration!,
                                                    _model.messages
                                                        .elementAtOrNull(1)
                                                        ?.audios
                                                        ?.toList(),
                                                    widget!
                                                        .responseSchemaDefinition!,
                                                  );
                                                  // Parse the Gemini Response
                                                  _model.geminiMessage =
                                                      await actions
                                                          .parseGeminiResponse(
                                                    _model.geminiResponse!,
                                                  );
                                                  // Update the blank agent message, clear the prompt, and reset the images
                                                  _model.updateMessagesAtIndex(
                                                    0,
                                                    (e) => e
                                                      ..createdAt =
                                                          getCurrentTimestamp
                                                      ..type = _model
                                                          .geminiMessage?.type
                                                      ..dataJson = _model
                                                          .geminiMessage
                                                          ?.dataJson,
                                                  );
                                                  _model.prompt = null;
                                                  _model.uploadedImagePaths =
                                                      [];
                                                  _model.updatePage(() {});
                                                } else {
                                                  // Show limit exceeded
                                                  await showDialog(
                                                    barrierColor:
                                                        Color(0x80000000),
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        alignment:
                                                            AlignmentDirectional(
                                                                    0, 0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        child: Container(
                                                          width: 300,
                                                          child:
                                                              UsageCreditExceededWidget(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ].divide(SizedBox(width: 16)),
                        ),
                      ].divide(SizedBox(height: 8)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
