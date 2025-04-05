import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'audio_chip_model.dart';
export 'audio_chip_model.dart';

class AudioChipWidget extends StatefulWidget {
  const AudioChipWidget({
    super.key,
    this.parameter1,
    required this.parameter2,
  });

  final int? parameter1;
  final String? parameter2;

  @override
  State<AudioChipWidget> createState() => _AudioChipWidgetState();
}

class _AudioChipWidgetState extends State<AudioChipWidget> {
  late AudioChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioChipModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // Play the audio
        _model.soundPlayer ??= AudioPlayer();
        if (_model.soundPlayer!.playing) {
          await _model.soundPlayer!.stop();
        }
        _model.soundPlayer!.setVolume(1);
        _model.soundPlayer!
            .setUrl(widget!.parameter2!)
            .then((_) => _model.soundPlayer!.play());
      },
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).alternate,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_arrow_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 16,
              ),
              Text(
                'Recording ${((widget!.parameter1!) + 1).toString()}',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 12,
                      letterSpacing: 0.0,
                    ),
              ),
              Icon(
                Icons.graphic_eq_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 12,
              ),
            ].divide(SizedBox(width: 4)),
          ),
        ),
      ),
    );
  }
}
