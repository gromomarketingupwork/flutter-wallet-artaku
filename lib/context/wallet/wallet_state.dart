import 'package:etherwallet/model/nft_color.dart';
import 'package:etherwallet/model/wallet.dart';

abstract class WalletAction {}

class InitialiseWallet extends WalletAction {
  InitialiseWallet(this.address, this.privateKey);

  final String address;
  final String privateKey;
}

class BalanceUpdated extends WalletAction {
  BalanceUpdated(this.ethBalance, this.tokenBalance, this.walletColors);

  final BigInt ethBalance;
  final BigInt tokenBalance;
  final List<NFTColor> walletColors;
}

class UpdatingBalance extends WalletAction {}

Wallet reducer(Wallet state, WalletAction action) {
  if (action is InitialiseWallet) {
    return state.rebuild((b) => b
      ..address = action.address
      ..privateKey = action.privateKey);
  }

  if (action is UpdatingBalance) {
    return state.rebuild((b) => b..loading = true);
  }

  if (action is BalanceUpdated) {
    return state.rebuild((b) => b
      ..loading = false
      ..ethBalance = action.ethBalance
      ..tokenBalance = action.tokenBalance
      ..walletColors = action.walletColors);
  }

  return state;
}
