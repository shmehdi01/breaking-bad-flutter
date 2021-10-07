import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap_widget/gap_widget.dart';

class ErrorScreen extends StatelessWidget {

  final String errorTitle;
  final String errorMessage;

  const ErrorScreen({Key? key, required this.errorTitle, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Icon(Icons.error_outline_outlined, color: Colors.redAccent, size: 50,),
            VerticalGap.v16,
            Text(errorTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            VerticalGap.v12,
            Text(errorMessage, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),)
          ],
        ),
      ),
    );
  }
}
