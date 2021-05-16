import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:etherwallet/model/nft_color.dart';

part 'wallet.g.dart';

abstract class Wallet implements Built<Wallet, WalletBuilder> {
  @nullable
  String get address;

  @nullable
  String get privateKey;

  BigInt get tokenBalance;

  BigInt get ethBalance;

  bool get loading;

  List<NFTColor> get walletColors;

  @nullable
  BuiltList<String> get errors;

  Wallet._();

  factory Wallet([void Function(WalletBuilder) updates]) => _$Wallet((b) => b
    ..tokenBalance = BigInt.from(0)
    ..ethBalance = BigInt.from(0)
    ..errors = BuiltList<String>().toBuilder()
    ..loading = false
    ..walletColors = new List()
    ..update(updates));
}
