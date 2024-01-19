import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapdrive/components/custom_text_field.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/controller/db_functions.dart';

class AddCAr extends StatefulWidget {
  const AddCAr({super.key});

  @override
  State<AddCAr> createState() => _AddCArState();
}

final vehiclenameController = TextEditingController();
final vehicleRegController = TextEditingController();
final dailyrentController = TextEditingController();
final monthlyrentController = TextEditingController();
File? imagepath;
String? selectedImage;
String? selectedFuel;
String? selectedSeat;
final formKey = GlobalKey<FormState>();

class _AddCArState extends State<AddCAr> {
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
          "ADD NEW CAR",
          style: TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                    labelText: 'Car Name',
                    hintText: 'Car Name',
                    keyboardType: TextInputType.text,
                    controller: vehiclenameController),
                const Gap(15),
                CustomTextField(
                    labelText: 'Registration Number',
                    hintText: 'Registration Number',
                    keyboardType: TextInputType.text,
                    controller: vehicleRegController),
                const Gap(15),
                DropdownButtonFormField<String>(
                  value: selectedFuel,
                  items: ['Petrol', 'Diesel', 'EV'].map((String fuelType) {
                    return DropdownMenuItem<String>(
                      value: fuelType,
                      child: Text(fuelType),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Fuel',
                    labelText: 'Fuel',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const Gap(15),
                DropdownButtonFormField<String>(
                  value: selectedSeat,
                  items: ['2', '4', '5', '7', '8']
                      .map((String seater) => DropdownMenuItem<String>(
                            value: seater,
                            child: Text(seater),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSeat = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Seater',
                    labelText: 'Seater',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Daily Rent',
                  hintText: 'Daily Rent',
                  controller: dailyrentController,
                  keyboardType: TextInputType.number,
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Monthly Rent',
                  hintText: 'Monthly Rent',
                  controller: monthlyrentController,
                  keyboardType: TextInputType.number,
                ),
                const Gap(15),
                if (imagepath != null)
                  SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            imagepath!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: pickImageFromGallery,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.amber,
                    fixedSize: const Size(200, 5),
                  ),
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  child: const Text(
                    'ADD IMAGE',
                    style: TextStyle(
                      color: Color.fromARGB(255, 10, 47, 39),
                    ),
                  ),
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 10, 47, 39),
                          fixedSize: const Size(300, 30),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            saveDetails();
                          } else {
                            // print('Data empty');
                          }
                        },
                        child: const Text(
                          'SAVE DETAILS',
                          style: TextStyle(color: Colors.amber),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        imagepath = File(returnedImage.path);
        selectedImage = returnedImage.path;
      });
    }
  }

  Future<void> saveDetails() async {
    final vehiclename = vehiclenameController.text.trim();
    final vehicleReg = vehicleRegController.text.trim();
    final dailyrent = dailyrentController.text.trim();
    final monthlyrent = monthlyrentController.text.trim();
    if (imagepath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (vehiclename.isEmpty ||
        vehicleReg.isEmpty ||
        selectedFuel == null ||
        selectedSeat == null ||
        dailyrent.isEmpty ||
        monthlyrent.isEmpty) {
      return;
    }
    final carsA = CarModel(
      vehiclename: vehiclename,
      vehicleReg: vehicleReg,
      fuel: selectedFuel!,
      seater: selectedSeat!,
      dailyrent: dailyrent,
      monthlyrent: monthlyrent,
      selectedImage: imagepath?.path ?? "",
    );

    addCar(carsA);
    Navigator.pop(context);

    monthlyrentController.clear();
    vehiclenameController.clear();
    vehicleRegController.clear();
    // seaterController.clear();
    dailyrentController.clear();
    setState(() {
      imagepath = null;
      selectedFuel = null;
      selectedSeat = null;
    });
  }
}
