import 'dart:async';
import 'package:etherwallet/model/nft_color.dart';
import 'package:web3dart/web3dart.dart';

typedef TransferEvent = void Function(
    EthereumAddress from, EthereumAddress to, BigInt value, String transactionId);

abstract class IContractService {
  Future<Credentials> getCredentials(String privateKey);
  Future<String> send(
      String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent onTransfer, Function onError});
  Future<BigInt> getTokenBalance(EthereumAddress from);
  Future<EtherAmount> getEthBalance(EthereumAddress from);
  Future<void> dispose();
  StreamSubscription listenTransfer(TransferEvent onTransfer);
}

class ContractService implements IContractService {
  ContractService(this.client, this.contract);
  String transactionId;
  final Web3Client client;
  final DeployedContract contract;

  ContractEvent _transferEvent() => contract.event('Transfer');
  ContractFunction _balanceFunction() => contract.function('balanceOf');
  ContractFunction _sendFunction() => contract.function('transfer');
  ContractFunction _sendFunctionNFT() => contract.function('transferFrom');
  ContractFunction _checkOwner() => contract.function('ownerOf');
  ContractFunction _getNextTokenId() => contract.function("nextTokenId");
  ContractFunction _getColorFromId() => contract.function("colors");
  Future<Credentials> getCredentials(String privateKey) =>
      client.credentialsFromPrivateKey(privateKey);

  Future<List<NFTColor>> getAllOwnedTokens(BigInt tokenBalance, EthereumAddress from) async {
    var response = await client.call(
      contract: contract,
      function: _getNextTokenId(),
      params: []
    );
    List<NFTColor> colorList = new List();
    BigInt totalSupply =  response.first as BigInt;
    for(BigInt i = BigInt.zero; i< totalSupply ; i=i+BigInt.from(1)){
      var ownerResponse = await client.call(
          contract: contract,
          function: _checkOwner(),
          params: [i]);
      EthereumAddress ownerAddress = ownerResponse.first as EthereumAddress;
      if(ownerAddress == from){
        var colorResponse = await client.call(
            contract: contract,
            function: _getColorFromId(),
            params: [i]);
        NFTColor color = new NFTColor(tokenId: i, colorHex: colorResponse.first as String);
        colorList.add(color);
      }
    }
    return colorList;

  }

  Future<String> sendNFT(
      String privateKey, EthereumAddress receiver, BigInt tokenId,
      {TransferEvent onTransfer, Function onError}) async {
    final credentials = await this.getCredentials(privateKey);
    final from = await credentials.extractAddress();
    final networkId = await client.getNetworkId();

    StreamSubscription event;
    // Workaround once send Transacton doesn't return a Promise containing confirmation / receipt
    if (onTransfer != null) {
      event = listenTransfer((from, to, value, tid) async {
        onTransfer(from, to, value, tid);
        await event.cancel();
      }, take: 1);
    }

    try {
      transactionId = await client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: _sendFunctionNFT(),
          parameters: [from, receiver, tokenId],
          from: from,
        ),
        chainId: networkId,
      );
      print('transact started $transactionId');
      return transactionId;
    } catch (ex) {
      if (onError != null) {
        onError(ex);
      }
      return null;
    }
  }



  Future<String> send(
      String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent onTransfer, Function onError}) async {
    final credentials = await this.getCredentials(privateKey);
    final from = await credentials.extractAddress();
    final networkId = await client.getNetworkId();

    StreamSubscription event;
    // Workaround once sendTransacton doesn't return a Promise containing confirmation / receipt
    if (onTransfer != null) {
      event = listenTransfer((from, to, value, tid) async {
        onTransfer(from, to, value, transactionId);
        await event.cancel();
      }, take: 1);
    }

    try {
      transactionId = await client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: _sendFunction(),
          parameters: [receiver, amount],
          from: from,
        ),
        chainId: networkId,
      );
      print('transact started $transactionId');
      return transactionId;
    } catch (ex) {
      if (onError != null) {
        onError(ex);
      }
      return null;
    }
  }

  Future<EtherAmount> getEthBalance(EthereumAddress from) async {
    return await client.getBalance(from);
  }

  Future<BigInt> getTokenBalance(EthereumAddress from) async {
    var response = await client.call(
      contract: contract,
      function: _balanceFunction(),
      params: [from],
    );

    return response.first as BigInt;
  }

  StreamSubscription listenTransfer(TransferEvent onTransfer, {int take}) {
    var events = client.events(FilterOptions.events(
      contract: contract,
      event: _transferEvent(),
    ));

    if (take != null) {
      events = events.take(take);
    }

    return events.listen((event) {
      final decoded = _transferEvent().decodeResults(event.topics, event.data);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

      print('$from}');
      print('$to}');
      print('$value}');

      onTransfer(from, to, value, transactionId);
    });
  }

  Future<void> dispose() async {
    await client.dispose();
  }
}
