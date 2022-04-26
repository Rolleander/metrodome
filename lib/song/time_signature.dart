class TimeSignature {
  late int count;
  late int note;

  TimeSignature(String signature){
      final splitted = signature.split('/');
      count = int.parse(splitted[0]);
      note = int.parse(splitted[1]);
  }

}
