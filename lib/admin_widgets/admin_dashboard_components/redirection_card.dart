import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_models/dashboard_headings.dart';

class RedirectionCard extends StatelessWidget {
  const RedirectionCard({
    Key? key,
    required this.dashboardHeadings,
  }) : super(key: key);

  final DashboardHeadings dashboardHeadings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Color(0xFFFED7BF),
      child: Column(
        children: [
          Text(dashboardHeadings.Heading!, style: Theme.of(context).textTheme.headlineMedium,),
          SizedBox(height: 20,),
          IconButton(onPressed: () {Navigator.of(context).pushNamed(dashboardHeadings.onTap!);},
            icon: Icon(Icons.arrow_circle_right_outlined),
            color: Color(0xFF9A7787),),
        ],
      ),
    );
  }
}