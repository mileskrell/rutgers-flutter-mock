import 'package:flutter/material.dart';

import 'package:rutgers_basic_flutter_mock/widgets/my_apps_app_widget.dart';

final residenceLife = App(
  title: "Residence Life",
  url:
      "https://oncampus.rutgers.edu/hmswebstudent/Login.asp?TargetPage=Default.asp?",
  iconData: Icons.home,
);

final textbookRentals = App(
  title: "Textbook rentals",
  url:
      "http://rutgers.bncollege.com/webapp/wcs/stores/servlet/BNCBRentalView?langId=-1&storeId=58552&catalogId=10001",
  iconData: Icons.book,
);

final handshake = App(
  title: "Handshake",
  url: "https://app.joinhandshake.com/auth?auth=590",
  assetString: "assets/logo_handshake.png",
);

final learningCentersNB = App(
  title: "Learning Centers (New Brunswick)",
  url: "https://rlc.rutgers.edu/",
  iconData: Icons.local_library,
);

final universityMap = App(
  title: "University map",
  url: "https://maps.rutgers.edu/",
  iconData: Icons.map,
);

final studentHealth = App(
  title: "Student Health",
  url: "http://health.rutgers.edu/",
  iconData: Icons.local_hospital,
);

final ruParentsBlog = App(
  title: "RU Parents Blog",
  url: "http://rublogs.rutgers.edu/parents/",
  iconData: Icons.computer,
);

final ruStudentsBlog = App(
  title: "RU Students Blog",
  url: "https://rustudentblogs.wordpress.com/",
  iconData: Icons.computer,
);

final ruaa = App(
  title: "Rutgers University Alumni Association website",
  url: "http://www.ralumni.com/",
  iconData: Icons.people,
);

final employmentOpportunities = App(
  title: "Employment opportunities",
  url: "https://jobs.rutgers.edu/postings/search",
  iconData: Icons.work,
);

final placesToEat = App(
  title: "Places to eat",
  url: "http://food.rutgers.edu/places-to-eat/",
  iconData: Icons.fastfood,
);

final orcid = App(
  title: "Update or create Open Researcher and Contributor ID",
  url: "https://personalinfo.rutgers.edu/pi/updateOrcid.htm",
  iconData: Icons.settings_backup_restore,
);

final rutgersFacebook = App(
  title: "Rutgers on Facebook",
  url: "https://www.facebook.com/RutgersU/",
  assetString: "assets/logo_facebook.png",
);

final rutgersSubreddit = App(
  title: "Rutgers subreddit",
  url: "https://www.reddit.com/r/rutgers/",
  assetString: "assets/logo_reddit.png",
);

final scarletKnights = App(
  title: "Scarlet Knights",
  url: "http://www.scarletknights.com/index-main.html",
  assetString: "assets/logo_scarlet_knights.png",
);

final goRutgers = App(
  title: "Go Rutgers",
  url: "http://go-rutgers.com",
  assetString: "assets/logo_go_rutgers.jpeg",
);

final currentStudentApps = [
  universityMap,
  handshake,
  learningCentersNB,
  textbookRentals,
  residenceLife,
  studentHealth,
  rutgersSubreddit,
  employmentOpportunities,
  placesToEat,
  ruStudentsBlog,
  scarletKnights,
];

// Never seen in mockup
final facultyApps = <App>[
  orcid,
  placesToEat,
];

// Never seen in mockup
final staffApps = <App>[
  placesToEat,
];

final admittedStudentApps = [
  universityMap,
  employmentOpportunities,
  goRutgers,
  ruStudentsBlog,
  rutgersSubreddit,
  scarletKnights,
];

final parentApps = <App>[
  ruParentsBlog,
  rutgersFacebook,
  scarletKnights,
];
final alumnusApps = <App>[
  ruaa,
  scarletKnights,
  rutgersSubreddit,
  placesToEat,
];

final guestApps = [
  universityMap,
  placesToEat,
  scarletKnights,
];
