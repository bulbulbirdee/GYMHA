import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymha/widgets/newsletter_widgets/blog_panel.dart';
import 'package:gymha/widgets/newsletter_widgets/body_panel.dart';
import 'package:gymha/widgets/newsletter_widgets/header_panel.dart';
import 'package:gymha/widgets/newsletter_widgets/top_background.dart';


class NewsletterScreen extends StatelessWidget {
  const NewsletterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFdde9e9),
      body: SafeArea(
        child: Stack(
          children: [
              TopBackground(),
              SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeaderPanel(),
                  BodyPanel(),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Newsletters').snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
                      {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => BlogPanel(
                              snap: snapshot.data!.docs[index].data(),
                            ),
                        );

                      }
                  )
                  //
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
