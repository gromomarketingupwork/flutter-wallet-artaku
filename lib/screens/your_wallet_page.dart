import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/setup/wallet_setup_provider.dart';
import 'package:etherwallet/context/wallet/wallet_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qr_flutter/qr_flutter.dart';

class YourWalletPage extends HookWidget {
  final String route;
  Future animBool;

  YourWalletPage(this.route);

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    if (route == 'wallet-setup-incomplete') {
      var store = useWalletSetup(context);
      animBool = store.confirmMnemonic(store.state.mnemonic);
      animBool.then((value) => {
            Navigator.of(context).pushReplacementNamed('/your-wallet',
                arguments: {
                  'firstTimeSetup': true,
                  'mnemonic': store.state.mnemonic
                })
          });
      return Container(
        color: ANColor.white,
        child: Stack(
            children: [
            Container(child: Image.asset(ANAssets.pinSetPageBackground),),
            Scaffold(
                backgroundColor: ANColor.white.withOpacity(0.2),
                body: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(ANColorNew.primary),
                        backgroundColor: ANColor.white.withOpacity(0.2),
                        semanticsLabel: "Hello",
                      ),
                      Text(
                        "Setting Up Wallet",
                        style: header3.copyWith(color: ANColor.black),
                      )
                    ],
                  ),
                )),
          ]
        ),
      );
    } else {
      var store = useWallet(context);
      useEffect(() {
        store.initialise();
        return null;
      }, []);
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
              body: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                    ),
                    Text(
                      "Your Wallet Address",
                      style: header2.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    store.state.address != null
                        ? QrImage(
                      data: store.state.address,
                      version: QrVersions.auto,
                      size: 200,
                      backgroundColor: ANColor.white,
                    )
                        : SizedBox(
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        store.state.address != null ? store.state.address : "",
                          style: header4.copyWith(fontWeight: FontWeight.w500),

                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: Text(
                        "This address let's \npeople send NFTs\nand Token to you",
                        style: header2.copyWith(fontWeight: FontWeight.w500, color: ANColor.black.withOpacity(0.6)),

                    ),
                    ),
                    (args != null && args['firstTimeSetup'])
                        ? ANButton(
                          label: "BACKUP NOW",
                          height: 36,
                          buttonColor: ANColor.buttonPrimary,
                          borderRadius: 4,
                          textColor: ANColor.white,
                          width: MediaQuery.of(context).size.width * 0.3,
                          onClick: () {
                            Navigator.of(context).pushNamed('/backup-wallet',
                                arguments: {'mnemonic': args['mnemonic']});
                          },
                        )
                        : SizedBox(),
                    SizedBox(
                      height: 64,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
