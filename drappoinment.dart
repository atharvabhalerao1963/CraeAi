import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'drappoinment_model.dart';
export 'drappoinment_model.dart';

class DrappoinmentWidget extends StatefulWidget {
  const DrappoinmentWidget({super.key});

  static String routeName = 'drappoinment';
  static String routePath = '/drappoinment';

  @override
  State<DrappoinmentWidget> createState() => _DrappoinmentWidgetState();
}

class _DrappoinmentWidgetState extends State<DrappoinmentWidget> {
  late DrappoinmentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrappoinmentModel());

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
          backgroundColor: Color(0xFF7598C8),
          automaticallyImplyLeading: true,
          title: Text(
            'Appointment',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Urbanist',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: FlutterFlowWebView(
          content: 'https://www.practo.com/',
          bypass: true,
          height: 826,
          verticalScroll: true,
          horizontalScroll: false,
        ),
      ),
    );
  }
}
