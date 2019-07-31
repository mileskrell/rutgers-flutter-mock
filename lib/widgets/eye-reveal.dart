import 'package:flutter/material.dart';

class EyeReveal extends StatefulWidget {
  final String text;
  final Color color;

  EyeReveal(this.text, {this.color});

  @override
  State<StatefulWidget> createState() => EyeRevealState();
}

class EyeRevealState extends State<EyeReveal> {
  var revealed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: revealed ? 1 : 0,
              child: Text(
                widget.text,
                style: TextStyle(color: widget.color),
              ),
            ),
            Opacity(
              opacity: revealed ? 0 : 1,
              child: Icon(
                Icons.remove_red_eye,
                color: widget.color,
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            revealed = !revealed;
          });
        });
  }
}
