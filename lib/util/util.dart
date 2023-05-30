import 'package:flutter/material.dart';
import 'package:gymha/main.dart';

class Util{

  static void showMessage(BuildContext context, String message){
    showMessageWithAction(context, message, null, null);
  }

  static void showMessageWithAction(BuildContext context, String message, String? actionLabel,
      VoidCallback? onPressed)
  {
    final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
    final SnackBar snackBar = SnackBar(content: Text("your snackbar message"));
    snackbarKey.currentState?.showSnackBar(snackBar);
    // scaffold.showSnackBar(
    //     SnackBar(
    //   // backgroundColor: Colors.grey.shade900,
    //   //   behavior: SnackBarBehavior.floating,
    //   //   margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    //     // action: actionLabel != null
    //     // ? SnackBarAction(label: actionLabel, onPressed: onPressed!)
    //     // : ,
    //     content:Text(
    //       message,
    //       style: const TextStyle(color: Colors.white, fontSize: 17),
    //     )));
  }

  static void openShoppingCart(BuildContext context)
  {
    Navigator.pushNamed(context, '/shoppingCart');
  }

  // static void openAdminBlog(BuildContext context)
  // {
  //   Navigator.pushNamed(context, '/adminBlog');
  // }
}