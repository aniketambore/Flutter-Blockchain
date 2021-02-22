class AppConfig {
  Map<String, AppConfigParams> params = Map<String, AppConfigParams>();

  AppConfig() {
    params["dev"] = AppConfigParams(
        "http://192.168.182.2:7546",
        "ws://192.168.182.2:7546",
        "0x59FFB6Ea7bb59DAa2aC480D862d375F49F73915d");

    params["ropsten"] = AppConfigParams(
        "https://ropsten.infura.io/v3/628074215a2449eb960b4fe9e95feb09",
        "wss://ropsten.infura.io/ws/v3/628074215a2449eb960b4fe9e95feb09",
        "0x5060b60cb8Bd1C94B7ADEF4134555CDa7B45c461");
  }
}

class AppConfigParams {
  final String rpcUrl;

  final String wsurl;

  final String contractAddress;

  AppConfigParams(this.rpcUrl, this.wsurl, this.contractAddress);
}
