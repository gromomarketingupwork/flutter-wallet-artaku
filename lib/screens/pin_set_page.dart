import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/components/snackbar/an_snack_bar.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(
        appBar: AppBar(),
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
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
              FormBuilder(
                key: pinFormKey,
                child: ANTextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  attribute: 'pin',
                  hintText: "123456",
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
                  width: 150,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              RoundedLoadingButton(
                child: Text(
                  "Set Pin",
                  style: header3.copyWith(color: ANColor.black),
                ),
                width: 150,
                color: ANColor.white,
                borderRadius: 25,
                height: 50,
                valueColor: ANColor.primary,
                successColor: ANColor.white,
                onPressed: () async {
                  if (pinFormKey.currentState.saveAndValidate()) {
                    Future.delayed(Duration(milliseconds: 3000), (){
                      _btnController.reset();
                    });
                    var configurationService =
                    Provider.of<ConfigurationService>(context,
                        listen: false);
                    configurationService.setPin(pinFormData['pin']);
                    AppSnackbar.success(context, "Pin set successfully");

                  }else{
                    _btnController.error();
                    Future.delayed(Duration(milliseconds: 3000), (){
                      _btnController.reset();
                    });
                  }
                },
                controller: _btnController,
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
                        onChanged: (value) async {
                          if (await _isBiometricAvailable()) {
                            if (value) {
                              await _getListOfBiometricTypes();
                              await _authenticateUser();
                            }
                            setState(() {
                              biometricSwitch = value;
                            });
                          }
                        },
                        activeTrackColor: Color(0xFFC2EFB3).withOpacity(0.5),
                        activeColor: Color(0xFFC2EFB3),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ANButton(
                label: "Continue",
                width: 250,
                buttonColor: ANColor.white,
                borderRadius: 25,
                height: 50,
                onClick: () {
                  var configurationService =
                      Provider.of<ConfigurationService>(context, listen: false);
                  if (configurationService.getPin() != null &&
                      configurationService.getPin().isNotEmpty) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/pin-enter', (route) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
