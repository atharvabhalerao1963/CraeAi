import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'single_action_card_model.dart';
export 'single_action_card_model.dart';

class SingleActionCardWidget extends StatefulWidget {
  const SingleActionCardWidget({
    super.key,
    required this.message,
  });

  final MessageStruct? message;

  @override
  State<SingleActionCardWidget> createState() => _SingleActionCardWidgetState();
}

class _SingleActionCardWidgetState extends State<SingleActionCardWidget> {
  late SingleActionCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SingleActionCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 300,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidBell,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 16,
                    ),
                    if (getJsonField(
                          functions.jsonDecode(widget!.message!.dataJson),
                          r'''$.title''',
                        ) !=
                        null)
                      Expanded(
                        child: AutoSizeText(
                          getJsonField(
                            functions.jsonDecode(widget!.message!.dataJson),
                            r'''$.title''',
                          ).toString(),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Inter Tight',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                  ].divide(SizedBox(width: 10)),
                ),
                if (getJsonField(
                      functions.jsonDecode(widget!.message!.dataJson),
                      r'''$.description''',
                    ) !=
                    null)
                  Text(
                    getJsonField(
                      functions.jsonDecode(widget!.message!.dataJson),
                      r'''$.description''',
                    ).toString(),
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
              ].divide(SizedBox(height: 5)),
            ),
            FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: getJsonField(
                functions.jsonDecode(widget!.message!.dataJson),
                r'''$.actionTitle''',
              ).toString(),
              options: FFButtonOptions(
                width: double.infinity,
                height: 40,
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Inter Tight',
                      color: Colors.white,
                      fontSize: 14,
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
    );
  }
}
