import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snapdrive/db/box.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/customer_details.dart';
import 'package:snapdrive/screens/dropofdetails.dart';

class Rentoutcars extends StatefulWidget {
  final CarModel? selectedCar;
  // final CarModel carModel;

  const Rentoutcars({
    super.key,
    this.selectedCar,
    // required this.carModel,
  });

  @override
  State<Rentoutcars> createState() => _RentoutcarsState();
}

class _RentoutcarsState extends State<Rentoutcars> {
  final carnameController = TextEditingController();
  final carRegController = TextEditingController();
  final customerNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final pickupdate = TextEditingController();
  final pickupTime = TextEditingController();
  final dropOffDate = TextEditingController();
  final securityDepositController = TextEditingController();
  String? selectedImage;
  File? imagepath;

  TimeOfDay timeOfDay = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    if (widget.selectedCar != null) {
      selectedImage = widget.selectedCar!.selectedImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 251, 252),
      body: ValueListenableBuilder<Box<CustomerModel>>(
          valueListenable: Boxes.getCustomerData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<CustomerModel>();

            if (data.isEmpty) {
              return const Center(
                child: Text(
                  'NO RENTOUT CARS',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    bool isLastItem = index == data.length - 1;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: isLastItem ? 75 : 0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                  File(data[index].selectedImage.toString())),
                              radius: 30,
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data[index].carname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data[index].customerName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            trailing: Container(
                              width: 28,
                              height: 65,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 10, 47, 39),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Dropoffdetails(
                                              customer: data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.amber,
                                        size: 15,
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomerDetails(customer: data[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
