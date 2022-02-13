class SettingResponse {
  bool success;

  SettingResponse.fromJsonMap(Map<String, dynamic> map) :
        success=map["success"];
}