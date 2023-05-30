import 'package:gymha/model/course.dart';
import 'package:gymha/model/course_category.dart';
import 'package:gymha/model/lecture.dart';
import 'package:gymha/model/section.dart';

class CourseDataProvider {
  //Here I have already created courses & section list which we will we using hence forth

  //Section List
  static List<Section> sectionList = [
    Section("INTRODUCTION", [
      Lecture("Reason for the course", "01:48 mins"),
      Lecture("So why is mental health awareness in the workplace important?", "05:54 mins"),
    ]),
    Section("INSTRUCTOR KNOWLEDGE UPDATE", [
      Lecture("Pre/Post Quiz", "02:25 mins"),
      Lecture("Skilled Workplace program", "05:17 mins"),
    ]),
    Section("STAFF QUESTIONNAIRE/EVALUATION", [
      Lecture("Questionnaire", "02:25 mins"),
    ]),
    Section("MODULES", [
      Lecture("Module 1: The Opportunity", "02:25 mins"),
      Lecture("Module 2: The Solution", "17:20 mins"),
      Lecture("Module 3: Resources", "11:10 mins"),
      Lecture("Module 4: Project Deliverable", "07:40 mins"),
      Lecture("Module 5: Benefits", "07:40 mins"),
    ]),
    Section("APPENDICES: OTHER ACTIVITIES & RESOURCESp", [
      Lecture("Pricing", "02:25 mins"),
      Lecture("Qualification", "05:17 mins"),
      Lecture("Conclusion", "07:40 mins"),
      Lecture("References", "11:10 mins"),
      Lecture("Other Resorces", "07:40 mins"),
    ]),
  ];

  static List<Section> sectionList2 = [
    Section("Introduction", [
      Lecture("Introduction", "01:48 mins"),
      Lecture("What is Flutter", "05:54 mins"),
      Lecture("Understanding Flutter Architecture", "04:45 mins"),
      Lecture("Flutter Alternatives", "06:10 mins"),
    ]),
    Section("Flutter Basics", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Creating New Project", "05:17 mins"),
      Lecture("Dart Basics", "17:20 mins"),
      Lecture("Dart Fundamentals", "11:10 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
    Section("Layouts", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Creating New Project", "05:17 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
    Section("Responsive & Adaptive UI", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Dart Basics", "17:20 mins"),
      Lecture("Dart Fundamentals", "11:10 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
    Section("Builing Real App", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Creating New Project", "05:17 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
    Section("Responsive & Adaptive UI", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Dart Basics", "17:20 mins"),
      Lecture("Dart Fundamentals", "11:10 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
  ];

  //Course List
  // static List<Course> courseList = [
  //   Course(
  //       "1",
  //       "Workplace Youth Mental Health",
  //       "assets/images/pic3.png",
  //       "Workplace Youth Mental Health (WYMH) aims to educate members of your community on mental health eliminate or reduce to the minimum stigma associated with mental illness, whilst educating people on the importance of mental health and workplace stress.",
  //       "GYMHA",
  //       "01-Jan-2022",
  //       4.2,
  //       false,
  //       CourseCategory.programming,
  //       10,
  //       '2.5 Hours',
  //       15,
  //       sectionList),
  //   Course(
  //       "2",
  //       "Emotional Intelligence Course",
  //       "assets/images/pic1.jpg",
  //       "Workplace Youth Mental Health (WYMH) aims to educate members of your community on mental health eliminate or reduce to the minimum stigma associated with mental illness, whilst educating people on the importance of mental health and workplace stress.",
  //       "GYMHA",
  //       "01-Apr-2022",
  //       4.5,
  //       false,
  //       CourseCategory.programming,
  //       50,
  //       '3 Hours',
  //       10,
  //       sectionList),
  //   Course(
  //       "3",
  //       "Psychological First Aid Course",
  //       "assets/images/pic2.png",
  //       "Workplace Youth Mental Health (WYMH) aims to educate members of your community on mental health eliminate or reduce to the minimum stigma associated with mental illness, whilst educating people on the importance of mental health and workplace stress.",
  //       "GYMHA",
  //       "01-Mar-2022",
  //       5,
  //       false,
  //       CourseCategory.programming,
  //       75,
  //       '2.7 Hours',
  //       15,
  //       sectionList),
  //   Course(
  //       "4",
  //       "Depression course",
  //       "assets/images/pic4.jpg",
  //       "Workplace Youth Mental Health (WYMH) aims to educate members of your community on mental health eliminate or reduce to the minimum stigma associated with mental illness, whilst educating people on the importance of mental health and workplace stress.",
  //       "GYMHA",
  //       "01-Jan-2022",
  //       4,
  //       false,
  //       CourseCategory.programming,
  //       40,
  //       '5 Hours',
  //       30,
  //       sectionList),
  //   Course(
  //       "5",
  //       "Holistic wellbeing course",
  //       "assets/images/pic5.jpg",
  //       "Workplace Youth Mental Health (WYMH) aims to educate members of your community on mental health eliminate or reduce to the minimum stigma associated with mental illness, whilst educating people on the importance of mental health and workplace stress.",
  //       "GYMHA",
  //       "01-Jan-2022",
  //       4.5,
  //       false,
  //       CourseCategory.programming,
  //       120,
  //       '4.3 Hours',
  //       25,
  //       sectionList),
  // ];
}