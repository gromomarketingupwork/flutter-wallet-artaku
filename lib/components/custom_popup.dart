import 'dart:ui';

import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/extension/hex_extension.dart';
import 'package:etherwallet/model/nft_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/credentials.dart';

class CustomDialogBox extends StatefulWidget {
  final NFTColor nftColor;
  final EthereumAddress from;
  final EthereumAddress to;
  final String transactionId;

  const CustomDialogBox(
      {Key key, this.from, this.to, this.transactionId, this.nftColor})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: 50 + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Transaction Detail",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "EtherScan transaction detail",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      "From:",
                      style: header6,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.from.toString(),
                      style: header6.copyWith(
                          color: ANColor.primaryTint.withOpacity(0.5),
                          fontSize: 10),
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Text(
                      "To:",
                      style: header6,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.to.toString(),
                      style: header6.copyWith(
                          color: ANColor.primaryTint.withOpacity(0.5),
                          fontSize: 10),
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "tId",
                        style: header6,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          "${widget.transactionId}",
                          maxLines: 2,
                          style: header6.copyWith(
                              color: ANColor.primaryTint.withOpacity(0.5),
                              fontSize: 10),
                        ),
                      )
                    ]
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: HexColor.fromHex(widget.nftColor.colorHex),
                borderRadius: BorderRadius.circular(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Id: " + widget.nftColor.tokenId.toString(),
                  style: header3.copyWith(color: ANColor.white),
                ),
                Text(
                  widget.nftColor.colorHex,
                  style: header3.copyWith(color: ANColor.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();

  static const double padding = 20;
  static const double avatarRadius = 45;
}
