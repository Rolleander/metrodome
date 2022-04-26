import 'package:metrodome/song/song.dart';
import 'package:tuple/tuple.dart';

enum Ping { accent, plain }

class SongPlayer {
  final Song _song;
  var _stop = false;

  SongPlayer(this._song);

  Iterable<Tuple2<Ping, int>> _getPings() sync* {
    for (var beat in _song.allBeats()) {
      final noteDuration = beat.time.calcNoteDuration(beat.bpm);
      for (var bar = 0; bar < beat.bars; bar++) {
        for (var note = 0; note < beat.time.count; note++) {
          if (note == 0) {
            yield Tuple2(Ping.accent, noteDuration);
          } else {
            yield Tuple2(Ping.plain, noteDuration);
          }
        }
      }
    }
  }

  Stream<Ping> play() async* {
    _stop = false;
    final stopwatch = Stopwatch();
    stopwatch.start();
    var expectedDuration = 0;
    var adjustDelay = 0;
    for (var ping in _getPings()) {
      final noteDuration = ping.item2;
      expectedDuration += noteDuration;
      final delay = expectedDuration - adjustDelay;
      yield ping.item1;
      await Future.delayed(Duration(milliseconds: delay));
      adjustDelay = stopwatch.elapsedMilliseconds - expectedDuration;
      if (_stop) {
        break;
      }
    }
    stopwatch.stop();
  }

  void stop() {
    _stop = true;
  }
}
