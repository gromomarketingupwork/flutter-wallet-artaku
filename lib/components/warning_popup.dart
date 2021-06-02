import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      height: 210,
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "WARNING",
            style: header4.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "It’s critical you backup your account using the passphrase on this screen. We cannot reset or restore your account without this passphrase.",
            style: header4.copyWith(
                fontWeight: FontWeight.w400, color: ANColorNew.warning),
          ),
          SizedBox(
            height: 14,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "OK",
                  style: header4.copyWith(color: ANColorNew.primary),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
