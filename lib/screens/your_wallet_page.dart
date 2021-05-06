import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/setup/wallet_setup_provider.dart';
import 'package:etherwallet/context/wallet/wallet_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qr_flutter/qr_flutter.dart';


checkRoute(String route, BuildContext context) async {
  if(route=='wallet-setup-incomplete'){
    var store = useWalletSetup(context);
    await store.confirmMnemonic(store.state.mnemonic);
    Navigator.of(context).pushNamed('/your-wallet');
  }
}
class YourWalletPage extends HookWidget{

  final String route;

  YourWalletPage(this.route);

  @override
  Widget build(BuildContext context) {
    checkRoute(route, context);
    var store = useWallet(context);
    useEffect(() {
      store.initialise();
      return null;
    }, []);


    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(
        appBar: AppBar(),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Your Wallet Address",
              style: header1.copyWith(color: ANColor.backgroundText),
            ),
            SizedBox(
              height: 20,
            ),
            QrImage(
              data: store.state.address,
              version: QrVersions.auto,
              size: 200,
              backgroundColor: ANColor.white,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                store.state.address,
                style: header4.copyWith(
                    color: ANColor.backgroundText, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "This address let's \npeople send NFTs\nand Token to you",
              style: header1.copyWith(
                  color: ANColor.backgroundText, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }

}


