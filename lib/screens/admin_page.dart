import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_responsive.dart';
import 'package:gymha/admin_widgets/desktop_scaffold.dart';
import 'package:gymha/admin_widgets/mobile_scaffold.dart';
import 'package:gymha/admin_widgets/tablet_scaffold.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: const MobileScaffold(),
      tabletBody: const TabletScaffold(),
      desktopBody: const DesktopScaffold(),

    );
  }
}
