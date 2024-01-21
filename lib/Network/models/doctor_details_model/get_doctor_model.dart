import 'dart:convert';

/// code : "200"
/// msg : "Get Medicine Successfully"
/// Data : [{"d_id":"1","name":"Test","doctor_meta":[{"meta_id":"10","product_meta":[{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028271.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028272.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125071.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125072.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125073.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125074.png"}]},{"meta_id":"11","product_meta":[{"p_id":"2","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028501.png"}]}]},{"d_id":"2","name":"Doc 1","doctor_meta":[{"meta_id":"12","product_meta":[{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028271.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028272.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125071.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125072.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125073.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125074.png"}]},{"meta_id":"13","product_meta":[{"p_id":"2","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028501.png"}]},{"meta_id":"14","product_meta":[{"p_id":"3","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241101441.png"},{"p_id":"3","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241101442.png"},{"p_id":"3","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241101443.png"}]}]},{"d_id":"3","name":"Doc 2","doctor_meta":[{"meta_id":"15","product_meta":[{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028271.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028272.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125071.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125072.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125073.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125074.png"}]},{"meta_id":"16","product_meta":[{"p_id":"2","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028501.png"}]},{"meta_id":"17","product_meta":[{"p_id":"3","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241101441.png"},{"p_id":"3","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241101442.png"},{"p_id":"3","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241101443.png"}]}]}]

GetDoctorModel getDoctorModelFromJson(String str) => GetDoctorModel.fromJson(json.decode(str));
String getDoctorModelToJson(GetDoctorModel data) => json.encode(data.toJson());

class GetDoctorModel {
  GetDoctorModel({
    String? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetDoctorModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _code;
  String? _msg;
  List<Data>? _data;
  GetDoctorModel copyWith({
    String? code,
    String? msg,
    List<Data>? data,
  }) =>
      GetDoctorModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );
  String? get code => _code;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// d_id : "1"
/// name : "Test"
/// doctor_meta : [{"meta_id":"10","product_meta":[{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028271.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028272.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125071.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125072.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125073.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125074.png"}]},{"meta_id":"11","product_meta":[{"p_id":"2","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028501.png"}]}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? dId,
    String? name,
    List<DoctorMeta>? doctorMeta,
  }) {
    _dId = dId;
    _name = name;
    _doctorMeta = doctorMeta;
  }

  Data.fromJson(dynamic json) {
    _dId = json['d_id'];
    _name = json['name'];
    if (json['doctor_meta'] != null) {
      _doctorMeta = [];
      json['doctor_meta'].forEach((v) {
        _doctorMeta?.add(DoctorMeta.fromJson(v));
      });
    }
  }
  String? _dId;
  String? _name;
  List<DoctorMeta>? _doctorMeta;
  Data copyWith({
    String? dId,
    String? name,
    List<DoctorMeta>? doctorMeta,
  }) =>
      Data(
        dId: dId ?? _dId,
        name: name ?? _name,
        doctorMeta: doctorMeta ?? _doctorMeta,
      );
  String? get dId => _dId;
  String? get name => _name;
  List<DoctorMeta>? get doctorMeta => _doctorMeta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['d_id'] = _dId;
    map['name'] = _name;
    if (_doctorMeta != null) {
      map['doctor_meta'] = _doctorMeta?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// meta_id : "10"
/// product_meta : [{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028271.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028272.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125071.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125072.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125073.png"},{"p_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241125074.png"}]

DoctorMeta doctorMetaFromJson(String str) => DoctorMeta.fromJson(json.decode(str));
String doctorMetaToJson(DoctorMeta data) => json.encode(data.toJson());

class DoctorMeta {
  DoctorMeta({
    String? metaId,
    String? name,
    List<ProductMeta>? productMeta,
  }) {
    _metaId = metaId;
    _name = name;
    _productMeta = productMeta;
  }

  DoctorMeta.fromJson(dynamic json) {
    _metaId = json['meta_id'];
    _name = json['name'];
    if (json['product_meta'] != null) {
      _productMeta = [];
      json['product_meta'].forEach((v) {
        _productMeta?.add(ProductMeta.fromJson(v));
      });
    }
  }
  String? _metaId;
  String? _name;
  List<ProductMeta>? _productMeta;
  DoctorMeta copyWith({
    String? metaId,
    String? name,
    List<ProductMeta>? productMeta,
  }) =>
      DoctorMeta(
        metaId: metaId ?? _metaId,
        name: name ?? _name,
        productMeta: productMeta ?? _productMeta,
      );
  String? get metaId => _metaId;
  String? get name => _name;
  List<ProductMeta>? get productMeta => _productMeta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['meta_id'] = _metaId;
    map['name'] = _name;
    if (_productMeta != null) {
      map['product_meta'] = _productMeta?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// p_id : "1"
/// image : "https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/210120241028271.png"

ProductMeta productMetaFromJson(String str) => ProductMeta.fromJson(json.decode(str));
String productMetaToJson(ProductMeta data) => json.encode(data.toJson());

class ProductMeta {
  ProductMeta({
    String? pId,
    String? image,
  }) {
    _pId = pId;
    _image = image;
  }

  ProductMeta.fromJson(dynamic json) {
    _pId = json['p_id'];
    _image = json['image'];
  }
  String? _pId;
  String? _image;
  ProductMeta copyWith({
    String? pId,
    String? image,
  }) =>
      ProductMeta(
        pId: pId ?? _pId,
        image: image ?? _image,
      );
  String? get pId => _pId;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['p_id'] = _pId;
    map['image'] = _image;
    return map;
  }
}
