// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:take_it_home/models/VO/user_login.dart';
import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/animal_state.dart';
import 'package:take_it_home/models/animal_state_data.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/comments.dart';
import 'package:take_it_home/models/concern.dart';
import 'package:take_it_home/models/head.dart';
import 'package:take_it_home/models/like.dart';
import 'package:take_it_home/models/mymessage.dart';
import 'package:take_it_home/models/post.dart';
import 'package:take_it_home/models/post_type.dart';
import 'package:take_it_home/models/setting/my_setting.dart';
import 'package:take_it_home/models/sys_user.dart';
import 'package:take_it_home/models/topic.dart';
import 'package:take_it_home/models/user_e.dart';

JsonConvert jsonConvert = JsonConvert();
typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);
typedef EnumConvertFunction<T> = T Function(String value);

class JsonConvert {
	static final Map<String, JsonConvertFunction> convertFuncMap = {
		(UserLogin).toString(): UserLogin.fromJson,
		(Animal).toString(): Animal.fromJson,
		(AnimalState).toString(): AnimalState.fromJson,
		(AnimalStateData).toString(): AnimalStateData.fromJson,
		(BaseBean).toString(): BaseBean.fromJson,
		(Comments).toString(): Comments.fromJson,
		(Concern).toString(): Concern.fromJson,
		(Head).toString(): Head.fromJson,
		(Like).toString(): Like.fromJson,
		(Mymessage).toString(): Mymessage.fromJson,
		(Post).toString(): Post.fromJson,
		(PostType).toString(): PostType.fromJson,
		(MySetting).toString(): MySetting.fromJson,
		(SysUser).toString(): SysUser.fromJson,
		(SysUserUserData).toString(): SysUserUserData.fromJson,
		(Topic).toString(): Topic.fromJson,
		(UserE).toString(): UserE.fromJson,
	};

  T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    try {
      return _asT<T>(value, enumConvert: enumConvert);
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return null;
    }
  }

  List<T?>? convertList<T>(List<dynamic>? value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => _asT<T>(e,enumConvert: enumConvert)).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

List<T>? convertListNotNull<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => _asT<T>(e,enumConvert: enumConvert)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  T? _asT<T extends Object?>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    final String type = T.toString();
    final String valueS = value.toString();
    if (enumConvert != null) {
      return enumConvert(valueS) as T;
    } else if (type == "String") {
      return valueS as T;
    } else if (type == "int") {
      final int? intValue = int.tryParse(valueS);
      if (intValue == null) {
        return double.tryParse(valueS)?.toInt() as T?;
      } else {
        return intValue as T;
      }
    } else if (type == "double") {
      return double.parse(valueS) as T;
    } else if (type == "DateTime") {
      return DateTime.parse(valueS) as T;
    } else if (type == "bool") {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    } else if (type == "Map" || type.startsWith("Map<")) {
      return value as T;
    } else {
      if (convertFuncMap.containsKey(type)) {
        return convertFuncMap[type]!(Map<String, dynamic>.from(value)) as T;
      } else {
        throw UnimplementedError('$type unimplemented');
      }
    }
  }

	//list is returned by type
	static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
		if(<UserLogin>[] is M){
			return data.map<UserLogin>((Map<String, dynamic> e) => UserLogin.fromJson(e)).toList() as M;
		}
		if(<Animal>[] is M){
			return data.map<Animal>((Map<String, dynamic> e) => Animal.fromJson(e)).toList() as M;
		}
		if(<AnimalState>[] is M){
			return data.map<AnimalState>((Map<String, dynamic> e) => AnimalState.fromJson(e)).toList() as M;
		}
		if(<AnimalStateData>[] is M){
			return data.map<AnimalStateData>((Map<String, dynamic> e) => AnimalStateData.fromJson(e)).toList() as M;
		}
		if(<BaseBean>[] is M){
			return data.map<BaseBean>((Map<String, dynamic> e) => BaseBean.fromJson(e)).toList() as M;
		}
		if(<Comments>[] is M){
			return data.map<Comments>((Map<String, dynamic> e) => Comments.fromJson(e)).toList() as M;
		}
		if(<Concern>[] is M){
			return data.map<Concern>((Map<String, dynamic> e) => Concern.fromJson(e)).toList() as M;
		}
		if(<Head>[] is M){
			return data.map<Head>((Map<String, dynamic> e) => Head.fromJson(e)).toList() as M;
		}
		if(<Like>[] is M){
			return data.map<Like>((Map<String, dynamic> e) => Like.fromJson(e)).toList() as M;
		}
		if(<Mymessage>[] is M){
			return data.map<Mymessage>((Map<String, dynamic> e) => Mymessage.fromJson(e)).toList() as M;
		}
		if(<Post>[] is M){
			return data.map<Post>((Map<String, dynamic> e) => Post.fromJson(e)).toList() as M;
		}
		if(<PostType>[] is M){
			return data.map<PostType>((Map<String, dynamic> e) => PostType.fromJson(e)).toList() as M;
		}
		if(<MySetting>[] is M){
			return data.map<MySetting>((Map<String, dynamic> e) => MySetting.fromJson(e)).toList() as M;
		}
		if(<SysUser>[] is M){
			return data.map<SysUser>((Map<String, dynamic> e) => SysUser.fromJson(e)).toList() as M;
		}
		if(<SysUserUserData>[] is M){
			return data.map<SysUserUserData>((Map<String, dynamic> e) => SysUserUserData.fromJson(e)).toList() as M;
		}
		if(<Topic>[] is M){
			return data.map<Topic>((Map<String, dynamic> e) => Topic.fromJson(e)).toList() as M;
		}
		if(<UserE>[] is M){
			return data.map<UserE>((Map<String, dynamic> e) => UserE.fromJson(e)).toList() as M;
		}

		debugPrint("${M.toString()} not found");
	
		return null;
}

	static M? fromJsonAsT<M>(dynamic json) {
		if (json is List) {
			return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
		} else {
			return jsonConvert.convert<M>(json);
		}
	}
}