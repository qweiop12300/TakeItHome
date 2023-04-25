import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/sys_user.g.dart';
import 'dart:convert';

@JsonSerializable()
class SysUser {
	late String createBy;
	late String createTime;
	dynamic updateBy;
	dynamic updateTime;
	late String remark;
	late int userId;
	late int deptId;
	late String userName;
	late String nickName;
	late String email;
	late String phonenumber;
	late String sex;
	late String avatar;
	late String password;
	late String status;
	late String delFlag;
	late String loginIp;
	late String loginDate;
	late SysUserUserData userData;
	dynamic roleIds;
	dynamic postIds;
	dynamic roleId;
	late bool admin;

	SysUser();

	factory SysUser.fromJson(Map<String, dynamic> json) => $SysUserFromJson(json);

	Map<String, dynamic> toJson() => $SysUserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SysUserUserData {
	late int uid;
	dynamic desc;
	dynamic year;
	dynamic toUid;
	dynamic s1;
	dynamic s2;

	SysUserUserData();

	factory SysUserUserData.fromJson(Map<String, dynamic> json) => $SysUserUserDataFromJson(json);

	Map<String, dynamic> toJson() => $SysUserUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}