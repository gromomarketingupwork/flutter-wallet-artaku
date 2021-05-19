part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletProfile _$WalletProfileFromJson(Map<String, dynamic> json) {
  return WalletProfile(
    json['userName'] as String,
    json['email'] as String,
    json['createdAt'] as String,
    json['walletAddress'] as String,
  );
}

Map<String, dynamic> _$WalletProfileToJson(WalletProfile instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'walletAddress': instance.walletAddress,
    };
