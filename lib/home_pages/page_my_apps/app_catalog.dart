import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/widgets/link_text.dart';

/// All the [App]s are defined here. I would call them "widgets", but that
/// obviously conflicts with Flutter.
///
/// This file also defines the default favorites for each role.

final residenceLife = App(
  tag: "link_residence_life",
  title: "Residence Life",
  url:
      "https://oncampus.rutgers.edu/hmswebstudent/Login.asp?TargetPage=Default.asp?",
  iconData: Icons.home,
);

final textbookRentals = App(
  tag: "link_textbook_rentals",
  title: "Textbook rentals",
  url:
      "http://rutgers.bncollege.com/webapp/wcs/stores/servlet/BNCBRentalView?langId=-1&storeId=58552&catalogId=10001",
  iconData: Icons.book,
  inactive: true,
  inactiveExplanation: LinkText(
    children: [
      "The Barnes and Noble textbook rentals website is currently down. Service is expected to be restored shortly.\n\n"
          "Updates will be posted to the ",
      Link(
        text: "Rutgers University Bookstore Facebook page",
        url: "https://www.facebook.com/rubookstore",
        linkTitle: "Rutgers University Bookstore",
      ),
      ".",
    ],
  ),
);

final handshake = App(
  tag: "link_handshake",
  title: "Handshake",
  url: "https://app.joinhandshake.com/auth?auth=590",
  assetString: "assets/logo_handshake.png",
);

final learningCentersNB = App(
  tag: "link_learning_centers_nb",
  title: "Learning Centers (New Brunswick)",
  url: "https://rlc.rutgers.edu/",
  iconData: Icons.local_library,
);

final universityMap = App(
  tag: "link_university_map",
  title: "University map",
  url: "https://maps.rutgers.edu/",
  iconData: Icons.map,
);

final studentHealth = App(
  tag: "link_student_health",
  title: "Student Health",
  url: "http://health.rutgers.edu/",
  iconData: Icons.local_hospital,
);

final ruParentsBlog = App(
  tag: "link_ru_parents_blog",
  title: "RU Parents Blog",
  url: "http://rublogs.rutgers.edu/parents/",
  iconData: Icons.computer,
);

final ruStudentsBlog = App(
  tag: "link_ru_students_blog",
    title: "RU Students Blog",
    url: "https://rustudentblogs.wordpress.com/",
    iconData: Icons.computer,
    inactive: true,
    inactiveExplanation: LinkText(
      children: [
        "The RU Students Blog is currently down due to scheduled maintenance. Service is expected to be restored by 5:00 PM."
      ],
    ));

final ruaa = App(
  tag: "link_ruaa",
  title: "Rutgers University Alumni Association website",
  url: "http://www.ralumni.com/",
  iconData: Icons.people,
);

final employmentOpportunities = App(
  tag: "link_employment_opportunities",
  title: "Employment opportunities",
  url: "https://jobs.rutgers.edu/postings/search",
  iconData: Icons.work,
);

final placesToEat = App(
  tag: "link_places_to_eat",
  title: "Places to eat",
  url: "http://food.rutgers.edu/places-to-eat/",
  iconData: Icons.fastfood,
);

final orcid = App(
  tag: "link_orcid",
  title: "Update or create Open Researcher and Contributor ID",
  url: "https://personalinfo.rutgers.edu/pi/updateOrcid.htm",
  assetString: "assets/logo_orcid.png",
);

final rutgersFacebook = App(
  tag: "link_rutgers_facebook",
  title: "Rutgers on Facebook",
  url: "https://www.facebook.com/RutgersU/",
  assetString: "assets/logo_facebook.png",
);

final rutgersSubreddit = App(
  tag: "link_rutgers_subreddit",
  title: "Rutgers subreddit",
  url: "https://www.reddit.com/r/rutgers/",
  assetString: "assets/logo_reddit.png",
);

final scarletKnights = App(
  tag: "link_scarlet_knights",
  title: "Scarlet Knights",
  url: "http://www.scarletknights.com/index-main.html",
  assetString: "assets/logo_scarlet_knights.png",
);

final goRutgers = App(
  tag: "link_go_rutgers",
  title: "Go Rutgers",
  url: "http://go-rutgers.com",
  assetString: "assets/logo_go_rutgers.jpeg",
);

/// Map of [App.tag] to [App]
final allApps = Map<String, App>.fromIterable(
  <App>[
    residenceLife,
    textbookRentals,
    handshake,
    learningCentersNB,
    universityMap,
    studentHealth,
    ruParentsBlog,
    ruStudentsBlog,
    ruaa,
    employmentOpportunities,
    placesToEat,
    orcid,
    rutgersFacebook,
    rutgersSubreddit,
    scarletKnights,
    goRutgers,
  ],
  key: (dynamic element) => (element as App).tag,
);

final currentStudentDefaultFavoriteApps = <App>[
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

final facultyDefaultFavoriteApps = <App>[
  orcid,
  placesToEat,
];

final staffDefaultFavoriteApps = <App>[
  placesToEat,
];

final admittedStudentDefaultFavoriteApps = <App>[
  universityMap,
  employmentOpportunities,
  goRutgers,
  ruStudentsBlog,
  rutgersSubreddit,
  scarletKnights,
];

final parentDefaultFavoriteApps = <App>[
  ruParentsBlog,
  rutgersFacebook,
  scarletKnights,
];

// Never seen in mockup
final alumnusDefaultFavoriteApps = <App>[
  ruaa,
  scarletKnights,
  rutgersSubreddit,
  placesToEat,
];

final guestDefaultFavoriteApps = <App>[
  universityMap,
  placesToEat,
  scarletKnights,
];
