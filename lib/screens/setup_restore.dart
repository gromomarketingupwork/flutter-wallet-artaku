import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
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
      body: Stack(
        children: [
          Image.asset(ANAssets.mainBackgroundImage),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.45,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 70),
                      child: Image.asset(ANAssets.appMainLogo),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.05,
                  ),
                  ANButton(
                    label: 'CREATE ACCOUNT',
                    width: 172,
                    height: 36,
                    buttonColor: ANColor.buttonPrimary,
                    borderRadius: 4,
                    textColor: ANColor.white,
                    onClick: (){
                      Navigator.of(context).pushNamed('/terms-of-service');
                    },
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.3,
                  ),
                  ANOutlinedButton(
                    height: 36,
                    width: 172,
                    textColor: ANColor.buttonTextColor,
                    buttonColor: Colors.transparent,
                    onClick: () {
                      Navigator.of(context).pushNamed('/restore-wallet');
                    },
                    borderRadius: 4,
                    borderColor: ANColor.black.withOpacity(0.2),
                    label: "RESTORE ACCOUNT",
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
