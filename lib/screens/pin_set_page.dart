import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';

class PinSetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PinSetPageState();
}

class _PinSetPageState extends State<PinSetPage> {
  bool biometricSwitch = true;

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
              "Secure Your Wallet",
              style: header1.copyWith(color: ANColor.backgroundText),
            ),
            SizedBox(
              height: 32,
            ),
            ANTextField(
              hintText: "123456",
              width: 150,
            ),
            SizedBox(
              height: 32,
            ),
            ANButton(
              label: "Set Pin",
              width: 150,
              buttonColor: ANColor.white,
              borderRadius: 25,
              height: 50,
            ),
            SizedBox(
              height: 128,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    ANAssets.faceIdIcon,
                    height: 50,
                    width: 50,
                  ),
                  Text(
                    "Biometrics Enabled",
                    style: header2.copyWith(color: ANColor.backgroundText),
                  ),
                  Transform.scale(
                    scale: 1.4,
                    child: Switch(
                      value: biometricSwitch,
                      onChanged: (value) {
                        setState(() {
                          biometricSwitch = value;
                        });
                      },
                      activeTrackColor: Color(0xFFC2EFB3).withOpacity(0.5),
                      activeColor: Color(0xFFC2EFB3),
                    ),
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
