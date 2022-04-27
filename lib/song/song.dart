import 'dart:convert';
import 'dart:ffi';

import 'package:metrodome/song/time_signature.dart';

class Song {
  late String name;
  late TimeSignature baseTime;
  late int baseBpm;
  late List<Beat> _beats;
  late List<SongPart> _parts;

  Song(String json) {
    Map data = jsonDecode(json);
    name = data['name'];
    baseTime = TimeSignature(data['time']);
    baseBpm = data['bpm'];
    _beats = (data['beats'] as List)
        .map((beat) => Beat(beat, baseTime, baseBpm))
        .toList();
    _parts =
        (data['parts'] as List).map((part) => SongPart(part, _beats)).toList();
  }

  Iterable<Beat> allBeats() {
    return _parts.expand((part) => part.getBeats());
  }
}

class Beat {
  late int bars;
  late int bpm;
  late TimeSignature time;

  Beat(Map json, TimeSignature baseTime, int baseBpm) {
    bars = json['bars'];
    time = baseTime;
    bpm = baseBpm;
  }

  double getBlockLength(int wholeNoteLength) {
    return (wholeNoteLength / time.note) * time.count;
  }

  int getNotes() {
    return time.count * bars;
  }

  int getDuration() {
    return getNotes() * time.calcNoteDuration(bpm);
  }
}

class SongPart {
  late Beat beat;
  late int count;

  SongPart(Map json, List<Beat> beats) {
    final beatIndex = json['beat'];
    count = json['count'];
    beat = beats[beatIndex];
  }

  Iterable<Beat> getBeats() {
    var beats = <Beat>[];
    for (var i = 0; i < count; i++) {
      beats.add(beat);
    }
    return beats;
  }
}
