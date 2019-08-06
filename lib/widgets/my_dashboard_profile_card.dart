import 'package:flutter/material.dart';

/// A [Card] containing the user's profile image. Displayed in My Dashboard.
class ProfileCard extends StatelessWidget {
  final String name;
  final String assetName;

  ProfileCard(this.name, {this.assetName = "assets/profile_unknown.png"});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(assetName)),
        title: Text(name),
      ),
    );
  }
}
