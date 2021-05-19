import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';


@JsonSerializable()
class WalletProfile {
  final String userName;
  final String email;
  final String createdAt;
  final String walletAddress;

  WalletProfile(this.userName, this.email, this.createdAt, this.walletAddress);
  factory WalletProfile.fromJson(Map<String, dynamic> json) => _$WalletProfileFromJson(json);
  Map<String, dynamic> toJson() => _$WalletProfileToJson(this);
}
