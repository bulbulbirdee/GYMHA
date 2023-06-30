import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/redirection_card.dart';
import 'package:gymha/admin_widgets/admin_models/dashboard_headings.dart';
import 'package:gymha/widgets/responsive.dart';

class UserRedirectNav extends StatelessWidget {
  const UserRedirectNav({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: SizedBox(
        //height: 300,
        width: 900,
        child:
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: UserRedirects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                3,
                childAspectRatio:
                1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
            ),
            itemBuilder: (context, index) => RedirectionCard(dashboardHeadings: UserRedirects[index])
        )
      )
    );
  }
}


class CourseRedirectNav extends StatelessWidget {
  const CourseRedirectNav({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 900,
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: CourseRedirects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
              ),
              itemBuilder: (context, index) => RedirectionCard(dashboardHeadings: CourseRedirects[index])
          ),
        ),
      ),
    );
  }
}

class SocialRedirectNav extends StatelessWidget {
  const SocialRedirectNav({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child:
      SizedBox(
        // height: 900,
        width: 900,
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: SocialRedirects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
            ),
            itemBuilder: (context, index) => RedirectionCard(dashboardHeadings: SocialRedirects[index])
        ),
      ),
    );
  }
}

class CounsellingRedirectNav extends StatelessWidget {
  const CounsellingRedirectNav({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child:
      SizedBox(
        width: 900,
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: CounsellingRedirects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              // crossAxisSpacing: ,
              // mainAxisSpacing: 5
            ),
            itemBuilder: (context, index) => RedirectionCard(dashboardHeadings: CounsellingRedirects[index])
        ),
      ),
    );
  }
}