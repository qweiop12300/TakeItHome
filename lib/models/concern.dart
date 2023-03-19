import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/concern.g.dart';
import 'dart:convert';

@JsonSerializable()
class Concern {

	int? id;
	int? uid;
	int? toUid;
	dynamic toAid;
	dynamic toTid;
	String? createDate;
  
  Concern();

  factory Concern.fromJson(Map<String, dynamic> json) => $ConcernFromJson(json);

  Map<String, dynamic> toJson() => $ConcernToJson(this);

  Concern copyWith({int? id, int? uid, int? toUid, dynamic toAid, dynamic toTid, String? createDate}) {
      return Concern()..id= id ?? this.id
			..uid= uid ?? this.uid
			..toUid= toUid ?? this.toUid
			..toAid= toAid ?? this.toAid
			..toTid= toTid ?? this.toTid
			..createDate= createDate ?? this.createDate;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}