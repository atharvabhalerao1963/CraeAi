import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
          title: Text(
            'Welcome!',
            style: FlutterFlowTheme.of(context).headlineLarge.override(
                  fontFamily: 'Urbanist',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/newlogo.png',
                    width: 126.3,
                    height: 102.8,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 70, 37, 5),
                  child: Text(
                    'What\'s your Role?',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController ??=
                    FormFieldController<String>(
                  _model.dropDownValue ??= 'Patient',
                ),
                options:
                    List<String>.from(['Patient', 'HealthWorker', 'Doctor']),
                optionLabels: ['Patient', 'HealthWorker', 'Doctor'],
                onChanged: (val) async {
                  safeSetState(() => _model.dropDownValue = val);
                  FFAppState().selectRole = _model.dropDownValue!;
                  safeSetState(() {});
                },
                width: 200,
                height: 40,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Manrope',
                      letterSpacing: 0.0,
                    ),
                hintText: 'Select...',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24,
                ),
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                elevation: 2,
                borderColor: Colors.transparent,
                borderWidth: 0,
                borderRadius: 8,
                margin: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                hidesUnderline: true,
                isOverButton: false,
                isSearchable: false,
                isMultiSelect: false,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (FFAppState().selectRole == FFAppState().Patient) {
                      context.pushNamed(Patientportal1Widget.routeName);
                    } else {
                      if (FFAppState().selectRole ==
                          FFAppState().HealthWorker) {
                        context
                            .pushNamed(HealthworkerdashboardWidget.routeName);
                      } else {
                        context.pushNamed(DoctorHomeWidget.routeName);
                      }
                    }
                  },
                  text: 'Next',
                  options: FFButtonOptions(
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Manrope',
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8),
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
