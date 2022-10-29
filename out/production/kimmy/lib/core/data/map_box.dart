import 'package:date_format/date_format.dart';
import 'package:hive/hive.dart';

class MapBox {
  MapBox();

  late Box<Map> _box;

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

  openBox(String name) async {
    _box = await Hive.openBox<Map>(name);
  }

  put(dynamic key,Map<String, dynamic> value) async {
    value["createdTime"] = formatDate(DateTime.now(),[yyyy, mm, dd, HH, nn, ss, SSS]);
    await _box.put(key, value);
  }

  delete(dynamic key) async {
    await _box.delete(key);
  }

  get(dynamic key) {
    _box.get(key);
  }
}
