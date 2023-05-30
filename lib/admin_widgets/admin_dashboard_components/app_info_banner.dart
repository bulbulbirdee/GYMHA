import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/anime_holder.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/top_info_card.dart';
import 'package:gymha/widgets/responsive.dart';

class AppInfoBanner extends StatelessWidget {
  const AppInfoBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 7,
        child: SingleChildScrollView(
            child: ResponsiveWidget.isLargeScreen(context)?
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
             // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    top_info_card(fig: 2048, title: "USERS",),
                    top_info_card(fig: 74, title: "NEWSLETTERS"),
                    top_info_card(fig: 43, title: "COUNSELLING REQUESTS")
                  ],
                )
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width/1.2,),
                AnimeHolder(fig1: 2048, title1: 'USERS',fig2: 74, title2: 'NEWSLETTERS', fig3: 43, title3: 'COUNSELLING REQUESTS')

              ],
            )
        )
    );
  }
}