import 'dart:convert';

import 'package:etherwallet/model/profile_dto.dart';
import 'package:http/http.dart' as http;

class WalletNetworkService {
  Future<WalletProfile> checkIfWalletExist(String walletAddress) async {
    final response =
        await http.get(Uri.https("65c4e4bd-efbb-4e64-b2d2-705b78423e8d.mock.pstmn.io", '/user/'+ walletAddress+".json"));
    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);
      return WalletProfile.fromJson(responseMap);
    } else {
      throw Exception('Wallet not found');
    }
  }
}
