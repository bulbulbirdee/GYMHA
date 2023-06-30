import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gymha/admin_widgets/admin_counseling.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_course_list.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_course_section.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_courses.dart';

import 'package:gymha/admin_widgets/admin_dashboard.dart';
import 'package:gymha/admin_widgets/admin_edit_users.dart';
import 'package:gymha/admin_widgets/admin_gallery.dart';
import 'package:gymha/admin_widgets/admin_newsletter.dart';
import 'package:gymha/admin_widgets/admin_view_users.dart';
import 'package:gymha/admin_widgets/admin_util/constant_routes.dart';
import 'package:gymha/arguments/course_argument.dart';
import 'package:gymha/authentication/forgot_password/otp_screen.dart';
import 'package:gymha/authentication/login_page.dart';

import 'package:gymha/authentication/signup_page.dart';
import 'package:gymha/controllers/MenuController.dart';
import 'package:gymha/screens/admin_page.dart';
import 'package:gymha/screens/details/course_details.dart';

import 'package:gymha/screens/home_page.dart';
import 'package:gymha/screens/user_side_screens/profile_screen.dart';
import 'package:gymha/screens/shopping/shopping_cart_screen.dart';
import 'package:gymha/screens/user_page.dart';
import 'package:gymha/screens/user_side_screens/newsletter_screen.dart';
import 'package:gymha/screens/user_side_screens/user_gallery.dart';
import 'package:gymha/services/authentication_repository.dart';
import 'package:gymha/widgets/course_widgets/lesson_view.dart';
import 'package:gymha/widgets/dashboard.dart';

import 'package:provider/provider.dart';



Future <void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCrcR9epeKi2gALrFEWkZv5sFNb87ir6Bs",
        appId: "1:616696586233:web:d7c572fd8a5c29e1f72728",
        messagingSenderId: "616696586233",
        projectId: "gymha-88b25",
        storageBucket: 'gs://gymha-88b25.appspot.com'
    )
  );

 // await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String courseDetails = '/courseDetails';
  static const String homePage = '/homePage';
  static const String shoppingCart = '/shoppingCart';
 // static const String adminBlog = '/adminBlog';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

     // getPages: RouteClass.route(),

      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),

      routes: {
        shoppingCart: (context) => const ShoppingCartScreen(),
        //adminBlog: (context) => const AdminBlog()
      },



      onGenerateRoute: (settings) {
        // if (settings.name == courseDetails) {
        //   final args = settings.arguments as CourseArgument;
        //   return MaterialPageRoute(
        //       builder: (context) => CourseDetails(course: args.course));
        // }
        if (settings.name == homePage) {
          return MaterialPageRoute(
              builder: (context) => HomePage());
        }
        if (settings.name == adminNewsletter) {
          // final args = settings.arguments as CourseArgument;
          return MaterialPageRoute(
              builder: (context) => AdminNewsletter());
        }
        if (settings.name == adminCounseling) {
          // final args = settings.arguments as CourseArgument;
          return MaterialPageRoute(
              builder: (context) => AdminCounseling());
        }
        if (settings.name == adminEditUsers) {
          // final args = settings.arguments as CourseArgument;
          return MaterialPageRoute(
              builder: (context) => AdminEditUsers());
        }
        if (settings.name == adminViewUsers) {
          // final args = settings.arguments as CourseArgument;
          return MaterialPageRoute(
              builder: (context) => AdminViewUsers());
        }
        if (settings.name == adminCourses) {
          // final args = settings.arguments as CourseArgument;
          return MaterialPageRoute(
              builder: (context) => AdminCourses());
        }


        if (settings.name == adminGallery) {
          // final args = settings.arguments as CourseArgument;
          return MaterialPageRoute(
              builder: (context) => AdminGallery());
        }

      },


      debugShowCheckedModeBanner: false,

      // home: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(
      //         create: (content) => MenuController(),
      //     )
      //   ],
      //   child: LoginPage()

      home:

      //LessonView()
      //CourseListPage()
      //AdminCourseSection()
      //AdminCourses()



      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){

          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              User? user = FirebaseAuth.instance.currentUser;
              var kk = FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user!.uid)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  if (documentSnapshot.get('role') == "admin") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  AdminDashboard(),
                      ),
                    );
                  }else{
                    //  print("Admin");
                    Navigator.push(context, MaterialPageRoute(
                      builder: (c) {
                        var changeNotifierProvider = ChangeNotifierProvider(
                            create: (context) => MenuController(),
                            child: UserPage()
                        );
                        return changeNotifierProvider;
                      },
                    ),
                    );
                  }
                } else {
                  print('Some issue occured');
                }
              });
            }
            else if(snapshot.hasError){
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
        return HomePage();

        },

      ),






        //NewsletterScreen()
        //UserGallery(),
     // ),
          //AdminGallery()
        //UserPage()
       // HomePage(),
      //LoginPage()
      //AdminPage()
    );
  }
}

class Dashboard {
}

