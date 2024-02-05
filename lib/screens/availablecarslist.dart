import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/db/box.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/addcustomer.dart';
import 'package:snapdrive/screens/car_details.dart';

class Availablecars extends StatefulWidget {
  const Availablecars({
    super.key,
  });

  @override
  State<Availablecars> createState() => _AvailablecarsState();
}

class _AvailablecarsState extends State<Availablecars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 251, 252),
      body: ValueListenableBuilder<Box<CarModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<CarModel>();
          // data.addAll(getRemovedCars());
          if (data.isEmpty) {
            return const Center(
              child: Text(
                'NO AVAILABLE CARS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, int index) {
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
                          backgroundImage:
                              FileImage(File(data[index].selectedImage)),
                          radius: 30,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            data[index].vehiclename,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            ' ₹ ${data[index].dailyrent}/DAY ',
                            style: const TextStyle(fontWeight: FontWeight.w500),
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          AddCustomer(selectedCar: data[index]),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  cardetails(cars: data[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
