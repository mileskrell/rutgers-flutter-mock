import 'package:flutter/material.dart';

class EyeReveal extends StatefulWidget {
  final String text;

  EyeReveal(this.text);

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
              child: Text(widget.text),
            ),
            Opacity(
              opacity: revealed ? 0 : 1,
              child: Icon(Icons.remove_red_eye),
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
