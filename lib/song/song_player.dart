import 'package:metrodome/song/song.dart';
import 'package:tuple/tuple.dart';

enum Ping { accent, plain }

class SongPlayer {
  final Song _song;
  final _stopwatch = Stopwatch();
  var _stop = false;
  var _pause = false;

  SongPlayer(this._song);

  Iterable<Ping> _getBeatPings(Beat beat) sync* {
    for (var note = 0; note < beat.getNotes(); note++) {
      if (note == 0) {
        yield Ping.accent;
      } else {
        yield Ping.plain;
      }
    }
  }

  Iterable<Tuple2<Ping, int>> _getPings() sync* {
    for (var beat in _song.allBeats()) {
      final noteDuration = beat.time.calcNoteDuration(beat.bpm);
      for (var ping in _getBeatPings(beat)) {
        yield Tuple2(ping, noteDuration);
      }
    }
  }

  Stream<Ping> play() async* {
    _stop = false;
    _stopwatch.reset();
    _stopwatch.start();
    var duration = 0;
    var adjustDelay = 0;
    for (var ping in _getPings()) {
      final noteDuration = ping.item2;
      duration += noteDuration;
      var delay = duration - adjustDelay;
      yield ping.item1;
      await Future.delayed(Duration(milliseconds: delay));
      if (_pause) {
        await _waitForResume();
      }
      adjustDelay = getElapsedTime() - duration;
      if (_stop) {
        break;
      }
    }
    _stopwatch.stop();
  }

  Future<void> _waitForResume() async {
    while (!_stop && _pause) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _stopwatch.start();
  }

  int getElapsedTime() {
    return _stopwatch.elapsedMilliseconds;
  }

  void stop() {
    _stop = true;
  }

  void pause() {
    if (!_stop && !_pause) {
      _stopwatch.stop();
      _pause = true;
    }
  }

  void resume() {
    _pause = false;
  }
}
