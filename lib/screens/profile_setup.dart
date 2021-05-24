import 'dart:io';

import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create your profile",
                    style: header1.copyWith(color: ANColor.backgroundText),
                  ),
                  SizedBox(height: 48,),
                  Center(
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: ANColor.white,
                            child: selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.file(
                                      selectedImage,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: ANColor.primary,
                                      borderRadius: BorderRadius.circular(75),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(75),
                                      child: Image.asset(
                                        ANAssets.profileImage,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Align(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(75),
                                border: Border.all(color: ANColor.white),
                                color: Colors.transparent),
                            child: InkWell(
                              onTap: () {
                                _getImage();
                              },
                              child: Align(
                                alignment: Alignment(0.85, 0.85),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: ANColor.white),
                                      color: ANColor.primary),
                                  child: Icon(FontAwesomeIcons.camera,
                                      color: ANColor.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
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
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
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

  Future _getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  Future _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      setState(() {
        selectedImage = croppedImage;
      });
    }
  }
}
