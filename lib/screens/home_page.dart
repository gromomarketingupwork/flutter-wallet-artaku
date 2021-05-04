import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: List.generate(
                  12,
                  (index) => Image.asset(
                        ANAssets.placeHolderImage,
                        height: 50,
                        width: 50,
                      )),
            )
          ],
        ),
      ),
    );
  }
}
