import '/backend/schema/structs/index.dart';
import '/components/audio_chip/audio_chip_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'text_message_model.dart';
export 'text_message_model.dart';

class TextMessageWidget extends StatefulWidget {
  const TextMessageWidget({
    super.key,
    required this.message,
    required this.modelConfiguration,
    required this.userProfile,
  });

  final MessageStruct? message;
  final ModelConfigurationStruct? modelConfiguration;
  final UserProfileStruct? userProfile;

  @override
  State<TextMessageWidget> createState() => _TextMessageWidgetState();
}

class _TextMessageWidgetState extends State<TextMessageWidget>
    with TickerProviderStateMixin {
  late TextMessageModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TextMessageModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOutQuint,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            color: FlutterFlowTheme.of(context).accent1,
            angle: 0.524,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: AlignmentDirectional(
              valueOrDefault<double>(
                widget!.message?.role == FFAppConstants.RoleUser ? 1.0 : -1.0,
                -1.0,
              ),
              -1),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget!.message?.role == FFAppConstants.RoleAgent)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        width: 120,
                        height: 120,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 100),
                          fadeOutDuration: Duration(milliseconds: 100),
                          imageUrl: valueOrDefault<String>(
                            widget!.modelConfiguration?.agentProfilePicture !=
                                        null &&
                                    widget!.modelConfiguration
                                            ?.agentProfilePicture !=
                                        ''
                                ? widget!
                                    .modelConfiguration?.agentProfilePicture
                                : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/g-p-t-4o-gwizk5/assets/ij7c0yekmnfb/Logo_Glass.png',
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/g-p-t-4o-gwizk5/assets/ij7c0yekmnfb/Logo_Glass.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(
                            valueOrDefault<double>(
                              widget!.message?.role == FFAppConstants.RoleUser
                                  ? 1.0
                                  : -1.0,
                              -1.0,
                            ),
                            -1),
                        child: Text(
                          widget!.message?.role == FFAppConstants.RoleAgent
                              ? widget!.modelConfiguration!.agentName
                              : widget!.userProfile!.username,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Inter',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          if (getJsonField(
                                functions.jsonDecode(widget!.message!.dataJson),
                                r'''$.text''',
                              ) !=
                              null) {
                            return Align(
                              alignment: AlignmentDirectional(
                                  valueOrDefault<double>(
                                    widget!.message?.role ==
                                            FFAppConstants.RoleUser
                                        ? 1.0
                                        : -1.0,
                                    -1.0,
                                  ),
                                  0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 400,
                                  ),
                                  decoration: BoxDecoration(
                                    color: valueOrDefault<Color>(
                                      widget!.message?.role ==
                                              FFAppConstants.RoleUser
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          constraints: BoxConstraints(
                                            minHeight: 24,
                                          ),
                                          decoration: BoxDecoration(),
                                          child: Builder(
                                            builder: (context) {
                                              if (widget!.message?.role ==
                                                  FFAppConstants.RoleUser) {
                                                return Text(
                                                  getJsonField(
                                                    functions.jsonDecode(widget!
                                                        .message!.dataJson),
                                                    r'''$.text''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        letterSpacing: 0.0,
                                                      ),
                                                );
                                              } else {
                                                return Visibility(
                                                  visible: widget!.message
                                                              ?.dataJson !=
                                                          null &&
                                                      widget!.message
                                                              ?.dataJson !=
                                                          '',
                                                  child: MarkdownBody(
                                                    data: getJsonField(
                                                      functions.jsonDecode(
                                                          widget!.message!
                                                              .dataJson),
                                                      r'''$.text''',
                                                    ).toString(),
                                                    selectable: true,
                                                    onTapLink: (_, url, __) =>
                                                        launchURL(url!),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: double.infinity,
                                  height: 54,
                                  constraints: BoxConstraints(
                                    maxWidth: 400,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation']!),
                            );
                          }
                        },
                      ),
                    ].divide(SizedBox(height: 5)),
                  ),
                ),
              ),
              if (widget!.message?.role == FFAppConstants.RoleUser)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        width: 120,
                        height: 120,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 100),
                          fadeOutDuration: Duration(milliseconds: 100),
                          imageUrl: widget!.userProfile!.profilePicture,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
            ].divide(SizedBox(width: 5)),
          ),
        ),
        if (widget!.message?.images != null &&
            (widget!.message?.images)!.isNotEmpty)
          Builder(
            builder: (context) {
              final img = widget!.message?.images?.toList() ?? [];

              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(img.length, (imgIndex) {
                  final imgItem = img[imgIndex];
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: FlutterFlowExpandedImageView(
                            image: Image.network(
                              imgItem,
                              fit: BoxFit.contain,
                            ),
                            allowRotation: true,
                            tag: imgItem,
                            useHeroAnimation: true,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: imgItem,
                      transitionOnUserGestures: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imgItem,
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                }).divide(SizedBox(width: 16)).around(SizedBox(width: 16)),
              );
            },
          ),
        if (widget!.message?.audios != null &&
            (widget!.message?.audios)!.isNotEmpty)
          Builder(
            builder: (context) {
              final audio = widget!.message?.audios?.toList() ?? [];

              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(audio.length, (audioIndex) {
                  final audioItem = audio[audioIndex];
                  return AudioChipWidget(
                    key: Key('Keywk0_${audioIndex}_of_${audio.length}'),
                    parameter1: audioIndex,
                    parameter2: audioItem,
                  );
                }).divide(SizedBox(width: 16)).around(SizedBox(width: 16)),
              );
            },
          ),
      ].divide(SizedBox(height: 16)),
    );
  }
}
