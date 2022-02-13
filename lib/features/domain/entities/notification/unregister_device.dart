class UnRegister{
  String deviceid;

  UnRegister({this.deviceid});

  Map<String, dynamic> toJson(deviceId) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeviceId'] = deviceId;
    return data;
  }
}