
import 'package:flutter_test/flutter_test.dart';
import 'package:metrodome/song/time_signature.dart';

void main() {
  test('Calc note duration is correct', (){
    expect(TimeSignature("4/4").calcNoteDuration(60), 250);
    expect(TimeSignature("6/8").calcNoteDuration(60), 125);
  });
}
