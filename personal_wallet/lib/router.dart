import 'package:flutter/cupertino.dart';
import 'package:personal_wallet/service/configuration_service.dart';
import 'package:provider/provider.dart';
import 'package:personal_wallet/intro_page.dart';

Map<String, WidgetBuilder> getRoutes(context) {
  return {
    "/": (BuildContext context) {
      var configurationService = Provider.of<ConfigurationService>(context);
      return IntroPage();
    },
    "/create": (BuildContext context) {}
  };
}
