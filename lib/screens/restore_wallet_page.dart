import 'dart:async';

import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/components/form/an_text_field.dart';
import 'package:etherwallet/components/form/form_field_label.dart';
import 'package:etherwallet/components/snackbar/an_snack_bar.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/setup/wallet_setup_provider.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/utils/lower_case_formatter.dart';
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

    return Scaffold(
      backgroundColor: ANColor.primary,
      appBar: ANAppBar(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 64,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Restore Wallet",
                    style: header1.copyWith(color: ANColor.backgroundText),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  FormBuilder(
                    key: restoreWalletKey,
                    child: Column(
                      children: [
                        FormFieldLabel(
                          label: "Mnemonic",
                          isRequired: true,
                        ),
                        ANTextFormField(
                          inputFormatters: [
                            LowerCaseTextFormatter()
                          ],
                          attribute: 'passphrase',
                          width: 250,
                          maxLines: 12,
                          borderRadius: 20,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context,
                                errorText: "Address is required"),
                          ]),
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
                    style: header3.copyWith(color: ANColor.backgroundText),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  RoundedLoadingButton(
                    child: Text(
                      "Import",
                      style: header3.copyWith(color: ANColor.black),
                    ),
                    width: 250,
                    color: ANColor.white,
                    borderRadius: 25,
                    height: 50,
                    valueColor: ANColor.primary,
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
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
