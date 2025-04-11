import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request.g.dart';

@JsonSerializable()
class SendOtpRequest {
  final String email;

  const SendOtpRequest(this.email);

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpRequestToJson(this);
}
