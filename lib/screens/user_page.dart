import 'package:flutter/material.dart';
import 'package:gymha/controllers/MenuController.dart';
import 'package:gymha/widgets/dashboard.dart';
import 'package:gymha/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: Container(
        color: Color(0xFFff02fd),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (MediaQuery.of(context).size.width > 1200)
            const Expanded(
                  child: SideMenu()
              ),
              const Expanded(
                flex: 5,
                  child: DashboardScreen(),
              ),
            ],
          )
        ),
      )
    );
  }
}



