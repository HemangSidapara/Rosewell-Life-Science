import 'dart:convert';

/// code : "200"
/// msg : "Get Medicine Successfully"
/// Data : [{"p_id":"23","name":"asd","model_meta":[{"meta_id":"6","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240736041.work-in-progress"},{"meta_id":"7","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240736042.untitled (1)"}]},{"p_id":"1","name":"fff","model_meta":[]},{"p_id":"2","name":"sds","model_meta":[]},{"p_id":"3","name":"asd","model_meta":[]},{"p_id":"4","name":"SS","model_meta":[]},{"p_id":"5","name":"asds","model_meta":[]},{"p_id":"6","name":"sd","model_meta":[]},{"p_id":"7","name":"asd","model_meta":[]},{"p_id":"8","name":"asd","model_meta":[]},{"p_id":"9","name":"asd","model_meta":[]},{"p_id":"10","name":"Test","model_meta":[]},{"p_id":"11","name":"Test","model_meta":[]},{"p_id":"12","name":"Test","model_meta":[{"meta_id":"1","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240725331.png"}]},{"p_id":"13","name":"Test","model_meta":[{"meta_id":"2","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240725571.png"}]},{"p_id":"14","name":"asd","model_meta":[]},{"p_id":"15","name":"Test","model_meta":[{"meta_id":"3","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240728131.png"}]},{"p_id":"16","name":"sd","model_meta":[]},{"p_id":"17","name":"sda","model_meta":[{"meta_id":"4","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240729391.png"}]},{"p_id":"18","name":"asd","model_meta":[]},{"p_id":"19","name":"sad","model_meta":[]},{"p_id":"20","name":"asds","model_meta":[]},{"p_id":"21","name":"asd","model_meta":[]},{"p_id":"22","name":"asd","model_meta":[{"meta_id":"5","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240733321.png"}]}]

GetMedicineModel getMedicineModelFromJson(String str) => GetMedicineModel.fromJson(json.decode(str));

String getMedicineModelToJson(GetMedicineModel data) => json.encode(data.toJson());

class GetMedicineModel {
  GetMedicineModel({
    String? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetMedicineModel.fromJson(dynamic json) {
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

  GetMedicineModel copyWith({
    String? code,
    String? msg,
    List<Data>? data,
  }) =>
      GetMedicineModel(
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

/// p_id : "23"
/// name : "asd"
/// model_meta : [{"meta_id":"6","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240736041.work-in-progress"},{"meta_id":"7","image":"https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240736042.untitled (1)"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? pId,
    String? name,
    List<ProductMeta>? productMeta,
  }) {
    _pId = pId;
    _name = name;
    _productMeta = productMeta;
  }

  Data.fromJson(dynamic json) {
    _pId = json['p_id'];
    _name = json['name'];
    if (json['product_meta'] != null) {
      _productMeta = [];
      json['product_meta'].forEach((v) {
        _productMeta?.add(ProductMeta.fromJson(v));
      });
    }
  }

  String? _pId;
  String? _name;
  List<ProductMeta>? _productMeta;

  Data copyWith({
    String? pId,
    String? name,
    List<ProductMeta>? productMeta,
  }) =>
      Data(
        pId: pId ?? _pId,
        name: name ?? _name,
        productMeta: productMeta ?? _productMeta,
      );

  String? get pId => _pId;

  String? get name => _name;

  List<ProductMeta>? get productMeta => _productMeta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['p_id'] = _pId;
    map['name'] = _name;
    if (_productMeta != null) {
      map['product_meta'] = _productMeta?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// meta_id : "6"
/// image : "https://mindwaveinfoway.com/RosewellLifescience/AdminPanel/WebApi/product/200120240736041.work-in-progress"

ProductMeta productMetaFromJson(String str) => ProductMeta.fromJson(json.decode(str));

String productMetaToJson(ProductMeta data) => json.encode(data.toJson());

class ProductMeta {
  ProductMeta({
    String? metaId,
    String? image,
  }) {
    _metaId = metaId;
    _image = image;
  }

  ProductMeta.fromJson(dynamic json) {
    _metaId = json['meta_id'];
    _image = json['image'];
  }

  String? _metaId;
  String? _image;

  ProductMeta copyWith({
    String? metaId,
    String? image,
  }) =>
      ProductMeta(
        metaId: metaId ?? _metaId,
        image: image ?? _image,
      );

  String? get metaId => _metaId;

  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['meta_id'] = _metaId;
    map['image'] = _image;
    return map;
  }
}
