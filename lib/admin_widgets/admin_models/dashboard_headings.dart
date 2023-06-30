import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_util/constant_routes.dart';

class DashboardHeadings{

  final String? Heading, onTap;

  DashboardHeadings({this.onTap, this.Heading});
}

List<DashboardHeadings> UserRedirects = [
  DashboardHeadings(Heading: "View Users",onTap: adminViewUsers),
  DashboardHeadings(Heading: "Edit Users", onTap: adminEditUsers),
  DashboardHeadings(Heading: "Delete Users", onTap: adminEditUsers),
  ];

List<DashboardHeadings> CourseRedirects = [
  DashboardHeadings(Heading: "Create New Courses", onTap: adminCourses),
  DashboardHeadings(Heading: "Edit/Delete Courses", onTap: adminEditUsers),
];

List<DashboardHeadings> SocialRedirects = [
  DashboardHeadings(Heading: "Create NewsLetters", onTap: adminNewsletter),
  DashboardHeadings(Heading: "Upload Pictures to Gallery", onTap: adminGallery),
];

List<DashboardHeadings> CounsellingRedirects = [
  DashboardHeadings(Heading: "Check Counselling Requests", onTap: adminCounseling),
  // DashboardHeadings(Heading: "Edit Users"),
  // DashboardHeadings(Heading: "Delete Users"),
];