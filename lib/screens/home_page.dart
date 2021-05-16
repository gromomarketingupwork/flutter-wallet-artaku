import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/copyButton/copy_button.dart';
import 'package:etherwallet/components/snackbar/an_snack_bar.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/wallet/wallet_provider.dart';
import 'package:etherwallet/extension/hex_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var store = useWallet(context);
    useEffect(() {
      store.initialise();
      return null;
    }, []);
    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(
        appBar: AppBar(),
        wallet: InkWell(
          child: Icon(FontAwesomeIcons.wallet),
          onTap: () {
            Navigator.of(context).pushNamed('/wallet');
          },
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              "Your Address",
              style: header2.copyWith(color: ANColor.backgroundText),
            ),
            SizedBox(
              height: 25,
            ),
            store.state.address != null
                ? QrImage(
                    data: store.state.address,
                    version: QrVersions.auto,
                    size: 150,
                    backgroundColor: ANColor.white,
                  )
                : CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(ANColor.white),
                    backgroundColor: ANColor.primary,
                  ),
            SizedBox(
              height: 10,
            ),
            CopyButton(
                text: Text(
                  "Copy Address",
                  style: header3.copyWith(color: ANColor.backgroundText),
                ),
                value: store.state.address),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              width: double.infinity,
              color: ANColor.white,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Owned Tokens",
              style: header2.copyWith(color: ANColor.backgroundText),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: ANColor.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: store.state.loading? Container(
                  child: Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              ANColor.primary),
                        ),
                      ),
                      Text("Fetching Balance", style: header2,)
                    ],
                  ),
                ): GridView.count(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25,
                    crossAxisCount: 2,
                    children: store.state.walletColors.map((e) {
                      final Color color = HexColor.fromHex(e.colorHex);
                      return Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Id: " + e.tokenId.toString(),
                              style: header3.copyWith(color: ANColor.white),
                            ),
                            Text(
                              e.colorHex,
                              style: header3.copyWith(color: ANColor.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/qrcode_reader-new', arguments: [
                                  e,
                                  (onSuccess) {
                                    if (onSuccess) {
                                      AppSnackbar.success(context,
                                          "Nft transfer done successfully");
                                    }
                                  }
                                ]);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                child: Icon(
                                  FontAwesomeIcons.paperPlane,
                                  size: 20,
                                  color: ANColor.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
