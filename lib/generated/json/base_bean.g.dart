import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/base_bean.dart';

BaseBean<T> $BaseBeanFromJson<T>(Map<String, dynamic> json) {
	final BaseBean<T> baseBean = BaseBean();
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		baseBean.total = total;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		baseBean.msg = msg;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		baseBean.token = token;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		baseBean.code = code;
	}
	final T? data = jsonConvert.convert<T>(json['data']);
	if (data != null) {
		baseBean.data = data;
	}
	final List<T>? rows = jsonConvert.convertListNotNull<T>(json['rows']);
	if (rows != null) {
		baseBean.rows = rows;
	}
	return baseBean;
}

Map<String, dynamic> $BaseBeanToJson(BaseBean entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['total'] = entity.total;
	data['msg'] = entity.msg;
	data['token'] = entity.token;
	data['code'] = entity.code;
	data['data'] = entity.data?.toJson();
	data['rows'] =  entity.rows?.map((v) => v.toJson()).toList();
	return data;
}