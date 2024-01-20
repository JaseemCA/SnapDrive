import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snapdrive/db/datamodel.dart';

ValueNotifier<List<CarModel>> carListNotifier = ValueNotifier([]);
ValueNotifier<List<CustomerModel>> customerListNotifier = ValueNotifier([]);

Future<void> addCar(CarModel value) async {
  final carDB = await Hive.openBox<CarModel>('car_db');
  final id = await carDB.add(value);
  value.id = id;
  carListNotifier.value.add(value);
  carListNotifier.notifyListeners();
}

Future<void> addCustomer(CustomerModel value) async {
  final customerDB = await Hive.openBox<CustomerModel>('customer_db');
  final id = await customerDB.add(value);
  value.id = id;
  customerListNotifier.value.add(value);
  customerListNotifier.notifyListeners();
  print(value);
}

Future<void> getAllCars() async {
  final carDB = await Hive.openBox<CarModel>('car_db');
  carListNotifier.value.clear();
  carListNotifier.value.addAll(carDB.values);
  carListNotifier.notifyListeners();
}

Future<void> getAllCustomers() async {
  final customerDB = await Hive.openBox<CustomerModel>('customer_db');
  customerListNotifier.value.clear();
  customerListNotifier.value.addAll(customerDB.values);
  customerListNotifier.notifyListeners();
}

Future<void> deletecar(CarModel modelcar) async {
  await modelcar.delete();
  getAllCars();
}

Future<void> deleteCustomer(CustomerModel modelCustomer) async {
  await modelCustomer.delete();
  getAllCustomers();
}
