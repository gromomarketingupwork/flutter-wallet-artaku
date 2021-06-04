import 'dart:async';

import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/components/form/form_field_label.dart';
import 'package:etherwallet/components/snackbar/an_snack_bar.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/setup/wallet_setup_provider.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/utils/lower_case_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final restoreWalletKey = GlobalKey<FormBuilderState>();

class RestoreWalletPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RestoreWalletPageState();

}

class _RestoreWalletPageState extends State<RestoreWalletPage> {
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  String passPhrase = "";

  @override
  Widget build(BuildContext context) {
    var store = useWalletSetup(context);

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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "Restore Wallet",
                          style: header2.copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        FormBuilder(
                          key: restoreWalletKey,
                          child: Column(
                            children: [
                              ANTextFormField(
                                inputFormatters: [
                                  LowerCaseTextFormatter()
                                ],
                                attribute: 'passphrase',
                                width: 250,
                                maxLines: 10,
                                borderRadius: 4,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context,
                                      errorText: "Mnemonics is required"),
                                ]),
                                labelText: "Mnemonics",
                                hintText: "12 Word Pass phrase",
                                initialValue: passPhrase,
                                onChange: (v) {
                                  setState(() {
                                    passPhrase = v;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        Text(
                          "Restoring a wallet will replace\nthe existing wallet",
                          textAlign: TextAlign.center,
                          style: header2.copyWith(color: ANColor.black.withOpacity(0.6), fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.25,
                        ),
                        RoundedLoadingButton(
                          child: Text(
                            "IMPORT",
                            style: header4.copyWith(color: ANColor.white, fontWeight: FontWeight.w500),
                          ),
                          width: 150,
                          elevation: 0,
                          color: ANColor.buttonPrimary,
                          borderRadius: 4,
                          height: 36,
                          valueColor: ANColor.white,
                          successColor: ANColor.white,
                          onPressed: () async {
                            bool success = await store.importFromMnemonic(passPhrase);
                            if (success) {
                              _btnController.success();
                              var configurationService =
                              Provider.of<ConfigurationService>(context,
                                  listen: false);
                              if (configurationService.getEmail() == null ||
                                  configurationService.getEmail().isEmpty) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/profile-setup');
                              }
                            } else {
                              _btnController.error();
                              Future.delayed(Duration(milliseconds: 3000), (){
                                _btnController.reset();
                              });

                              AppSnackbar.error(context, "Error in importing wallet");
                            }
                          },
                          controller: _btnController,
                        ),
                        SizedBox(
                          height: 64,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
