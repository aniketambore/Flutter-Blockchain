import 'package:http/http.dart';
import 'package:personal_wallet/app_config.dart';
import 'package:personal_wallet/service/address_service.dart';
import 'package:personal_wallet/service/configuration_service.dart';
import 'package:personal_wallet/service/contract_service.dart';
import 'package:personal_wallet/utils/contract_parser.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

Future<List<SingleChildWidget>> createProviders(AppConfigParams params) async {
  final client = await Web3Client(params.rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(params.wsurl).cast<String>();
  });

  final sharedPrefs = await SharedPreferences.getInstance();

  final configurationService = ConfigurationService(sharedPrefs);
  final addressService = AddressService(configurationService);
  //final contract = ContractParser.fromAssets(params.contractAddress);

  //final contractService = ContractService(client);
  final contractService = ContractService();

  return [
    Provider.value(value: addressService),
    Provider.value(value: contractService),
    Provider.value(value: configurationService),
  ];
}
