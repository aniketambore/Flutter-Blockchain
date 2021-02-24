import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_wallet/context/hook_provider.dart';
import 'package:personal_wallet/context/setup/wallet_setup_handler.dart';
import 'package:personal_wallet/model/wallet_setup.dart';
import 'package:personal_wallet/model/wallet_setup_state.dart';
import 'package:personal_wallet/service/address_service.dart';
import 'package:provider/provider.dart';

class WalletSetupProvider extends ContextProviderWidget<WalletSetupHandler> {
  WalletSetupProvider(
      {Widget child, HookWidgetBuilder<WalletSetupHandler> builder})
      : super(child: child, builder: builder);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<WalletSetup, WalletSetupAction>(reducer,
        initialState: WalletSetup());

    final addressService = Provider.of<AddressService>(context);
    final handler = useMemoized(
      () => WalletSetupHandler(store, addressService),
      [addressService, store],
    );

    return provide(context, handler);
  }
}

WalletSetupHandler useWalletSetup(BuildContext context) {
  var handler = Provider.of<WalletSetupHandler>(context);

  return handler;
}
