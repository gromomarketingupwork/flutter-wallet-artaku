import 'dart:convert';

import 'package:etherwallet/model/profile_dto.dart';
import 'package:http/http.dart' as http;

class ProfileNetworkService {
  Future<WalletProfile> createWalletProfile(WalletProfile walletProfile) async {
    var body = {
      'userName': walletProfile.userName,
      'email': walletProfile.createdAt,
      'walletAddress': walletProfile.walletAddress,
      'profile_image': ''
    };

    var response = await http.post(Uri.https("demo.url.com", '/wallet'),
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      Map responseMap = jsonDecode(response.body);
      dynamic walletProfile = responseMap['wallet'];
      return walletProfile.map((json) => WalletProfile.fromJson(json));
    } else {
      throw Exception('Failed to create profile');
    }
  }
}
