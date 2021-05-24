import 'dart:convert';
import 'dart:io';

import 'package:etherwallet/model/profile_dto.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProfileNetworkService {
  Future<WalletProfile> createWalletProfile(
      String address, String userName, String email, File profilePhoto) async {
    var request = http.MultipartRequest(
        'POST',
        Uri(
            scheme: 'https',
            host: '65c4e4bd-efbb-4e64-b2d2-705b78423e8d.mock.pstmn.io',
            path: '/user/' + address));
    Map<String, String> requestForm = <String, String>{
      'username': userName,
      'email': email
    };
    request.fields.addAll(requestForm);
    request.files.add(http.MultipartFile.fromBytes(
        'profile_photo', profilePhoto.readAsBytesSync(),
        filename: profilePhoto.path.split('/').last,
        contentType: MediaType(
            'image', profilePhoto.path.split('/').last.split('.').last)));
    var response = await request.send();
    Map<String, dynamic> data = {};
    if (response.statusCode == 200) {
      data = jsonDecode(await response.stream.transform(utf8.decoder).join());
      return WalletProfile.fromJson(data);
    } else {
      throw Exception('Failed to create profile');
    }
  }
}
