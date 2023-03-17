import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/base_bean.g.dart';
import 'dart:convert';

@JsonSerializable()
class BaseBean<T>{

	int? total;
	String? msg;
  String? token;
	int? code;
	T? data;
	List<T>? rows;
  
  BaseBean();


  factory BaseBean.fromJson(Map<String, dynamic> json) => $BaseBeanFromJson<T>(json);

  Map<String, dynamic> toJson() => $BaseBeanToJson(this);

  BaseBean copyWith({int? total, String? msg, int? code, T? data, List<T>? rows,String? token}) {
      return BaseBean()..total= total ?? this.total
			..msg= msg ?? this.msg
			..code= code ?? this.code
			..data= data ?? this.data
      ..token= token ?? this.token
			..rows= rows ?? this.rows;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}