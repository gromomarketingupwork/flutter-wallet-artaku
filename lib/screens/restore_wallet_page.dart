import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';

class RestoreWalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestoreWalletPageState();
}

class _RestoreWalletPageState extends State<RestoreWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 64,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Restore Wallet",
                    style: header1.copyWith(color: ANColor.backgroundText),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  ANTextFormField(
                    width: 250,
                    maxLines: 12,
                    borderRadius: 20,
                    hintText: "12 Word Pass phrase",
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  Text(
                    "Restoring a wallet will replace\nthe existing wallet",
                    textAlign: TextAlign.center,
                    style: header3.copyWith(color: ANColor.backgroundText),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  ANButton(
                    label: "Restore Wallet",
                    buttonColor: ANColor.white,
                    width: 250,
                    borderRadius: 25,
                    height: 50,
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
