import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/main.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

List<String> actionList = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "CLR",
  "0",
  "OK"
];

int MAX_PIN_SIZE = 4;

class PinEnterPage extends StatefulWidget {
  PinEnterPage({Key key}) : super(key: key);

  @override
  _PinEnterPageState createState() => _PinEnterPageState();
}

class _PinEnterPageState extends State<PinEnterPage> {
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
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }

  final controller = PinEnterController();

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
          Container(
            child: Image.asset(ANAssets.pinEnterPageBackground),
          ),
          Scaffold(
            backgroundColor: ANColor.white.withOpacity(0.2),
            appBar: ANAppBarNew(
              appBar: AppBar(),
            ),
            body: Container(
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
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
                                  "ENTER PIN",
                                  style: header2.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 104),
                                  child: Text(
                                    "Enter your Artaku PIN below to continue.",
                                    style: header4.copyWith(
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                FormBuilder(
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
                                    initialValue: controller.pinValue,
                                    onChange: (v) {},
                                    readOnly: true,
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
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                      Icon(
                                        FontAwesomeIcons.fingerprint,
                                        color: ANColor.black.withOpacity(0.6),
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Login with biometrics",
                                        style: header4.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: ANColor.black.withOpacity(0.6)),
                                      )
                                    ]),
                                    onTap: () async {
                                      if (await _isBiometricAvailable()) {
                                        await _getListOfBiometricTypes();
                                        // await _authenticateUser();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.265,
                                ),
                                GridView.count(
                                  crossAxisCount: 3,
                                  childAspectRatio: (MediaQuery.of(context).size.width/3)/60,
                                  crossAxisSpacing: 0,
                                  shrinkWrap: true,
                                  mainAxisSpacing: 0,
                                  children: [
                                    ...actionList.map(
                                          (e) {
                                        return Container(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.performAction(
                                                  e, context);
                                            },
                                            child: Container(
                                              height: 60,
                                              width: MediaQuery.of(context).size.width/3,
                                              decoration: BoxDecoration(
                                                color: ANColor.white,
                                                border: Border.all(
                                                  color: ANColor.black.withOpacity(0.1),
                                                  width: 0.5
                                                )

                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                e,
                                                style: header2.copyWith(fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

class PinEnterController extends GetxController {
  var _isHidden = true.obs;
  var _pinValue = "".obs;

  String get pinValue => _pinValue.value;

  bool get isHidden => _isHidden.value;

  toggleHidden() {
    _isHidden.value = !_isHidden.value;
    print("toggle hidden");
    _isHidden.refresh();
  }

  performAction(String action, BuildContext context) {
    print("clicked $action");
    if ("CLR" == action) {
      //clear last field
      if (0 != _pinValue.value.length) {
        _pinValue.value =
            _pinValue.value.substring(0, _pinValue.value.length - 1);
      }
      return;
    }
    if ("OK" == action) {
      var configurationService =
          Provider.of<ConfigurationService>(context, listen: false);
      if (_pinValue.value == configurationService.getPin()) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
      return;
    }
    if (pinValue.length == MAX_PIN_SIZE) {
      return;
    }
    _pinValue.value = _pinValue.value + action;
    print("final value ${_pinValue.value}");
    _pinValue.refresh();
  }
}
