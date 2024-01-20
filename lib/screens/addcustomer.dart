// import 'dart:ffi';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:snapdrive/components/custom_text_field.dart';
import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/addcar.dart';
import 'package:snapdrive/screens/rentOutcarlist.dart';

class AddCustomer extends StatefulWidget {
  final CarModel? selectedCar;
  const AddCustomer({super.key, this.selectedCar});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

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

class _AddCustomerState extends State<AddCustomer> {
  @override
  void initState() {
    super.initState();
    if (widget.selectedCar != null) {
      // Populate text fields with data from the selected CarModel
      carnameController.text = widget.selectedCar!.vehiclename;
      carRegController.text = widget.selectedCar!.vehicleReg;
      selectedImage = widget.selectedCar!.selectedImage;
      // imagepath = widget.selectedCar!.selectedImage as File;
      // Add similar lines for other fields if needed
    }
  }

  Widget _buildSelectedImage() {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: selectedImage != null && selectedImage!.isNotEmpty
                ? Image.file(
                    File(selectedImage!),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Handle edit image action
              },
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.selectedCar!.selectedImage);
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
          "ADD CUSTOMER",
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
                _buildSelectedImage(),
                const Gap(15),
                CustomTextField(
                  labelText: 'Car Name',
                  hintText: 'Car Name',
                  controller: carnameController,
                  keyboardType: TextInputType.text,
                ),
                const Gap(15),
                CustomTextField(
                    labelText: 'Car reg Number',
                    hintText: 'Car Reg Number',
                    keyboardType: TextInputType.text,
                    controller: carRegController),
                const Gap(15),
                CustomTextField(
                  labelText: 'customer Name',
                  hintText: 'customer Name',
                  controller: customerNameController,
                  keyboardType: TextInputType.text,
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Mobile Number',
                  hintText: 'Mobile Number',
                  controller: mobileNumberController,
                  keyboardType: TextInputType.number,
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'License Number',
                  hintText: 'License Number',
                  controller: licenseNumberController,
                  keyboardType: TextInputType.number,
                ),
                const Gap(15),
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Pickup Date',
                    hintText: 'Pickup Date',
                  ),
                  controller: pickupdate,
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100));
                    if (pickeddate != null) {
                      setState(() {
                        pickupdate.text =
                            DateFormat('dd-MM-yyyy').format(pickeddate);
                      });
                    }
                  },
                ),
                const Gap(15),
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Pickup Time',
                    hintText: 'Pickup Time',
                  ),
                  controller: pickupTime,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: timeOfDay,
                    );
                    if (pickedTime != null) {
                      setState(() {
                        timeOfDay = pickedTime;
                        pickupTime.text = pickedTime.format(context);
                      });
                    }
                  },
                ),
                const Gap(15),
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Drop Off Date',
                    hintText: 'Drop Off Date',
                  ),
                  controller: dropOffDate,
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100));
                    if (pickeddate != null) {
                      setState(() {
                        dropOffDate.text =
                            DateFormat('dd-MM-yyyy').format(pickeddate);
                      });
                    }
                  },
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Security Deposit',
                  hintText: 'Security Deposit',
                  controller: securityDepositController,
                  keyboardType: TextInputType.number,
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
                            saveCus();
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

  Future<void> saveCus() async {
    final carname = carnameController.text.trim();
    final carReg = carRegController.text.trim();
    final customerName = customerNameController.text.trim();
    final mobileNumber = mobileNumberController.text.trim();
    final licenseNumber = licenseNumberController.text.trim();
    final securityDeposit = securityDepositController.text.trim();
    final pickupdaten = pickupdate.text.trim();
    final pickupTimen = pickupTime.text.trim();
    final dropOffDaten = dropOffDate.text.trim();
    final imagepath = widget.selectedCar!.selectedImage;

    if (carname.isEmpty ||
        carReg.isEmpty ||
        customerName.isEmpty ||
        mobileNumber.isEmpty ||
        licenseNumber.isEmpty ||
        securityDeposit.isEmpty ||
        pickupdaten.isEmpty ||
        pickupTimen.isEmpty ||
        dropOffDaten.isEmpty) {
      return;
    }
    final customerA = CustomerModel(
      carname: carname,
      carReg: carReg,
      customerName: customerName,
      mobileNumber: mobileNumber,
      licenseNumber: licenseNumber,
      pickupdate: pickupdaten,
      pickupTime: pickupTimen,
      dropOffDate: dropOffDaten,
      securityDeposit: securityDeposit,
      selectedImage: imagepath,
    );

    await addCustomer(customerA);

    Navigator.pop(context);

    customerNameController.clear();
    carRegController.clear();
    carnameController.clear();
    mobileNumberController.clear();
    licenseNumberController.clear();
    pickupdate.clear();
    pickupTime.clear();
    dropOffDate.clear();
    securityDepositController.clear();
  }
}
