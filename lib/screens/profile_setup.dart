import 'dart:io';

import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/components/snackbar/image_selector.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

final formKey = GlobalKey<FormBuilderState>();
var formData = {};

class WalletProfileSetupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletProfileSetupPageState();
}

class _WalletProfileSetupPageState extends State<WalletProfileSetupPage> {
  File selectedImage;

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
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(125)),
                        child: ClipRRect(
                          child: Image.asset(
                            selectedImage ?? ANAssets.profileImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(child: Icon(FontAwesomeIcons.camera))
                    ],
                  ),
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
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
                            setState(() {
                              formData = {...formData, 'username': v};
                            });
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
                            // FormBuilderValidators.email(context, errorText: 'Email pattern not matched')
                          ]),
                          initialValue: formData['email'],
                          onChange: (v) {
                            setState(() {
                              formData = {...formData, 'email': v};
                            });
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ImageSelector(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.35,
                          valueChanged: (data) {
                            setState(() {
                              selectedImage = data;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  ANButton(
                    height: 50,
                    width: 250,
                    textColor: ANColor.textPrimary,
                    buttonColor: ANColor.white,
                    onClick: () {
                      if (formKey.currentState.saveAndValidate()) {
                        var configurationService =
                            Provider.of<ConfigurationService>(context,
                                listen: false);
                        configurationService.setEmail(formData['email']);
                        configurationService.setUsername(formData['username']);
                        Navigator.of(context).pushNamed('/pin-set');
                      }
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
