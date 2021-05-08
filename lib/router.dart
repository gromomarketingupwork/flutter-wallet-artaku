import 'package:etherwallet/qrcode_reader_page.dart';
import 'package:etherwallet/screens/backup_wallet_page.dart';
import 'package:etherwallet/screens/home_page.dart';
import 'package:etherwallet/screens/pin_enter_page.dart';
import 'package:etherwallet/screens/pin_set_page.dart';
import 'package:etherwallet/screens/profile_setup.dart';
import 'package:etherwallet/screens/restore_wallet_page.dart';
import 'package:etherwallet/screens/setup_restore.dart';
import 'package:etherwallet/screens/wallet_page.dart';
import 'package:etherwallet/screens/your_wallet_page.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/wallet_create_page.dart';
import 'package:etherwallet/wallet_import_page.dart';
import 'package:etherwallet/wallet_main_page.dart';
import 'package:etherwallet/wallet_transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'context/setup/wallet_setup_provider.dart';
import 'context/transfer/wallet_transfer_provider.dart';
import 'context/wallet/wallet_provider.dart';
import 'intro_page.dart';

Map<String, WidgetBuilder> getRoutes(context) {
  return {
    '/': (BuildContext context) {
      var configurationService = Provider.of<ConfigurationService>(context);
      if (configurationService.didSetupWallet())
        return WalletProvider(builder: (context, store) {
          return WalletMainPage("Your wallet");
        });

      return IntroPage();
    },
    '/create': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          useEffect(() {
            store.generateMnemonic();
            return null;
          }, []);

          return WalletCreatePage("Create wallet");
        }),
    '/setup-restore': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          return WalletSetupRestorePage();
        }),
    '/profile-setup': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          return WalletProfileSetupPage();
        }),
    '/pin-enter': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          return PinEnterPage();
        }),
    '/home': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          return HomePage();
        }),
    '/your-wallet': (BuildContext context) {
      var configurationService = Provider.of<ConfigurationService>(context);
      if (!configurationService.didSetupWallet()) {
        return WalletSetupProvider(builder: (context, store) {
          useEffect(() {
            store.generateMnemonic();
            return null;
          }, []);
          return YourWalletPage('wallet-setup-incomplete');
        });
      }
      return WalletProvider(builder: (context, store) {
        return YourWalletPage('wallet-setup-complete');
      });
    },
    '/wallet': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          return WalletPage();
        }),
    '/backup-wallet': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          return BackupWalletPage();
        }),
    '/restore-wallet': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          return RestoreWalletPage();
        }),
    '/pin-set': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          return PinSetPage();
        }),
    '/import': (BuildContext context) => WalletSetupProvider(
          builder: (context, store) {
            return WalletImportPage("Import wallet");
          },
        ),
    '/transfer': (BuildContext context) => WalletTransferProvider(
          builder: (context, store) {
            return WalletTransferPage(title: "Send Tokens");
          },
        ),
    '/qrcode_reader': (BuildContext context) => QRCodeReaderPage(
          title: "Scan QRCode",
          onScanned: ModalRoute.of(context).settings.arguments,
        )
  };
}
