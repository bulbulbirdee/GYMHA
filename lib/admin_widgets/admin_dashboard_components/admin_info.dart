import 'package:flutter/material.dart';

class AdminInfo extends StatelessWidget {
  const AdminInfo({
    Key? key, this.title, this.text,
  }) : super(key: key);

  final String? title, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title!,
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),),
          Text(text!, style:  TextStyle(color:  Colors.black87),),

        ],
      ),
    );
  }
}