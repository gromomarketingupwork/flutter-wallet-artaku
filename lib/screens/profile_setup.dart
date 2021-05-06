import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final formKey = GlobalKey<FormBuilderState>();
var formData = {};
class WalletProfileSetupPage extends HookWidget{

  WalletProfileSetupPage();
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
                  Image.asset(
                    ANAssets.profileImage,
                    height: 250,
                    width: 250,
                  ),
                  ANTextFormField(
                    attribute: 'username',
                    hintText: "Username",
                    width: 250,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(context,
                            errorText: "username is required"),
                      ],
                    ),
                    initialValue: formData['username'],
                    onChange: (v) {
                      // this.setState(() {
                      //   formData = {...formData, 'username': v};
                      // });
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ANTextFormField(
                    attribute: 'email',
                    hintText: "Email",
                    width: 250,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: "Email is required"),
                    ]),
                    initialValue: formData['email'],
                    onChange: (v) {
                      // this.setState(() {
                      //   formData = {...formData, 'email': v};
                      // });
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ANButton(
                    height: 50,
                    width: 250,
                    textColor: ANColor.textPrimary,
                    buttonColor: ANColor.white,
                    onClick: () {
                      // Navigator.of(context).pushNamed("/pin-enter");
                      Navigator.of(context).pushNamed("/your-wallet");
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
