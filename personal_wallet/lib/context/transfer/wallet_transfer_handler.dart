import 'dart:async';
import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_wallet/context/transfer/wallet_transfer_state.dart';
import 'package:personal_wallet/model/wallet_transfer.dart';
import 'package:personal_wallet/service/configuration_service.dart';
import 'package:personal_wallet/service/contract_service.dart';
import 'package:web3dart/credentials.dart';

class WalletTransferHandler {
  WalletTransferHandler(
    this._store,
    this._contractService,
    this._configurationService,
  );

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
        onTransfer: (from, to, value) {
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
