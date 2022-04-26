class TimeSignature {
  static const secondsPerMinute = 60;
  static const millisPerSecond = 1000;
  late int count;
  late int note;

  TimeSignature(String signature){
      final splitted = signature.split('/');
      count = int.parse(splitted[0]);
      note = int.parse(splitted[1]);
  }

  int calcNoteDuration(int bpm){
    var beatsPerSecond =  bpm / secondsPerMinute;
    var beatDuration =  millisPerSecond / beatsPerSecond;
    return beatDuration ~/ note;
  }

}
