import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class PlayButton extends StatefulWidget {
  final Function function;

  const PlayButton({Key key, this.function}) : super(key: key);
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: Duration(milliseconds: 1000),
      glowColor: Colors.white,
      endRadius: 70.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: MaterialButton(
        onPressed: () {
          print("GO");
        },
        elevation: 20.0,
        shape: CircleBorder(),
        child: Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(160.0)),
          child: IconButton(
            onPressed: widget.function,
            icon: Icon(CupertinoIcons.mic),
            iconSize: 40.0,
          ),
        ),
      ),
    );
  }
}
