import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'medicemarketplace_model.dart';
export 'medicemarketplace_model.dart';

class MedicemarketplaceWidget extends StatefulWidget {
  const MedicemarketplaceWidget({super.key});

  static String routeName = 'medicemarketplace';
  static String routePath = '/medicemarketplace';

  @override
  State<MedicemarketplaceWidget> createState() =>
      _MedicemarketplaceWidgetState();
}

class _MedicemarketplaceWidgetState extends State<MedicemarketplaceWidget> {
  late MedicemarketplaceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MedicemarketplaceModel());

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 100.3,
                height: 59.93,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: FlutterFlowIconButton(
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
              ),
              Expanded(
                child: FlutterFlowWebView(
                  content: 'https://www.apollopharmacy.in/',
                  bypass: true,
                  height: 804.1,
                  verticalScroll: true,
                  horizontalScroll: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
