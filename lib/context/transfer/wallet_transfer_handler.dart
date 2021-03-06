import 'dart:async';
import 'dart:math';

import 'package:etherwallet/context/transfer/wallet_transfer_state.dart';
import 'package:etherwallet/model/wallet_transfer.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:web3dart/credentials.dart';

typedef void TransferListenFunction(EthereumAddress from, EthereumAddress to,
    String transactionHash, BigInt tokenId);

class WalletTransferHandler {
  WalletTransferHandler(this._store,
      this._contractService,
      this._configurationService);

  final Store<WalletTransfer, WalletTransferAction> _store;
  final ContractService _contractService;
  final ConfigurationService _configurationService;

  WalletTransfer get state => _store.state;

  Future<bool> transfer(String to, String amount) async {
    var completer = new Completer<bool>();
    var privateKey = _configurationService.getPrivateKey();

    _store.dispatch(WalletTransferStarted());

    try {
      await _contractService.send(
        privateKey,
        EthereumAddress.fromHex(to),
        BigInt.from(double.parse(amount) * pow(10, 18)),
        onTransfer: (from, to, value, transactionId) {
          completer.complete(true);
        },
        onError: (ex) {
          _store.dispatch(WalletTransferError(ex.toString()));
          completer.complete(false);
        },
      );
    } catch (ex) {
      _store.dispatch(WalletTransferError(ex.toString()));
      completer.complete(false);
    }

    return completer.future;
  }

  Future<bool> transferNFT(String to, BigInt tokenId, TransferListenFunction transferListenFunction) async {
    var completer = new Completer<bool>();
    var privateKey = _configurationService.getPrivateKey();

    _store.dispatch(WalletTransferStarted());

    try {
      await _contractService.sendNFT(
        privateKey,
        EthereumAddress.fromHex(to),
        tokenId,
        onTransfer: (from, to, value, transactionId) {
          transferListenFunction(from, to, transactionId, value);
          completer.complete(true);
        },
        onError: (ex) {
          _store.dispatch(WalletTransferError(ex.toString()));
          completer.complete(false);
        },
      );
    } catch (ex) {
      _store.dispatch(WalletTransferError(ex.toString()));
      completer.complete(false);
    }

    return completer.future;
  }
}
