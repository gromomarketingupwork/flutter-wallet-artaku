import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletSetupRestorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletSetupRestorePageState();
}

class _WalletSetupRestorePageState extends State<WalletSetupRestorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ANColor.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ANAssets.appLogo),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ANButton(
                height: 50,
                width: 250,
                textColor: ANColor.textPrimary,
                buttonColor: ANColor.white,
                onClick: () {
                  Navigator.of(context).pushNamed("/profile-setup");
                },
                borderRadius: 25,
                label: "Setup New Account",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ANButton(
                height: 50,
                width: 250,
                textColor: ANColor.textPrimary,
                buttonColor: ANColor.white,
                onClick: () {},
                borderRadius: 25,
                label: "Restore Wallet",
              )
            ],
          )
        ],
      ),
    );
  }
}
