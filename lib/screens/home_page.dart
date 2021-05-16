import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/wallet/wallet_provider.dart';
import 'package:etherwallet/extension/hex_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              height: 100,
            ),
            Container(
              height: 200,
              width: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ANColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ANAssets.walletIcon,
                    height: 150,
                    width: 150,
                  ),
                  Text("Artaku Connect", style: header3),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: ANColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: GridView.count(
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
                              Navigator.of(context).pushNamed('/qrcode_reader-new', arguments: e);
                            },
                            child: Icon(
                              FontAwesomeIcons.paperPlane,
                              size: 20,
                              color: ANColor.white,
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
