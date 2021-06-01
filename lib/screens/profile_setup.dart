import 'dart:io';

import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/components/snackbar/an_snack_bar.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/wallet/wallet_provider.dart';
import 'package:etherwallet/network/profile_network_services.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final formKey = GlobalKey<FormBuilderState>();
var formData = {};

class WalletProfileSetupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletProfileSetupPageState();
}

class _WalletProfileSetupPageState extends State<WalletProfileSetupPage> {
  File selectedImage;

  ProfileNetworkService profileNetworkService = new ProfileNetworkService();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    var store = useWallet(context);
    return Container(
      color: ANColor.white,
      child: Stack(
        children: [
          Container(child: Image.asset(ANAssets.createAccountBackground)),
          Scaffold(
            backgroundColor: ANColor.white.withOpacity(0.2),
            appBar: ANAppBarNew(
              appBar: AppBar(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
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
                            "CREATE ACCOUNT",
                            style: header2.copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 75,
                                    child: selectedImage != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(75),
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
                                              borderRadius:
                                                  BorderRadius.circular(75),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(75),
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
                                Positioned(
                                  right: 60,
                                  bottom: 0,
                                  child: InkWell(
                                    onTap: () {
                                      _getImage();
                                    },
                                    child: Container(
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          color: ANColorNew.primary),
                                      child: Icon(FontAwesomeIcons.camera,
                                          size: 16, color: ANColor.white),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 60,
                                  bottom: 0,
                                  child: InkWell(
                                    child: Container(
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          color: ANColorNew.primaryPink),
                                      child: Icon(FontAwesomeIcons.image,
                                          size: 16, color: ANColor.white),
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
                                  labelText: "Username",
                                  width: 326,
                                  borderRadius: 4,
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
                                  labelText: "Email",
                                  width: 326,
                                  borderRadius: 4,
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
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          ANButton(
                            label: 'CONTINUE',
                            width: 172,
                            height: 36,
                            buttonColor: ANColor.buttonPrimary,
                            borderRadius: 4,
                            textColor: ANColor.white,
                            onClick: () async {
                              if (formKey.currentState.saveAndValidate()) {
                                var configurationService =
                                    Provider.of<ConfigurationService>(context,
                                        listen: false);
                                try {
                                  await profileNetworkService.createWalletProfile(
                                      store.state.address.toString(),
                                      formData['username'],
                                      formData['email'],
                                      selectedImage);
                                  configurationService
                                      .setEmail(formData['email']);
                                  configurationService
                                      .setUsername(formData['username']);
                                  Navigator.of(context).pushNamed('/pin-set');
                                } catch (e) {
                                  _btnController.error();
                                  Future.delayed(Duration(milliseconds: 3000),
                                      () {
                                    _btnController.reset();
                                  });
                                  AppSnackbar.error(
                                      context, "Cannot create profile");
                                }
                              }
                            },
                          ),
                          // RoundedLoadingButton(
                          //   child: Text(
                          //     "Continue",
                          //     style: header3.copyWith(color: ANColor.black),
                          //   ),
                          //   height: 50,
                          //   width: 250,
                          //   color: ANColor.white,
                          //   borderRadius: 25,
                          //   valueColor: ANColor.primary,
                          //   successColor: ANColor.white,
                          //   onPressed: () async {
                          //
                          //   },
                          //   controller: _btnController,
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
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
