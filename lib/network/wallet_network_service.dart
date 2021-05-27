import 'dart:convert';

import 'package:etherwallet/constants/an_paths.dart';
import 'package:etherwallet/constants/an_urls.dart';
import 'package:etherwallet/model/profile_dto.dart';
import 'package:http/http.dart' as http;

class WalletNetworkService {
  Future<WalletProfile> checkIfWalletExist(String walletAddress) async {
    final response =
        await http.get(Uri.https(ANUrl.AN_URL, ANPaths.USERS+'/'+ walletAddress+".json"));
    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);
      return WalletProfile.fromJson(responseMap);
    } else {
      throw Exception('Wallet not found');
    }
  }
}
