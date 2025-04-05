import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'email_card_model.dart';
export 'email_card_model.dart';

class EmailCardWidget extends StatefulWidget {
  const EmailCardWidget({
    super.key,
    required this.message,
  });

  final MessageStruct? message;

  @override
  State<EmailCardWidget> createState() => _EmailCardWidgetState();
}

class _EmailCardWidgetState extends State<EmailCardWidget> {
  late EmailCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmailCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 300,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 37,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: FlutterFlowTheme.of(context).info,
                      size: 16,
                    ),
                    Text(
                      'EMAIL',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 12,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ].divide(SizedBox(width: 6)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'To',
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          if (getJsonField(
                                functions.jsonDecode(widget!.message!.dataJson),
                                r'''$.toEmail''',
                              ) !=
                              null)
                            Expanded(
                              flex: 3,
                              child: AutoSizeText(
                                getJsonField(
                                  functions
                                      .jsonDecode(widget!.message!.dataJson),
                                  r'''$.toEmail''',
                                ).toString(),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'Subject',
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          if (getJsonField(
                                functions.jsonDecode(widget!.message!.dataJson),
                                r'''$.subject''',
                              ) !=
                              null)
                            Expanded(
                              flex: 3,
                              child: AutoSizeText(
                                getJsonField(
                                  functions
                                      .jsonDecode(widget!.message!.dataJson),
                                  r'''$.subject''',
                                ).toString(),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                        ].divide(SizedBox(width: 10)),
                      ),
                      Opacity(
                        opacity: 0.25,
                        child: Divider(
                          height: 10,
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(1, -1),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // Copy to clipboard
                                await Clipboard.setData(ClipboardData(
                                    text: getJsonField(
                                  functions
                                      .jsonDecode(widget!.message!.dataJson),
                                  r'''$.EmailCard.text''',
                                ).toString()));
                                // Show snack
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Copied to clipboard',
                                      style: TextStyle(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 14,
                                        height: 2,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    duration: Duration(milliseconds: 2500),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.content_copy_rounded,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 16,
                              ),
                            ),
                          ),
                          if (getJsonField(
                                functions.jsonDecode(widget!.message!.dataJson),
                                r'''$.text''',
                              ) !=
                              null)
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: MarkdownBody(
                                  data: getJsonField(
                                    functions
                                        .jsonDecode(widget!.message!.dataJson),
                                    r'''$.text''',
                                  ).toString(),
                                  selectable: true,
                                  onTapLink: (_, url, __) => launchURL(url!),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ].divide(SizedBox(height: 10)),
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Send',
                    icon: Icon(
                      Icons.send,
                      size: 15,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ].divide(SizedBox(height: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
