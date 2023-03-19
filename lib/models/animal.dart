import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/animal.g.dart';
import 'dart:convert';

@JsonSerializable()
class Animal {

	int? id;
	dynamic sid;
	dynamic appAnimalStateData;
	String? name;
	int? sex;
	String? icon;
	String? createDate;
	dynamic year;
	dynamic s1;
	dynamic s2;
	dynamic appAnimalState;
  
  Animal();

  factory Animal.fromJson(Map<String, dynamic> json) => $AnimalFromJson(json);

  Map<String, dynamic> toJson() => $AnimalToJson(this);

  Animal copyWith({int? id, dynamic sid, dynamic appAnimalStateData, String? name, int? sex, String? icon, String? createDate, dynamic year, dynamic s1, dynamic s2, dynamic appAnimalState}) {
      return Animal()..id= id ?? this.id
			..sid= sid ?? this.sid
			..appAnimalStateData= appAnimalStateData ?? this.appAnimalStateData
			..name= name ?? this.name
			..sex= sex ?? this.sex
			..icon= icon ?? this.icon
			..createDate= createDate ?? this.createDate
			..year= year ?? this.year
			..s1= s1 ?? this.s1
			..s2= s2 ?? this.s2
			..appAnimalState= appAnimalState ?? this.appAnimalState;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}