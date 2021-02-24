import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_wallet/context/wallet/wallet_handler.dart';
import 'package:personal_wallet/context/wallet/wallet_state.dart';
import 'package:personal_wallet/service/address_service.dart';
import 'package:personal_wallet/service/configuration_service.dart';
import 'package:personal_wallet/service/contract_service.dart';

import 'package:provider/provider.dart';

import '../hook_provider.dart';
import 'package:personal_wallet/model/wallet.dart';

class WalletProvider extends ContextProviderWidget<WalletHandler> {
  WalletProvider({Widget child, HookWidgetBuilder<WalletHandler> builder})
      : super(child: child, builder: builder);

  @override
  Widget build(BuildContext context) {
    final store =
        useReducer<Wallet, WalletAction>(reducer, initialState: Wallet());

    final addressService = Provider.of<AddressService>(context);
    final contractService = Provider.of<ContractService>(context);
    final configurationService = Provider.of<ConfigurationService>(context);
    final handler = useMemoized(
      () => WalletHandler(
        store,
        addressService,
        contractService,
        configurationService,
      ),
      [addressService, store],
    );

    return provide(context, handler);
  }
}

WalletHandler useWallet(BuildContext context) {
  var handler = Provider.of<WalletHandler>(context);

  return handler;
}
