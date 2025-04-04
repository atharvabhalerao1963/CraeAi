import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'empty_chats_model.dart';
export 'empty_chats_model.dart';

class EmptyChatsWidget extends StatefulWidget {
  const EmptyChatsWidget({super.key});

  @override
  State<EmptyChatsWidget> createState() => _EmptyChatsWidgetState();
}

class _EmptyChatsWidgetState extends State<EmptyChatsWidget> {
  late EmptyChatsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyChatsModel());

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
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(),
      alignment: AlignmentDirectional(0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No chats yet',
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Icon(
                Icons.auto_awesome,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24,
              ),
            ].divide(SizedBox(width: 8)),
          ),
          Text(
            'Start a conversation below!',
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  fontFamily: 'Inter',
                  letterSpacing: 0.0,
                ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Powered by',
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    'assets/images/Google_Gemini_logo.svg.png',
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ].divide(SizedBox(height: 4)),
      ),
    );
  }
}
