import 'package:bip39/bip39.dart' as mnemonicGenerator;

abstract class IEthWalletService{
  String generateMnemonic() ;
}

class EthWalletService implements IEthWalletService{
  @override
  String generateMnemonic() {
    return mnemonicGenerator.generateMnemonic();
  }

}