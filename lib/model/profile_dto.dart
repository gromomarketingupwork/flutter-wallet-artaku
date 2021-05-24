import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';


@JsonSerializable()
class WalletProfile {
  @JsonKey(name: "username")
  final String userName;
  @JsonKey(name: "address")
  final String address;
  @JsonKey(name: "profile_photo")
  final String profilePhoto;


  WalletProfile(this.userName, this.address, this.profilePhoto);
  factory WalletProfile.fromJson(Map<String, dynamic> json) => _$WalletProfileFromJson(json);
  Map<String, dynamic> toJson() => _$WalletProfileToJson(this);
}
