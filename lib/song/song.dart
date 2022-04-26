import 'dart:convert';

import 'package:metrodome/song/time_signature.dart';

class Song {
  late String name;
  late TimeSignature baseTime;
  late int baseBpm;

  Song(String json) {
    Map data = jsonDecode(json);
    name = data['name'];
    baseTime = TimeSignature(data['time']);
    baseBpm = int.parse(data['bpm']);
  }
}
