import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snapdrive/db/box.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/updatecustomer.dart';

class CustomerDetails extends StatefulWidget {
  final CustomerModel customer;

  const CustomerDetails({super.key, required this.customer});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
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

  Widget _buildSelectedImage() {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 520,
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
                  blurRadius: 30,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.customer.selectedImage.isNotEmpty
                ? Image.file(
                    File(widget.customer.selectedImage),
                    fit: BoxFit.cover,
                    width: 420,
                    height: 220,
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
          "CUSTOMER DETAILS",
          style: TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
      ),
      body: ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getCustomerData().listenable(),
        builder:
            (BuildContext context, Box<CustomerModel> value, Widget? child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildSelectedImage(),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 300,
                  height: 340,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Customer name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            widget.customer.customerName,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Rent out car",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            widget.customer.carname,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Mobile number",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            widget.customer.mobileNumber,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "License number",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            widget.customer.licenseNumber,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Pickup date",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            widget.customer.pickupdate,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Pickup time",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            widget.customer.pickupTime,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Drop off date",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            widget.customer.dropOffDate,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Security deposit received",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            widget.customer.securityDeposit,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
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
                        editCus(
                          widget.customer,
                          widget.customer.selectedImage.toString(),
                          widget.customer.carname.toString(),
                          widget.customer.carReg.toString(),
                          widget.customer.customerName.toString(),
                          widget.customer.mobileNumber.toString(),
                          widget.customer.licenseNumber.toString(),
                          widget.customer.pickupdate.toString(),
                          widget.customer.pickupTime.toString(),
                          widget.customer.dropOffDate.toString(),
                          widget.customer.securityDeposit.toString(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
                        foregroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: const Text('UPDATE'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> editCus(
    CustomerModel customer,
    String carname,
    String carReg,
    String customerName,
    String mobileNumber,
    String licenseNumber,
    String pickupdate,
    String pickupTime,
    String dropOffDate,
    String security,
    String cuscarImage,
  ) async {
    carnameController.text = carname;
    carRegController.text = carReg;
    customerNameController.text = customerName;
    mobileNumberController.text = mobileNumber;
    licenseNumberController.text = licenseNumber;
    pickupdate = pickupdate;
    pickupTime = pickupTime;
    dropOffDate = dropOffDate;
    securityDepositController.text = security;
    selectedImage = cuscarImage;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Updatecustomer(customer: customer),
    ));
  }
}
