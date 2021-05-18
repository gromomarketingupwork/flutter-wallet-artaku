import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WalletSetupRestorePage extends HookWidget {
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ANColor.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ANAssets.appLogo),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
              ),
              RoundedLoadingButton(
                child: Text(
                  "Setup New Account",
                  style: header3.copyWith(color: ANColor.black),
                ),
                width: 250,
                color: ANColor.white,
                borderRadius: 25,
                height: 50,
                valueColor: ANColor.primary,
                successColor: ANColor.white,
                onPressed: () {
                  Navigator.of(context).pushNamed('/your-wallet');
                },
                controller: _btnController,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
              ),
              ANButton(
                height: 50,
                width: 250,
                textColor: ANColor.textPrimary,
                buttonColor: ANColor.white,
                onClick: () {
                  Navigator.of(context).pushNamed('/restore-wallet');
                },
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
