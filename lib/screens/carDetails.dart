// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/db/box.dart';
// import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/db/datamodel.dart';
// import 'package:snapdrive/screens/addcar.dart';
import 'package:snapdrive/screens/updatecar.dart';
// import 'package:snapdrive/screens/addcar.dart';

// ignore: camel_case_types
class cardetails extends StatefulWidget {
  final CarModel cars;

  const cardetails({Key? key, required this.cars}) : super(key: key);

  @override
  State<cardetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<cardetails> {
  var vehiclenameController = TextEditingController();
  var vehicleRegController = TextEditingController();
  var dailyrentController = TextEditingController();
  var monthlyrentController = TextEditingController();
  File? imagepath;
  String? selectedImage;
  String? selectedFuel;
  String? selectedSeat;
  // get pickImageFromGallery => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          "CAR DETAILS",
          style: TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
      ),
      body: ValueListenableBuilder<Box<CarModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            // var data = box.values.toList().cast<CarModel>();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 90, right: 90, top: 20, bottom: 10),
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.amber,
                            Colors.orange,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 50,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(widget.cars.selectedImage),
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          widget.cars.vehiclename,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "REG number",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          widget.cars.vehicleReg,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Fuel",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          widget.cars.fuel,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Seater",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          widget.cars.seater,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Daily Rent",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          widget.cars.dailyrent,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Monthly Rent",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          widget.cars.monthlyrent,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // final data = carsList[index];
                          // print('Car ID before deletion: ${widget.cars.id}');
                          // if (widget.cars.id != null) {
                          //   deleteCar(widget.cars.id!);
                          //   Navigator.of(context).pop();
                          // } else {
                          //   print('Cant delete, car ID is null.');
                          // }
                          deletecar(widget.cars);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor:
                              const Color.fromARGB(255, 10, 47, 39),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                        child: const Text('DELETE'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          editCar(
                              widget.cars,
                              widget.cars.vehiclename.toString(),
                              widget.cars.vehicleReg.toString(),
                              widget.cars.fuel.toString(),
                              widget.cars.seater.toString(),
                              widget.cars.dailyrent.toString(),
                              widget.cars.monthlyrent.toString(),
                              widget.cars.selectedImage.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 10, 47, 39),
                          foregroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                        child: const Text('UPDATE'),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }

  Future<void> editCar(
    CarModel modelcar,
    String carName,
    String carReg,
    String fuel,
    String seater,
    String rentDaily,
    String rentMonthly,
    String carImage,
  ) async {
    vehiclenameController.text = carName;
    vehicleRegController.text = carReg;
    dailyrentController.text = rentDaily;
    monthlyrentController.text = rentMonthly;
    selectedSeat = seater;
    selectedFuel = fuel;
    selectedImage = carImage;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Updatecar(modelcar: modelcar),
    ));
  }
}
