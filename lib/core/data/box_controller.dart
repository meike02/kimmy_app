import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kimmy/core/utils/json_factory.dart';
import 'package:kimmy/data/model/base_model.dart';

enum InitState{
  dealing,
  failed,
  succeed
}

class BoxController<T extends BaseModel> extends GetxController{
  BoxController();
  late Box<Map> _box;
  bool _dealing = false;
  bool _initialized = false;
  List<T> modelList = [];

  bool get dealing => _dealing;

  List<Map<String, dynamic>> get values {
    final valueList = _box.values
        .map((value) => Map<String, dynamic>.from(value))
        .toList();
    valueList.sort((leftValue,rightValue){
      String leftCreatedTime = leftValue["createdTime"];
      String rightCreatedTime = rightValue["createdTime"];
      return leftCreatedTime.compareTo(rightCreatedTime);
    });
    return valueList;
  }

  add(T modelData,{int? index}) async {
    if(get(modelData.id)!=null){
      throw Exception("id不可重复！");
    }
    await _put(modelData.id,JsonFactory.toJson(modelData));
    modelList.add(modelData);
    update();
  }

  edit(T modelData) async {
    bool updated = false;
    modelList = modelList.map((modelDataElement){
      if(modelDataElement.id==modelData.id){
        updated = true;
        return modelData;
      }
      return modelDataElement;
    }).toList();

    if(!updated){
      throw ("id不可更新！");
    }
    await _put(modelData.id, JsonFactory.toJson(modelData));
  }

  _put(dynamic key,Map<String, dynamic> value) async {
    _dealing = true;
    value["createdTime"] = formatDate(DateTime.now(),[yyyy, mm, dd, HH, nn, ss, SSS]);
    await _box.put(key, value);
    _dealing = false;
  }

  deleteById(String id) async {
    _dealing = true;
    await _box.delete(id);
    _dealing = false;
    modelList.removeWhere((modelItem) => modelItem.id==id);
    update();
  }

  delete(T modelData) async {
    deleteById(modelData.id);
  }

  Map<String, dynamic>? get(dynamic key) {
    final value = _box.get(key);
    if(value != null){
      return Map<String,dynamic>.from(value);
    }
    return null;
  }

  @mustCallSuper
  loadingData() async {
    modelList = JsonFactory.fromJsonToList<T>(values);
  }

  @override
  bool get initialized => _initialized;

  @override
  onInit() async {
    super.onInit();
    _box = await Hive.openBox<Map>(T.toString());
    await loadingData();
    // _box.deleteFromDisk();
    _initialized = true;
    update();
  }
}