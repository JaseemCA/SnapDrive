import 'package:hive_flutter/hive_flutter.dart';
part 'datamodel.g.dart';

@HiveType(typeId: 1)
class CarModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String vehiclename;

  @HiveField(2)
  String vehicleReg;

  @HiveField(3)
  String fuel;

  @HiveField(4)
  String seater;

  @HiveField(5)
  String dailyrent;

  @HiveField(6)
  String monthlyrent;

  @HiveField(7)
  String selectedImage;

  CarModel({
    this.id,
    required this.vehiclename,
    required this.vehicleReg,
    required this.fuel,
    required this.seater,
    required this.dailyrent,
    required this.monthlyrent,
    required this.selectedImage,
  });
}

@HiveType(typeId: 2)
class CustomerModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String carname;

  @HiveField(2)
  String carReg;

  @HiveField(3)
  String customerName;

  @HiveField(4)
  String mobileNumber;

  @HiveField(5)
  String licenseNumber;

  @HiveField(6)
  String pickupdate;

  @HiveField(7)
  String pickupTime;

  @HiveField(8)
  String dropOffDate;

  @HiveField(9)
  String securityDeposit;

  @HiveField(10)
  String? selectedImage;

  CustomerModel({
    this.id,
    required this.carname,
    required this.carReg,
    required this.customerName,
    required this.mobileNumber,
    required this.licenseNumber,
    required this.pickupdate,
    required this.pickupTime,
    required this.dropOffDate,
    required this.securityDeposit,
    required this.selectedImage,
  });
}
