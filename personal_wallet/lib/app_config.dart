class AppConfig {
  Map<String, AppConfigParams> params = Map<String, AppConfigParams>();

  AppConfig() {
    params["dev"] = AppConfigParams(
        "http://10.0.2.2:7545",
        "ws://10.0.2.2:7545/",
        "0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925");

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
