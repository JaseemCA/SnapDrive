import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snapdrive/db/box.dart';
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
  // print(value);
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

List<CarModel> searchCars(String query) {
  final carDB = Hive.box<CarModel>('car_db');
  final List<CarModel> allCars = carDB.values.toList();

  if (query.isEmpty) {
    return allCars;
  }

  final List<CarModel> searchResults = allCars
      .where(
          (car) => car.vehiclename.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return searchResults;
}

List<CustomerModel> searchCustomers(String query) {
  final customerDB = Hive.box<CustomerModel>('customer_db');
  final List<CustomerModel> allCustomers = customerDB.values.toList();

  if (query.isEmpty) {
    return allCustomers;
  }

  final List<CustomerModel> searchResults = allCustomers
      .where((customer) =>
          customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          customer.carname.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return searchResults;
}

List<CarModel> removedCarsList = [];
void removeCarFromScreen(CarModel car) {
  removedCarsList.add(car);
  carListNotifier.value.remove(car);
  Boxes.getData().delete(car.key);

  carListNotifier.notifyListeners();
}

List<CarModel> getRemovedCars() {
  return removedCarsList;
}

void clearRemovedCars() {
  removedCarsList.clear();
}

List<CustomerModel> removedCustomersList = [];
void removeCustomerFromScreen(CustomerModel customer) {
  removedCustomersList.add(customer);
  customerListNotifier.value.remove(customer);
  Boxes.getCustomerData().delete(customer.key);
}

List<CustomerModel> getRemovedCustomers() {
  return removedCustomersList;
}

void clearRemovedCustomers() {
  removedCustomersList.clear();
}
