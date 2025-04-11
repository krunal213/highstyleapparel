// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpResponse _$SendOtpResponseFromJson(Map<String, dynamic> json) =>
    SendOtpResponse(
      json['message'] as String,
      json['sessionId'] as String,
    );

Map<String, dynamic> _$SendOtpResponseToJson(SendOtpResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'sessionId': instance.sessionId,
    };
