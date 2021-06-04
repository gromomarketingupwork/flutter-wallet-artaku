import 'dart:ui';

import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/warning_popup.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackupWalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BackupWalletPageState();
}

class _BackupWalletPageState extends State<BackupWalletPage> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return WarningPopup();
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    String mnemonics = args['mnemonic'] ?? "";
    List<String> mnemonicList = mnemonics.split(' ').map((e) => e).toList();
    return Container(
      color: ANColor.white,
      child: Stack(
        children: [
          Container(
            child: Image.asset(ANAssets.backupWalletBackground),
          ),
          Scaffold(
              backgroundColor: ANColor.white.withOpacity(0.2),
              appBar: ANAppBarNew(
                appBar: AppBar(),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "ACCOUNT BACKUP",
                              style: header2.copyWith(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              "Write down or print the passphrase below and keep it in a safe place to restore your purchases in the future.",
                              style: header4.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ANColor.black.withOpacity(0.6),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 48,
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: FittedBox(
                                child: DataTable(
                                  headingRowHeight: 0,
                                  columnSpacing: 20,
                                  dataRowHeight: 30,
                                  dividerThickness: 0,
                                  columns: [
                                    DataColumn(label: Text('')),
                                    DataColumn(label: Text('')),
                                    DataColumn(label: Text('')),
                                  ],
                                  rows: mnemonicList.isNotEmpty
                                      ? getDataRow(mnemonicList)
                                      : [],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            ANOutlinedButton(
                              height: 36,
                              width: 104,
                              textColor: ANColor.buttonTextColor,
                              buttonColor: Colors.transparent,
                              onClick: () {},
                              borderRadius: 4,
                              borderColor: ANColor.black.withOpacity(0.2),
                              label: "PRINT",
                            ),
                            Expanded(
                                child: SizedBox(
                              height: 20,
                            )),
                            ANButton(
                              label: 'CONTINUE',
                              width: 122,
                              height: 36,
                              buttonColor: ANColor.buttonPrimary,
                              borderRadius: 4,
                              textColor: ANColor.white,
                              onClick: () {
                                var configurationService =
                                    Provider.of<ConfigurationService>(context,
                                        listen: false);
                                if (configurationService.getEmail() == null ||
                                    configurationService.getEmail().isEmpty) {
                                  Navigator.of(context)
                                      .pushNamed('/profile-setup');
                                }
                              },
                            ),
                            SizedBox(
                              height: 64,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  getDataRow(List<String> mnemonicList) {
    var dataRows = <DataRow>[
      DataRow(
          cells: mnemonicList
              .sublist(0, 3)
              .map((e) => DataCell(Text(
                    e,
                    style: header4Mnemonic,
                  )))
              .toList()),
      DataRow(
          cells: mnemonicList
              .sublist(3, 6)
              .map((e) => DataCell(Text(
                    e,
                    style: header4Mnemonic,
                  )))
              .toList()),
      DataRow(
          cells: mnemonicList
              .sublist(6, 9)
              .map((e) => DataCell(Text(
                    e,
                    style: header4Mnemonic,
                  )))
              .toList()),
      DataRow(
          cells: mnemonicList
              .sublist(9, 12)
              .map((e) => DataCell(Text(
            e,
            style: header4Mnemonic,
          )))
              .toList()),
    ];
    return dataRows;
  }
}
