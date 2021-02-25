import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_wallet/components/wallet/import_wallet_form.dart';
import 'package:personal_wallet/context/setup/wallet_setup_providet.dart';
import 'package:personal_wallet/model/wallet_setup.dart';

class WalletImportPage extends HookWidget {
  WalletImportPage(this.title);

  final String title;

  Widget build(BuildContext context) {
    var store = useWalletSetup(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ImportWalletForm(
        errors: store.state.errors.toList(),
        onImport: !store.state.loading
            ? (type, value) async {
          switch (type) {
            case WalletImportType.mnemonic:
              if (!await store.importFromMnemonic(value)) return;
              break;
            case WalletImportType.privateKey:
              if (!await store.importFromPrivateKey(value)) return;
              break;
            default:
              break;
          }

          Navigator.of(context).popAndPushNamed("/");
        }
            : null,
      ),
    );
  }
}
