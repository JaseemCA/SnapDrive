import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:snapdrive/components/custom_text_field.dart';
import 'package:snapdrive/db/datamodel.dart';

class Updatecustomer extends StatefulWidget {
  final CustomerModel customer;
  const Updatecustomer({super.key, required this.customer});

  @override
  State<Updatecustomer> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Updatecustomer> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var carnameController = TextEditingController();
  var carRegController = TextEditingController();
  var carrentcontroller = TextEditingController();
  var customerNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var licenseNumberController = TextEditingController();
  var pickupdate = TextEditingController();
  var pickupTime = TextEditingController();
  var dropOffDate = TextEditingController();
  var securityDepositController = TextEditingController();
  String? selectedImage;
  File? imagepath;
  @override
  void initState() {
    carrentcontroller = TextEditingController();
    carnameController = TextEditingController();
    carRegController = TextEditingController();
    customerNameController = TextEditingController();
    mobileNumberController = TextEditingController();
    licenseNumberController = TextEditingController();
    pickupdate = TextEditingController();
    pickupTime = TextEditingController();
    dropOffDate = TextEditingController();
    securityDepositController = TextEditingController();
    selectedImage = selectedImage;

    carrentcontroller.text = widget.customer.carDailyRent;
    carnameController.text = widget.customer.carname;
    carRegController.text = widget.customer.carReg;
    customerNameController.text = widget.customer.customerName;
    mobileNumberController.text = widget.customer.mobileNumber;
    licenseNumberController.text = widget.customer.licenseNumber;
    selectedImage = widget.customer.selectedImage;
    pickupdate.text = widget.customer.pickupdate;
    pickupTime.text = widget.customer.pickupTime;
    dropOffDate.text = widget.customer.dropOffDate;
    securityDepositController.text = widget.customer.securityDeposit;
    super.initState();
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
        ],
      ),
    );
  }

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
          "UPDATE CUSTOMER DETAILS",
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
                _buildSelectedImage(),
                const Gap(15),
                CustomTextField(
                  enabled: false,
                  labelText: 'Car Name',
                  hintText: 'Car Name',
                  controller: carnameController,
                  keyboardType: TextInputType.text,
                ),
                const Gap(15),
                CustomTextField(
                  enabled: false,
                  labelText: 'Car reg Number',
                  hintText: 'Car Reg Number',
                  keyboardType: TextInputType.text,
                  controller: carRegController,
                ),
                const Gap(15),
                CustomTextField(
                    enabled: false,
                    labelText: 'Daily Rent',
                    hintText: 'Daily Rent',
                    controller: carrentcontroller),
                const Gap(15),
                CustomTextField(
                  labelText: 'Customer Name',
                  hintText: 'Customer Name',
                  controller: customerNameController,
                  keyboardType: TextInputType.text,
                ),
                const Gap(15),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Mobile Number',
                  ),
                  controller: mobileNumberController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a mobile number';
                    }
                    if (value.length != 10) {
                      return 'Mobile number must be 10 digits';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'License Number',
                    hintText: 'License Number',
                  ),
                  controller: licenseNumberController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a license number';
                    }
                    if (!RegExp(r'^[A-Z]{2}\d{2}\d{4}\d{7}$').hasMatch(value)) {
                      return 'Invalid license number';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Pickup Date',
                    hintText: 'Pickup Date',
                  ),
                  controller: pickupdate,
                  onTap: () async {
                    DateTime currentDate = DateTime.now();
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      pickupdate.text =
                          DateFormat('dd-MM-yyyy').format(pickedDate);

                      formKey.currentState?.validate();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please pick a date';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.access_time),
                    labelText: 'Pickup Time',
                    hintText: 'Pickup Time',
                  ),
                  controller: pickupTime,
                  onTap: () async {
                    TimeOfDay currentTime = TimeOfDay.now();
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: currentTime,
                    );

                    if (pickedTime != null) {
                      pickupTime.text = pickedTime.format(context);

                      formKey.currentState?.validate();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please pick a time';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Drop Off Date',
                    hintText: 'Drop Off Date',
                  ),
                  controller: dropOffDate,
                  onTap: () async {
                    DateTime currentDate = DateTime.now();
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      dropOffDate.text =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      formKey.currentState?.validate();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please pick a drop-off date';
                    }
                    return null;
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
                        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
                        fixedSize: const Size(300, 30),
                      ),
                      onPressed: () async {
                        widget.customer.carname = carnameController.text;
                        widget.customer.carReg = carRegController.text;
                        widget.customer.customerName =
                            customerNameController.text;
                        widget.customer.mobileNumber =
                            mobileNumberController.text;
                        widget.customer.licenseNumber =
                            licenseNumberController.text;
                        widget.customer.pickupdate = pickupdate.text;
                        widget.customer.pickupTime = pickupTime.text;
                        widget.customer.dropOffDate = dropOffDate.text;
                        widget.customer.securityDeposit =
                            securityDepositController.text;
                        widget.customer.selectedImage = selectedImage!;
                        await widget.customer.save();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'UPDATE DETAILS',
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
}
