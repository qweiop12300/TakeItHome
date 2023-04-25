import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/sys_user.dart';

SysUser $SysUserFromJson(Map<String, dynamic> json) {
	final SysUser sysUser = SysUser();
	final String? createBy = jsonConvert.convert<String>(json['createBy']);
	if (createBy != null) {
		sysUser.createBy = createBy;
	}
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		sysUser.createTime = createTime;
	}
	final dynamic updateBy = jsonConvert.convert<dynamic>(json['updateBy']);
	if (updateBy != null) {
		sysUser.updateBy = updateBy;
	}
	final dynamic updateTime = jsonConvert.convert<dynamic>(json['updateTime']);
	if (updateTime != null) {
		sysUser.updateTime = updateTime;
	}
	final String? remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		sysUser.remark = remark;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		sysUser.userId = userId;
	}
	final int? deptId = jsonConvert.convert<int>(json['deptId']);
	if (deptId != null) {
		sysUser.deptId = deptId;
	}
	final String? userName = jsonConvert.convert<String>(json['userName']);
	if (userName != null) {
		sysUser.userName = userName;
	}
	final String? nickName = jsonConvert.convert<String>(json['nickName']);
	if (nickName != null) {
		sysUser.nickName = nickName;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		sysUser.email = email;
	}
	final String? phonenumber = jsonConvert.convert<String>(json['phonenumber']);
	if (phonenumber != null) {
		sysUser.phonenumber = phonenumber;
	}
	final String? sex = jsonConvert.convert<String>(json['sex']);
	if (sex != null) {
		sysUser.sex = sex;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		sysUser.avatar = avatar;
	}
	final String? password = jsonConvert.convert<String>(json['password']);
	if (password != null) {
		sysUser.password = password;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		sysUser.status = status;
	}
	final String? delFlag = jsonConvert.convert<String>(json['delFlag']);
	if (delFlag != null) {
		sysUser.delFlag = delFlag;
	}
	final String? loginIp = jsonConvert.convert<String>(json['loginIp']);
	if (loginIp != null) {
		sysUser.loginIp = loginIp;
	}
	final String? loginDate = jsonConvert.convert<String>(json['loginDate']);
	if (loginDate != null) {
		sysUser.loginDate = loginDate;
	}
	final SysUserUserData? userData = jsonConvert.convert<SysUserUserData>(json['userData']);
	if (userData != null) {
		sysUser.userData = userData;
	}
	final dynamic roleIds = jsonConvert.convert<dynamic>(json['roleIds']);
	if (roleIds != null) {
		sysUser.roleIds = roleIds;
	}
	final dynamic postIds = jsonConvert.convert<dynamic>(json['postIds']);
	if (postIds != null) {
		sysUser.postIds = postIds;
	}
	final dynamic roleId = jsonConvert.convert<dynamic>(json['roleId']);
	if (roleId != null) {
		sysUser.roleId = roleId;
	}
	final bool? admin = jsonConvert.convert<bool>(json['admin']);
	if (admin != null) {
		sysUser.admin = admin;
	}
	return sysUser;
}

Map<String, dynamic> $SysUserToJson(SysUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['createBy'] = entity.createBy;
	data['createTime'] = entity.createTime;
	data['updateBy'] = entity.updateBy;
	data['updateTime'] = entity.updateTime;
	data['remark'] = entity.remark;
	data['userId'] = entity.userId;
	data['deptId'] = entity.deptId;
	data['userName'] = entity.userName;
	data['nickName'] = entity.nickName;
	data['email'] = entity.email;
	data['phonenumber'] = entity.phonenumber;
	data['sex'] = entity.sex;
	data['avatar'] = entity.avatar;
	data['password'] = entity.password;
	data['status'] = entity.status;
	data['delFlag'] = entity.delFlag;
	data['loginIp'] = entity.loginIp;
	data['loginDate'] = entity.loginDate;
	data['userData'] = entity.userData.toJson();
	data['roleIds'] = entity.roleIds;
	data['postIds'] = entity.postIds;
	data['roleId'] = entity.roleId;
	data['admin'] = entity.admin;
	return data;
}

SysUserUserData $SysUserUserDataFromJson(Map<String, dynamic> json) {
	final SysUserUserData sysUserUserData = SysUserUserData();
	final int? uid = jsonConvert.convert<int>(json['uid']);
	if (uid != null) {
		sysUserUserData.uid = uid;
	}
	final dynamic desc = jsonConvert.convert<dynamic>(json['desc']);
	if (desc != null) {
		sysUserUserData.desc = desc;
	}
	final dynamic year = jsonConvert.convert<dynamic>(json['year']);
	if (year != null) {
		sysUserUserData.year = year;
	}
	final dynamic toUid = jsonConvert.convert<dynamic>(json['toUid']);
	if (toUid != null) {
		sysUserUserData.toUid = toUid;
	}
	final dynamic s1 = jsonConvert.convert<dynamic>(json['s1']);
	if (s1 != null) {
		sysUserUserData.s1 = s1;
	}
	final dynamic s2 = jsonConvert.convert<dynamic>(json['s2']);
	if (s2 != null) {
		sysUserUserData.s2 = s2;
	}
	return sysUserUserData;
}

Map<String, dynamic> $SysUserUserDataToJson(SysUserUserData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['uid'] = entity.uid;
	data['desc'] = entity.desc;
	data['year'] = entity.year;
	data['toUid'] = entity.toUid;
	data['s1'] = entity.s1;
	data['s2'] = entity.s2;
	return data;
}