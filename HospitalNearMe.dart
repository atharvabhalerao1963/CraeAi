import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'hospital_near_me_model.dart';
export 'hospital_near_me_model.dart';

class HospitalNearMeWidget extends StatefulWidget {
  const HospitalNearMeWidget({super.key});

  static String routeName = 'HospitalNearMe';
  static String routePath = '/hospitalNearMe';

  @override
  State<HospitalNearMeWidget> createState() => _HospitalNearMeWidgetState();
}

class _HospitalNearMeWidgetState extends State<HospitalNearMeWidget> {
  late HospitalNearMeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HospitalNearMeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.pushNamed(Patientportal1Widget.routeName);
    });

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
        body: SafeArea(
          top: true,
          child: FlutterFlowWebView(
            content: 'https://flutter.dev',
            bypass: false,
            height: 500,
            verticalScroll: false,
            horizontalScroll: false,
          ),
        ),
      ),
    );
  }
}
