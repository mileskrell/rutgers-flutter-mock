import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/widgets/link_text.dart';

/// All the [App]s are defined here. I would call them "widgets", but that
/// obviously conflicts with Flutter.
///
/// This file also defines the default favorites for each role.

const learningCentersNB = App(
  tag: "link_learning_centers_nb",
  title: "Learning Centers (New Brunswick)",
  url: "https://rlc.rutgers.edu/",
  iconData: Icons.local_library,
);

const textbookRentals = App(
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

const orcid = App(
  tag: "link_orcid",
  title: "Update or create Open Researcher and Contributor ID",
  url: "https://personalinfo.rutgers.edu/pi/updateOrcid.htm",
  assetString: "assets/logo_orcid.png",
);

const academicSupport = AppCategory(
  title: "Academic Support",
  apps: [
    learningCentersNB,
    textbookRentals,
    orcid,
  ],
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const residenceLifeHousing = App(
  tag: "link_residence_life_housing",
  title: "Residence Life (housing)",
  url:
      "https://oncampus.rutgers.edu/hmswebstudent/Login.asp?TargetPage=Default.asp?",
  iconData: Icons.home,
);

const handshake = App(
  tag: "link_handshake",
  title: "Handshake",
  url: "https://app.joinhandshake.com/auth?auth=590",
  assetString: "assets/logo_handshake.png",
);

const employmentOpportunities = App(
  tag: "link_employment_opportunities",
  title: "Employment opportunities",
  url: "https://jobs.rutgers.edu/postings/search",
  iconData: Icons.work,
);

const placesToEat = App(
  tag: "link_places_to_eat",
  title: "Places to eat",
  url: "http://food.rutgers.edu/places-to-eat/",
  iconData: Icons.fastfood,
);

const universityMap = App(
  tag: "link_university_map",
  title: "University map",
  url: "https://maps.rutgers.edu/",
  iconData: Icons.map,
);

const studentHealth = App(
  tag: "link_student_health",
  title: "Student Health",
  url: "http://health.rutgers.edu/",
  iconData: Icons.local_hospital,
);

const campusServices = AppCategory(
  title: "Campus Services",
  apps: [
    residenceLifeHousing,
    handshake,
    employmentOpportunities,
    placesToEat,
    universityMap,
    studentHealth,
  ],
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const canvas = App(
  tag: "link_canvas",
  title: "Canvas",
  url: "https://rutgers.instructure.com/login/saml/",
  assetString: "assets/logo_canvas.png",
  isNew: true,
);

const sakai = App(
  tag: "link_sakai",
  title: "Sakai",
  url: "https://sakai.rutgers.edu/portal/login",
  assetString: "assets/logo_sakai.png",
);

const classesAndDegree = AppCategory(
  title: "Classes and Degree",
  apps: [
    canvas,
    sakai,
  ],
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const rutgersConnect = App(
  tag: "link_rutgers_connect",
  title: "Rutgers Connect",
  url: "https://connect.rutgers.edu/",
  assetString: "assets/logo_office_365.png",
);

const scarletMail = App(
  tag: "link_scarletmail",
  title: "ScarletMail",
  url: "http://mail.scarletmail.rutgers.edu",
  assetString: "assets/logo_gmail.png",
);

const computingServices = AppCategory(
  title: "Computing Services",
  apps: [
    rutgersConnect,
    scarletMail,
  ],
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const officeOfFinancialAid = App(
  tag: "link_office_of_financial_aid",
  title: "Office of Financial Aid",
  url: "https://financialaid.rutgers.edu/",
  iconData: Icons.attach_money,
);

const healthInsuranceWaiverPolicy = App(
  tag: "link_health_insurance_waiver_policy",
  title: "Health Insurance Waiver Policy",
  url:
      "http://riskmanagement.rutgers.edu/student-information/student-health-insurance",
  iconData: Icons.healing,
  isNew: true,
);

const financialAidAwardStatus = App(
  tag: "link_financial_aid_award_status",
  title: "Financial Aid Award Status",
  url: "https://finservices.rutgers.edu/faaward/letter/awardLogin.htm",
  iconData: Icons.attach_money,
);

const financialInformation = AppCategory(
  title: "Financial Information",
  apps: [
    officeOfFinancialAid,
    healthInsuranceWaiverPolicy,
    financialAidAwardStatus,
  ],
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const officialGrades = App(
  tag: "link_official_grades",
  title: "Official Grades",
  url: "https://my.rutgers.edu/service/my-grades",
  iconData: Icons.list
);

const transcriptRequestApplicationAndForms = App(
  tag: "link_transcript_request_application_and_forms",
  title: "Transcript Request Application and Forms",
  url:
      "https://transcripts.rutgers.edu/transcripts/displayRutgersRbhsFormerStudentSearchPage.html",
  iconData: Icons.list,
);

const gradesAndRecords = AppCategory(title: "Grades and Records", apps: [
  officialGrades,
  transcriptRequestApplicationAndForms,
]);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const rutgersFacebook = App(
  tag: "link_rutgers_facebook",
  title: "Rutgers on Facebook",
  url: "https://www.facebook.com/RutgersU/",
  assetString: "assets/logo_facebook.png",
);

const rutgersSubreddit = App(
  tag: "link_rutgers_subreddit",
  title: "Rutgers Subreddit",
  url: "https://www.reddit.com/r/rutgers/",
  assetString: "assets/logo_reddit.png",
  isNew: true,
);

const ruParentsBlog = App(
  tag: "link_ru_parents_blog",
  title: "RU Parents Blog",
  url: "http://rublogs.rutgers.edu/parents/",
  iconData: Icons.computer,
);

const ruStudentsBlog = App(
    tag: "link_ru_students_blog",
    title: "RU Students Blog",
    url: "https://rustudentblogs.wordpress.com/",
    iconData: Icons.computer,
    isNew: true,
    inactive: true,
    inactiveExplanation: LinkText(
      children: [
        "The RU Students Blog is currently down due to scheduled maintenance. Service is expected to be restored by 5:00 PM."
      ],
    ));

const ruaa = App(
  tag: "link_ruaa",
  title: "Rutgers University Alumni Association website",
  url: "http://www.ralumni.com/",
  iconData: Icons.people,
);

const scarletKnights = App(
  tag: "link_scarlet_knights",
  title: "Scarlet Knights",
  url: "http://www.scarletknights.com/index-main.html",
  assetString: "assets/logo_scarlet_knights.png",
);

const studentLife = AppCategory(
  title: "Student Life",
  apps: [
    rutgersFacebook,
    rutgersSubreddit,
    ruParentsBlog,
    ruStudentsBlog,
    ruaa,
    scarletKnights,
  ],
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// This one isn't an actual category on myRutgers

const goRutgers = App(
  tag: "link_go_rutgers",
  title: "Go Rutgers",
  url: "http://go-rutgers.com",
  assetString: "assets/logo_go_rutgers.jpeg",
);

const newStudentResources = AppCategory(
  title: "New Student Resources",
  apps: [
    goRutgers,
  ],
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const allAppCategories = {
  academicSupport,
  campusServices,
  classesAndDegree,
  computingServices,
  financialInformation,
  gradesAndRecords,
  studentLife,
  newStudentResources,
};

/// Map of [App.tag] to [App]
final allApps = Map<String, App>.fromIterable(
  allAppCategories.expand<App>((category) => category.apps),
  key: (dynamic element) => (element as App).tag,
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// App category order for each role

const currentStudentAppCategories = [
  classesAndDegree,
  gradesAndRecords,
  financialInformation,
  academicSupport,
  campusServices,
  studentLife,
  computingServices,
  newStudentResources,
];

const facultyAppCategories = [
  campusServices,
  computingServices,
  classesAndDegree,
  studentLife,
  academicSupport,
  financialInformation,
  gradesAndRecords,
  newStudentResources,
];

const staffAppCategories = [
  campusServices,
  computingServices,
  studentLife,
  classesAndDegree,
  academicSupport,
  financialInformation,
  gradesAndRecords,
  newStudentResources,
];

const admittedStudentAppCategories = [
  newStudentResources,
  campusServices,
  studentLife,
  computingServices,
  classesAndDegree,
  academicSupport,
  financialInformation,
  gradesAndRecords,
];

const parentAppCategories = [
  financialInformation,
  studentLife,
  campusServices,
  computingServices,
  classesAndDegree,
  academicSupport,
  gradesAndRecords,
  newStudentResources,
];

const alumnusAppCategories = [
  studentLife,
  campusServices,
  computingServices,
  classesAndDegree,
  academicSupport,
  financialInformation,
  gradesAndRecords,
  newStudentResources,
];

const guestAppCategories = [
  campusServices,
  computingServices,
  classesAndDegree,
  studentLife,
  academicSupport,
  financialInformation,
  gradesAndRecords,
  newStudentResources,
];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// Default favorite apps for each role

const currentStudentDefaultFavoriteApps = [
  canvas,
  sakai,
  handshake,
  textbookRentals,
  ruStudentsBlog,
];

const facultyDefaultFavoriteApps = [
  orcid,
  placesToEat,
];

const staffDefaultFavoriteApps = [
  placesToEat,
];

const admittedStudentDefaultFavoriteApps = [
  universityMap,
  goRutgers,
  ruStudentsBlog,
  rutgersSubreddit,
  scarletKnights,
];

const parentDefaultFavoriteApps = [
  ruParentsBlog,
  rutgersFacebook,
  scarletKnights,
];

const alumnusDefaultFavoriteApps = <App>[
  ruaa,
  scarletKnights,
  rutgersSubreddit,
  placesToEat,
];

const guestDefaultFavoriteApps = <App>[
  universityMap,
  placesToEat,
  scarletKnights,
];
