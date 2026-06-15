
class UpdateDeviceTokenRequestBody {
  final String deviceToken;

  UpdateDeviceTokenRequestBody({required this.deviceToken});

  Map<String, dynamic> toJson() {
    return {
      'device_token': deviceToken,
    };
  }
}
