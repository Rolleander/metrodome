import 'package:flutter/material.dart';
import 'package:metrodome/song/song_player.dart';
import 'package:metrodome/song/time_signature.dart';

import '../../song/song.dart';

class SongPainter extends CustomPainter {
  static const _barHeight = 50;
  static const _wholeNoteWidth = 200;

  Song _song;
  SongPlayer? _player;
  TimeSignature? _drawTimeSignature;
  int _drawDuration = 0;

  SongPainter(this._song, [this._player]);

  @override
  void paint(Canvas canvas, Size size) {
    for (var beat in _song.allBeats()) {
      paintBeat(canvas, size, beat);
    }
  }

  void paintBeat(Canvas canvas, Size size, Beat beat) {
    double length = beat.getBlockLength(_wholeNoteWidth);
    if (_drawTimeSignature != beat.time) {
      paintTimeSignature(canvas);
    }
    _drawTimeSignature ??= beat.time;
    final duration = beat.getDuration();
    if (_player != null) {
      final elapsedTime = _player!.getElapsedTime();
      if (elapsedTime >= _drawDuration &&
          elapsedTime < _drawDuration + duration) {}
    }
    _drawDuration += duration;
  }

  void paintCursor(Canvas canvas) {}

  void paintTimeSignature(Canvas canvas) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
