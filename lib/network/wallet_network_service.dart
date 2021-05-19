import 'dart:convert';

import 'package:etherwallet/model/profile_dto.dart';
import 'package:http/http.dart' as http;

class WalletNetworkService {
  Future<WalletProfile> checkIfWalletExist(String walletAddress) async {
    var queryParams = {'address': walletAddress};
    final response =
        await http.get(Uri.https("demo.url.com", '/wallet', queryParams));
    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);
      dynamic walletProfile = responseMap['wallet'];
      return walletProfile.map((json) => WalletProfile.fromJson(json));
    } else {
      throw Exception('Wallet not found');
    }
  }
}
