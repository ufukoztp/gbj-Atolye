



import 'package:gbjatolye/features/domain/entities/notification/registerdevice.dart';

class Registerdevice {
  String success;
  String message;
	String pushDeviceType;
	String pushTarget;
  String deviceId;
  List<TagRequest> tags;
  Registerdevice({this.deviceId,this.pushDeviceType,this.pushTarget,this.tags});

	Registerdevice.fromJsonMap(Map<String, dynamic> map):
		pushDeviceType = map["PushDeviceType"],
		pushTarget = map["PushTarget"],
		deviceId = map["DeviceId"];
		//Tags = List<TagRequest>.from(map["Tags"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['PushDeviceType'] = pushDeviceType;
		data['PushTarget'] = pushTarget;
		data['DeviceId'] = deviceId;
	//	data['Tags'] = Tags;
		return data;
	}
}
