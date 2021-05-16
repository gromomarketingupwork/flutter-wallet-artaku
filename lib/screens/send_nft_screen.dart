// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/components/form/form_field_label.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/transfer/wallet_transfer_provider.dart';
import 'package:etherwallet/extension/hex_extension.dart';
import 'package:etherwallet/model/nft_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

final addressKey = GlobalKey<FormBuilderState>();

class SendNFTScreen extends StatefulWidget {
  SendNFTScreen({this.nftColor});

  final NFTColor nftColor;
  final bool closeWhenScanned = false;

  @override
  State<StatefulWidget> createState() => _SendNFTScreenState();
}

class _SendNFTScreenState extends State<SendNFTScreen> {
  static final RegExp _basicAddress =
      RegExp(r'^(0x)?[0-9a-f]{40}', caseSensitive: false);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  String destinationAddress;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var transferStore = useWalletTransfer(context);

    final Color color = HexColor.fromHex(widget.nftColor.colorHex);
    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(
        appBar: AppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Transfer NFT",
                style: header2.copyWith(color: ANColor.backgroundText)),
            SizedBox(
              height: 20,
            ),
            Expanded(child: _buildQrView(context)),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(25)),
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
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FormBuilder(
              key: addressKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormFieldLabel(
                    label: "Destination Address",
                    isRequired: true,
                  ),
                  ANTextFormField(
                    attribute: 'address',
                    hintText: "0xac2....",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: "Address is required"),
                    ]),
                    initialValue: destinationAddress,
                    onChange: (v) {
                      setState(() {
                        destinationAddress = v;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ANButton(
              label: "Transfer",
              width: 150,
              buttonColor: ANColor.white,
              borderRadius: 25,
              height: 50,
              onClick: () async {
                var success = await transferStore.transferNFT(
                    destinationAddress, widget.nftColor.tokenId);
                if (success) {
                  Navigator.pop(context);
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      String scannedAddress = scanData.code.replaceRange(0, 9, "");

      if (_basicAddress.hasMatch(scannedAddress)) {
        setState(() {
          destinationAddress = scannedAddress;
        });
        controller.pauseCamera();

        if (await Vibration.hasVibrator()) {
          if (await Vibration.hasCustomVibrationsSupport()) {
            Vibration.vibrate(duration: 1000);
          } else {
            Vibration.vibrate();
          }
        }
      }
    });
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
