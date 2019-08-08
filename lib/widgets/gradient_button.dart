import 'package:flutter/material.dart';
import 'package:rutgers_flutter_mock/resources.dart';

/// A button with a diagonal gradient from [Colors.red] to [pantone186]
class GradientButton extends StatelessWidget {
  /// The text to display
  final String title;

  /// What to do when the button is clicked
  final void Function() onPressed;

  /// If true, shows a big square button instead of a small rectangular button
  final bool isBigSquare;

  /// How big should it be?
  /// 130 by default (used for the role buttons). Sometimes it's good to have
  /// it bigger, e.g. it's 160 on OnboardingLoginPage and 170 on
  /// My Day and My Dashboard.
  /// TODO: Is there a way of only allowing the text to wrap at spaces?
  final double size;

  GradientButton(
      {@required this.title,
      @required this.onPressed,
      @required this.isBigSquare,
      this.size = 130});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
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
            constraints: BoxConstraints.loose(
                isBigSquare ? Size.square(size) : Size.fromWidth(size)),
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(title,
                  style: isBigSquare
                      ? bigTextStyle.copyWith(color: Colors.white)
                      : TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            )),
          ),
        ),
      ),
    );
  }
}
