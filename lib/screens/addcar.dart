import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapdrive/components/custom_dropdown.dart';
import 'package:snapdrive/components/custom_elevated.dart';
import 'package:snapdrive/components/custom_text_field.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/controller/db_functions.dart';

class AddCAr extends StatefulWidget {
  const AddCAr({Key? key}) : super(key: key);

  @override
  State<AddCAr> createState() => _AddCArState();
}

final vehiclenameController = TextEditingController();
final vehicleRegController = TextEditingController();
final carrentcontroller = TextEditingController();
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
      backgroundColor: const Color.fromARGB(255, 240, 251, 252),
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
          ),
        ),
        centerTitle: true,
        title: const Text(
          "ADD NEW CAR",
          style: TextStyle(
            color: Colors.amber,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
                  controller: vehiclenameController,
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Registration Number',
                  hintText: 'Registration Number',
                  keyboardType: TextInputType.text,
                  controller: vehicleRegController,
                ),
                const Gap(15),
                customDropdownField(
                  labelText: 'Fuel',
                  hintText: 'Fuel',
                  value: selectedFuel,
                  items: ['Petrol', 'Diesel', 'EV'],
                  onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  },
                ),
                const Gap(15),
                customDropdownField(
                  labelText: 'Seater',
                  hintText: 'Seater',
                  value: selectedSeat,
                  items: ['2', '4', '5', '7', '8'],
                  onChanged: (String? value) {
                    setState(() {
                      selectedSeat = value;
                    });
                  },
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Daily Rent',
                  hintText: 'Daily Rent',
                  controller: carrentcontroller,
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
                if (imagepath != null) buildSelectedImage(),
                const Gap(15),
                customElevatedButton(
                  onPressed: pickImageFromGallery,
                  label: 'ADD IMAGE',
                ),
                const Gap(15),
                customElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      saveDetails();
                    } else {
                      // print('Data empty');
                    }
                  },
                  label: 'SAVE DETAILS',
                  backgroundColor: const Color.fromARGB(255, 10, 47, 39),
                  labelColor: Colors.amber,
                  width: 300,
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectedImage() {
    return SizedBox(
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
    final dailyrent = carrentcontroller.text.trim();
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
    carrentcontroller.clear();
    setState(() {
      imagepath = null;
      selectedFuel = null;
      selectedSeat = null;
    });
  }
}
