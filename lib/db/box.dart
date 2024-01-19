import 'package:hive_flutter/hive_flutter.dart';
import 'package:snapdrive/db/datamodel.dart';

class Boxes {
  static Box<CarModel> getData() => Hive.box<CarModel>('car_db');
}
