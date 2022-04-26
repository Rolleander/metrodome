import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Ping extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _PingState();

}

class _PingState extends State<Ping>{

  late Timer _timer;

  _PingState(){
    _timer =  Timer.periodic(const Duration(milliseconds: 200), _pingCallback);
  }

  _pingCallback(Timer timer){

  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return  const FlutterLogo(
      size: 200.0,
    );
  }

}