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
      child:
      SizedBox(
        width: 900,
        child: ResponsiveWidget(
          smallScreen: RedirectGrid(crossAxisCount: 2, childAspectRatio: 1.8,),
          largeScreen: RedirectGrid(),
          mediumScreen: RedirectGrid(crossAxisCount: 2, childAspectRatio: 3,),),
      ),
    );
  }
}

class RedirectGrid extends StatelessWidget {
  const RedirectGrid({
    Key? key,
     this.crossAxisCount = 3,
     this.childAspectRatio = 1.7,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: UserRedirects.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
        ),
        itemBuilder: (context, index) => RedirectionCard(dashboardHeadings: UserRedirects[index])
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
      SizedBox(
        width: 900,
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: CourseRedirects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
            ),
            itemBuilder: (context, index) => RedirectionCard(dashboardHeadings: CourseRedirects[index])
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
                childAspectRatio: 1.5,
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