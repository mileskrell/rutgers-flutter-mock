import 'package:flutter/material.dart';
import 'package:rutgers_flutter_mock/widgets/link_text.dart';

/// Contains app-wide resources

const pantone186 = const Color(0xffcc0033);
const pantone431 = const Color(0xff5f6a72);

const appTitle = "Rutgers";

const bigTextStyle = const TextStyle(fontSize: 22);

// SharedPreferences keys
const keyRole = "role";
const keyLoggedIn = "logged_in";
const keyHasCompletedTutorial = "has_completed_tutorial";
const keyFavoriteApps = "favorite_apps";
const keyHomePage = "home_page";

// Other strings
const communityID = "CommunityID";
const communityIDExplanation = [
  "A CommunityID account is used to access applications by the "
      "extended community of Rutgers University."
      "\n\nIf you have not yet created a CommunityID, you can do so ",
  Link(text: "here", url: "https://rcm.rutgers.edu", linkTitle: "CommunityID"),
  "."
];
const communityIdUrl =
    "data:text/html,<!DOCTYPE html><p>This would be the CommunityID login page</p>";

const netID = "NetID";
const netIDExplanation = [
  "All faculty, staff, students and guests are assigned a "
      "Rutgers unique identifier known as a NetID, comprised of "
      "initials and a unique number (e.g. jqs23)."
      "\n\nIf you have not yet activated your NetID, you can do so ",
  Link(text: "here", url: "https://netid.rutgers.edu", linkTitle: "NetID"),
  "."
];
const netIdUrl =
    "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login";
