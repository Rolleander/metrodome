import 'package:flutter_test/flutter_test.dart';
import 'package:metrodome/song/song.dart';
import 'package:metrodome/song/song_player.dart';
import 'package:metrodome/song/time_signature.dart';

void main() async {
  final song = Song('''
  {
  "name": "Test",
  "bpm": 120,
  "time": "4/4",
  "beats": [
    {
      "label": "basic beat",
      "bars": 4
    }
  ],
  "parts": [
    {
      "beat": 0,
      "count": 4
    }
  ]
  }  
  ''');
  final player = SongPlayer(song);
  await for (final ping in player.play()) {
    print('ping $ping');
  }
}
