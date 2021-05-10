import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:etherwallet/context/wallet/wallet_provider.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/utils/eth_amount_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

var tokenData = {};

class WalletPage extends HookWidget {
  Future fetchBalance;

  @override
  Widget build(BuildContext context) {
    var configurationService = Provider.of<ConfigurationService>(context);
    var store = useWallet(context);
    useEffect((){
      store.initialise();
      return null;
    },[]);
    tokenData = {
      ...tokenData,
      'ETH': store.state.ethBalance,
      'TOKEN': store.state.tokenBalance
    };
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
                    configurationService.getUsername() != null
                        ? configurationService.getUsername()
                        : "",
                    style: header1.copyWith(
                        color: ANColor.backgroundText, fontSize: 42),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/your-wallet');
                    },
                    child: store.state.address != null
                        ? QrImage(
                            data: store.state.address,
                            version: QrVersions.auto,
                            size: 72,
                            backgroundColor: ANColor.white,
                          )
                        : CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                ANColor.white),
                            backgroundColor: ANColor.primary,
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                store.state.address!=null?store.state.address:"",
                style: header3.copyWith(
                    color: ANColor.backgroundText, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 48,
              ),
              Expanded(
                child: ListView(
                        children: tokenData.entries
                            .map((e) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          EthAmountFormatter(e.value).format() + "   " + e.key,
                                          style: header1.copyWith(
                                              color: ANColor.backgroundText),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                            .toList(),
                )
              ),
              ANButton(
                height: 50,
                width: 250,
                label: "Backup Wallet",
                buttonColor: ANColor.white,
                borderRadius: 25,
                onClick: () {
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
