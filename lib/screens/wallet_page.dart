import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletPageState();
}

var nftData = {
  'ARTA': 45.545,
  'BNB': 34.21,
  'CAKE': 23.432,
  'JPA': 0.343,
  'NCT': 34.33,
  'XVR': 32.32
};

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(
        appBar: AppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "superdude121",
                    style: header1.copyWith(
                        color: ANColor.backgroundText, fontSize: 42),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/your-wallet');
                    },
                    child: QrImage(
                      data: "0x3453453455acdca3424cac35343453aca",
                      version: QrVersions.auto,
                      size: 72,
                      backgroundColor: ANColor.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "0x3453453455acdca3424cac35343453aca",
                style: header3.copyWith(
                    color: ANColor.backgroundText, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 48,
              ),
              Expanded(
                child: ListView(
                  children: nftData.entries
                      .map((e) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.value.toString() + "   " + e.key,
                                    style: header1.copyWith(
                                        color: ANColor.backgroundText),
                                  ),
                                ],
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
              ANButton(
                height: 50,
                width: 250,
                label: "Backup Wallet",
                buttonColor: ANColor.white,
                borderRadius: 25,
                onClick: (){
                  Navigator.of(context).pushNamed('/backup-wallet');
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
