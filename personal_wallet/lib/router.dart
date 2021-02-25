import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_wallet/context/setup/wallet_setup_providet.dart';
import 'package:personal_wallet/context/transfer/wallet_transfer_provider.dart';
import 'package:personal_wallet/context/wallet/wallet_provider.dart';
import 'package:personal_wallet/service/configuration_service.dart';
import 'package:personal_wallet/wallet_create_page.dart';
import 'package:personal_wallet/wallet_import_page.dart';
import 'package:personal_wallet/wallet_main_page.dart';
import 'package:personal_wallet/wallet_transfer_page.dart';
import 'package:provider/provider.dart';
import 'package:personal_wallet/intro_page.dart';

Map<String, WidgetBuilder> getRoutes(context) {
  return {
    "/": (BuildContext context) {
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
    "/import": (BuildContext context) => WalletSetupProvider(
          builder: (context, store) {
            return WalletImportPage("Import Wallet");
          },
        ),
    "transfer": (BuildContext context) => WalletTransferProvider(
          builder: (context, store) {
            return WalletTransferPage(title: "Send Tokens");
          },
        ),
  };
}
