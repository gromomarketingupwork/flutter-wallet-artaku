class AppConfig {
  AppConfig() {
    params['dev'] = AppConfigParams(
        "http://192.168.40.197:8545",
        "ws://192.168.40.197:8545",
        "0xD933a953f4786Eed5E58D234dFeadE15c96bAa8b");

    params['ropsten'] = AppConfigParams(
        "https://ropsten.infura.io/v3/7d7d1bc91230496c9513892f869b3953",
        "wss://ropsten.infura.io/ws/v3/7d7d1bc91230496c9513892f869b3953",
        "0x81f964f7BF807C279db050C76A3A02152a923e5E");
  }

  Map<String, AppConfigParams> params = Map<String, AppConfigParams>();
}

class AppConfigParams {
  AppConfigParams(this.web3HttpUrl, this.web3RdpUrl, this.contractAddress);
  final String web3RdpUrl;
  final String web3HttpUrl;
  final String contractAddress;
}
