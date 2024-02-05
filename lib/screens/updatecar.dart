import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapdrive/components/custom_text_field.dart';
import 'package:snapdrive/components/custom_dropdown.dart';
import 'package:snapdrive/components/custom_elevated.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/addcar.dart';

class Updatecar extends StatefulWidget {
  final CarModel modelcar;

  const Updatecar({super.key, required this.modelcar});
  @override
  State<Updatecar> createState() => UpdatecarState();
}

class UpdatecarState extends State<Updatecar> {
  var vehiclenameController = TextEditingController();
  var vehicleRegController = TextEditingController();
  var dailyrentController = TextEditingController();
  var monthlyrentController = TextEditingController();
  File? imagepath;
  String? selectedImage;
  String? selectedFuel;
  String? selectedSeat;
  @override
  void initState() {
    vehiclenameController = TextEditingController();
    vehicleRegController = TextEditingController();
    dailyrentController = TextEditingController();
    monthlyrentController = TextEditingController();
    imagepath = null;
    selectedImage = null;
    selectedFuel = null;
    selectedSeat = null;

    vehiclenameController.text = widget.modelcar.vehiclename;
    vehicleRegController.text = widget.modelcar.vehicleReg;
    dailyrentController.text = widget.modelcar.dailyrent;
    monthlyrentController.text = widget.modelcar.monthlyrent;
    selectedSeat = widget.modelcar.seater;
    selectedFuel = widget.modelcar.fuel;
    selectedImage = widget.modelcar.selectedImage;
    super.initState();
  }

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
          ),
        ),
        centerTitle: true,
        title: const Text(
          "UPDATE CAR",
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
                  labelText: 'Registration number',
                  hintText: 'registration number',
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
                if (selectedImage != null)
                  SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(selectedImage!),
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
                const Gap(15),
                customElevatedButton(
                  onPressed: pickImageFromGallery,
                  label: 'ADD IMAGE',
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
                        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
                        fixedSize: const Size(300, 30),
                      ),
                      onPressed: () async {
                        widget.modelcar.vehiclename =
                            vehiclenameController.text;
                        widget.modelcar.vehicleReg = vehicleRegController.text;
                        widget.modelcar.dailyrent = dailyrentController.text;
                        widget.modelcar.monthlyrent =
                            monthlyrentController.text;
                        widget.modelcar.seater = selectedSeat ?? "";
                        widget.modelcar.fuel = selectedFuel ?? "";
                        widget.modelcar.selectedImage = selectedImage ?? "";
                        await widget.modelcar.save();

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'UPDATE',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
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
        selectedImage = returnedImage.path;
      });
    }
  }
}
