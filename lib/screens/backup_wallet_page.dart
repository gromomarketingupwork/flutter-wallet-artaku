import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';

class BackupWalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BackupWalletPageState();
}

class _BackupWalletPageState extends State<BackupWalletPage> {
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
          children: [
            SizedBox(
              height: 32,
            ),
            Text(
              "Backup Wallet",
              style: header1.copyWith(color: ANColor.backgroundText),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: ANColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                "word01 word02 word03 word04 word05 word06 word07 word08 word09 word10 word11 word12",
                style: header2.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Text(
                  "Write down or print the phrase above. Without this restore phrase any purchase and funds cannot be replaced.",
                  textAlign: TextAlign.center,
                  style: header2.copyWith(
                      color: ANColor.backgroundText,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            ANButton(
              height: 50,
              width: 250,
              label: "Print Restore Phrase",
              buttonColor: ANColor.white,
              borderRadius: 25,
              onClick: (){},
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
