import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';

class WalletProfileSetupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletProfileSetupPageState();
}

class _WalletProfileSetupPageState extends State<WalletProfileSetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(appBar: AppBar()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Create your profile",
                    style: header1.copyWith(color: ANColor.backgroundText),
                  ),
                  Image.asset(ANAssets.profileImage,height: 250, width: 250,),
                  ANTextFormField(
                    hintText: "Username",
                    width: 250,
                  ),
                  SizedBox(height: 25,),
                  ANTextFormField(
                    hintText: "Email",
                    width: 250,
                  ),
                  SizedBox(height: 50,),
                  ANButton(
                    height: 50,
                    width: 250,
                    textColor: ANColor.textPrimary,
                    buttonColor: ANColor.white,
                    onClick: () {
                      Navigator.of(context).pushNamed("/pin-enter");
                    },
                    borderRadius: 25,
                    label: "Continue",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
