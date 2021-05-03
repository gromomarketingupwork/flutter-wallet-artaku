import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:local_auth/local_auth.dart';

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
      //TODO do some action here
    }
  }

  final controller = PinEnterController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ANColor.primary,
        appBar: ANAppBar(appBar: AppBar()),
        body: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 40, right: 10, left: 10),
                  color: ANColor.primary,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Please enter $MAX_PIN_SIZE digits transaction pin to proceed",
                        style: header4sec.copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        overflow: Overflow.visible,
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Wrap(
                                  // alignment: WrapAlignment.center,
                                  spacing: 10,
                                  children:
                                      List.generate(MAX_PIN_SIZE, (index) {
                                    var value = controller.pinValue;
                                    value = value.padRight(MAX_PIN_SIZE, ' ');
                                    if (controller.isHidden &&
                                        controller.pinValue.length > 0) {
                                      value = "*"
                                          .padRight(
                                              controller.pinValue.length, "*")
                                          .padRight(MAX_PIN_SIZE, ' ');
                                    }
                                    return Container(
                                      width: 30,
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: ANColor.white),
                                      child: "*" == value[index]
                                          ? Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: ANColor.black),
                                            )
                                          : Text(
                                              value[index] ?? "",
                                              style: header3,
                                            ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  width: 40,
                                )
                              ]),
                          if (controller.pinValue.length > 0)
                            Positioned(
                                left: ((MAX_PIN_SIZE + 1) * 40).toDouble(),
                                top: 0,
                                child: InkWell(
                                  // behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    controller.toggleHidden();
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: ANColor.white),
                                    child: Icon(
                                      FontAwesomeIcons.eye,
                                      color: ANColor().textTertiary,
                                      size: 18,
                                    ),
                                  ),
                                )),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              children: [
                                ...actionList.map(
                                  (e) {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.performAction(e);
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: ANColor.white,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            e,
                                            style: header3,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                            InkWell(
                              child: Icon(
                                FontAwesomeIcons.fingerprint,
                                color: ANColor.white,
                                size: 50,
                              ),
                              onTap: ()  async{
                                if (await _isBiometricAvailable()){
                                  await _getListOfBiometricTypes();
                                  await _authenticateUser();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
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

  performAction(String action) {
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
      //perform  ok action
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
