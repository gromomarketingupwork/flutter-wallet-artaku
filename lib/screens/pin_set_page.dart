import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/components/snackbar/an_snack_bar.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final pinFormKey = GlobalKey<FormBuilderState>();
var pinFormData = {};
bool biometricSwitch = false;

class PinSetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PinSetPageState();
}

class _PinSetPageState extends State<PinSetPage> {
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  // To retrieve the list of biometric types
  // (if available).
  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    print(listOfBiometrics);
  }

  // Process of authentication user using
  // biometrics.
  Future<void> _authenticateUser() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        biometricOnly: true,
        localizedReason: "Please authenticate to set fingerprint",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');

    if (isAuthenticated) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/pin-enter', (route) => false);
    }
  }

  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: ANColor.white,
      child: Stack(
        children: [
          Container(child: Image.asset(ANAssets.pinSetPageBackground),),
          Scaffold(
            backgroundColor: ANColor.white.withOpacity(0.2),
            appBar: ANAppBarNew(
              appBar: AppBar(),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.05,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "SECURITY",
                          style: header2.copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 42),
                          child: Text(
                            "Set a PIN below to secure the Artaku app on your device.",
                            style: header4.copyWith(fontWeight: FontWeight.w500, color: ANColor.black.withOpacity(0.6)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        FormBuilder(
                          key: pinFormKey,
                          child: ANTextFormField(
                            keyboardType: TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            attribute: 'pin',
                            labelText: "PIN",
                            hintText: "1234",
                            borderRadius: 4,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(context,
                                    errorText: "pin is required"),
                              ],
                            ),
                            initialValue: pinFormData['pin'],
                            onChange: (v) {
                              setState(() {
                                pinFormData = {...pinFormData, 'pin': v};
                              });
                            },
                            obscureText: _obscureText,
                            suffixIcon: Container(
                              child: InkWell(
                                  onTap: () {
                                    togglePassword();
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 20,
                                    color: ANColor.textPrimary,
                                  )),
                            ),
                            width: 326,
                          ),
                        ),
                        SizedBox(
                          height: 88,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  ANAssets.faceIdIcon,
                                  height: 32,
                                  width: 32,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Biometrics Enabled",
                                  style: header4.copyWith(color: ANColor.black, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Transform.scale(
                              scale: 1.1,
                              child: Switch(
                                value: biometricSwitch,
                                onChanged: (value) async {
                                  if (await _isBiometricAvailable()) {
                                    if (value) {
                                      // await _getListOfBiometricTypes();
                                      // await _authenticateUser();
                                    }
                                    setState(() {
                                      biometricSwitch = value;
                                    });
                                  }
                                },
                                activeTrackColor: ANColorNew.primary.withOpacity(0.38),
                                activeColor: ANColorNew.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.3,
                        ),
                        // RoundedLoadingButton(
                        //   child: Text(
                        //     "Set Pin",
                        //     style: header3.copyWith(color: ANColor.black),
                        //   ),
                        //   width: 150,
                        //   color: ANColor.white,
                        //   borderRadius: 25,
                        //   height: 50,
                        //   valueColor: ANColor.primary,
                        //   successColor: ANColor.white,
                        //   onPressed: () async {
                        //     if (pinFormKey.currentState.saveAndValidate()) {
                        //       Future.delayed(Duration(milliseconds: 3000), (){
                        //         _btnController.reset();
                        //       });
                        //       var configurationService =
                        //       Provider.of<ConfigurationService>(context,
                        //           listen: false);
                        //       configurationService.setPin(pinFormData['pin']);
                        //       AppSnackbar.success(context, "Pin set successfully");
                        //
                        //     }else{
                        //       _btnController.error();
                        //       Future.delayed(Duration(milliseconds: 3000), (){
                        //         _btnController.reset();
                        //       });
                        //     }
                        //   },
                        //   controller: _btnController,
                        // ),
                        ANButton(
                          label: "SAVE",
                          width: 124,
                          buttonColor: ANColor.buttonPrimary,
                          borderRadius: 4,
                          height: 36,
                          textColor: ANColor.white,
                          onClick: () {
                            var configurationService =
                            Provider.of<ConfigurationService>(context, listen: false);
                            // var configurationService =
                            // Provider.of<ConfigurationService>(context,
                            //     listen: false);
                            // configurationService.setPin(pinFormData['pin']);
                            // AppSnackbar.success(context, "Pin set successfully");

                            // if (configurationService.getPin() != null &&
                            //     configurationService.getPin().isNotEmpty) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/pin-enter', (route) => false);
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
