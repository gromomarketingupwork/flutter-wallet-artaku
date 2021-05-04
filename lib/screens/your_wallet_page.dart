import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class YourWalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _YourWalletPageState();
}

class _YourWalletPageState extends State<YourWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(
        appBar: AppBar(),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Your Wallet Address",
              style: header1.copyWith(color: ANColor.backgroundText),
            ),
            SizedBox(
              height: 20,
            ),
            QrImage(
              data: "0x3453453455acdca3424cac35343453aca",
              version: QrVersions.auto,
              size: 200,
              backgroundColor: ANColor.white,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "0x3453453455acdca3424cac35343453aca",
              style: header3.copyWith(
                  color: ANColor.backgroundText, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "This address let's \npeople send NFTs\nand Token to you",
              style: header1.copyWith(
                  color: ANColor.backgroundText, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
