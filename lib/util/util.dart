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

  }

  static void openShoppingCart(BuildContext context)
  {
    Navigator.pushNamed(context, '/shoppingCart');
  }

}