import 'package:etherwallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  CopyButton({this.text, this.value});

  final Text text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(150, 40),
        side: BorderSide(color: ANColor.white, width: 1),
      ),
      child: this.text,
      onPressed: () {
        Clipboard.setData(ClipboardData(text: this.value));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Copied"),
        ));
      },
    );
  }
}
