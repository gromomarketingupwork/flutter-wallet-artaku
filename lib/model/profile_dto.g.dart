// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletProfile _$WalletProfileFromJson(Map<String, dynamic> json) {
  return WalletProfile(
    json['username'] as String,
    json['address'] as String,
    json['profile_photo'] as String,
  );
}

Map<String, dynamic> _$WalletProfileToJson(WalletProfile instance) =>
    <String, dynamic>{
      'username': instance.userName,
      'address': instance.address,
      'profile_photo': instance.profilePhoto,
    };
