import 'package:flutter/material.dart';
import 'package:rutgers_flutter_mock/resources.dart';

class SquareGradientButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final double padding;
  final double size;

  SquareGradientButton(
      {@required this.title,
      @required this.onPressed,
      this.padding = 8,
      this.size = 130});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        onPressed: () => onPressed(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red, pantone186],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size.square(size)),
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(4),
              child: Text(title,
                  style: bigTextStyle.copyWith(color: Colors.white),
                  textAlign: TextAlign.center),
            )),
          ),
        ),
      ),
    );
  }
}
