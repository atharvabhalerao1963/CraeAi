import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'reports_model.dart';
export 'reports_model.dart';

class ReportsWidget extends StatefulWidget {
  const ReportsWidget({super.key});

  static String routeName = 'reports';
  static String routePath = '/reports';

  @override
  State<ReportsWidget> createState() => _ReportsWidgetState();
}

class _ReportsWidgetState extends State<ReportsWidget> {
  late ReportsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 8,
            buttonSize: 40,
            fillColor: FlutterFlowTheme.of(context).primary,
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).info,
              size: 24,
            ),
            onPressed: () async {
              context.pushNamed(Patientportal1Widget.routeName);
            },
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(320, 10, 0, 0),
                      child: FlutterFlowIconButton(
                        borderRadius: 8,
                        buttonSize: 48.73,
                        fillColor: FlutterFlowTheme.of(context).primary,
                        icon: Icon(
                          Icons.calendar_month,
                          color: FlutterFlowTheme.of(context).info,
                          size: 24,
                        ),
                        onPressed: () async {
                          context.pushNamed(CalenderWidget.routeName);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(255, 0, 0, 0),
                      child: Text(
                        'Callender',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Manrope',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1.05),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.95, -0.4),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Container(
                    width: 184.63,
                    height: 151.9,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: FlutterFlowIconButton(
                        borderRadius: 8,
                        buttonSize: 40,
                        icon: Icon(
                          Icons.file_upload_outlined,
                          color: Color(0xFF2C2A2A),
                          size: 50,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.9, -0.4),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Container(
                    width: 155,
                    height: 147.56,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: FlutterFlowIconButton(
                      borderRadius: 8,
                      buttonSize: 43,
                      icon: Icon(
                        Icons.file_upload_outlined,
                        color: Color(0xFF151515),
                        size: 50,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.92, 0.15),
                child: Container(
                  width: 199.4,
                  height: 159.8,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: FlutterFlowIconButton(
                    borderRadius: 8,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.file_upload_outlined,
                      color: Color(0xFF111010),
                      size: 50,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.89, 0.15),
                child: Container(
                  width: 152.91,
                  height: 155.5,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: FlutterFlowIconButton(
                    borderRadius: 8,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.file_upload_outlined,
                      color: Color(0xFF1D1C1C),
                      size: 50,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
