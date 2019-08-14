import 'package:flutter/material.dart';

/// A widget that switches between an eye icon and the provided text when
/// clicked. Used to hide sensitive information (grades, GPA, etc.)
///
/// If [color] is provided, then both the icon and [Text] will have
/// that color. Otherwise, both will be black.
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
    return InkWell(
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
