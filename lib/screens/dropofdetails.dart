import 'dart:io';
// import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snapdrive/components/custom_text_field.dart';
import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/db/box.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/addcar.dart';

class Dropoffdetails extends StatefulWidget {
  final CustomerModel customer;
  final CarModel? carModel;
  const Dropoffdetails({
    super.key,
    required this.customer,
    this.carModel,
  });

  @override
  State<Dropoffdetails> createState() => _DropfofdetailsState();
}

class _DropfofdetailsState extends State<Dropoffdetails> {
  var carnameController = TextEditingController();
  var carRegController = TextEditingController();
  var carRentController = TextEditingController();
  var customerNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var licenseNumberController = TextEditingController();
  var pickupdate = TextEditingController();
  var pickupTime = TextEditingController();
  var dropOffDate = TextEditingController();
  var droppOfftime = TextEditingController();
  var monthlyrentController = TextEditingController();
  var carseater = TextEditingController();
  var carfuel = TextEditingController();
  double totalRent = 0.0;
  var securityDepositController = TextEditingController();
  String? selectedImage;
  File? imagepath;

  @override
  void initState() {
    carnameController = TextEditingController();
    carRegController = TextEditingController();
    carRentController = TextEditingController();
    customerNameController = TextEditingController();
    mobileNumberController = TextEditingController();
    licenseNumberController = TextEditingController();
    pickupdate = TextEditingController();
    pickupTime = TextEditingController();
    dropOffDate = TextEditingController();
    securityDepositController = TextEditingController();
    monthlyrentController = TextEditingController();
    carseater = TextEditingController();
    carfuel = TextEditingController();
    selectedImage = selectedImage;
    carnameController.text = widget.customer.carname;
    carRegController.text = widget.customer.carReg;
    carRentController.text = widget.customer.carDailyRent;
    customerNameController.text = widget.customer.customerName;
    mobileNumberController.text = widget.customer.mobileNumber;
    licenseNumberController.text = widget.customer.licenseNumber;
    selectedImage = widget.customer.selectedImage;
    dropOffDate.text = widget.customer.dropOffDate;
    pickupdate.text = widget.customer.pickupdate;
    pickupTime.text = widget.customer.pickupTime;
    securityDepositController.text = widget.customer.securityDeposit;
    monthlyrentController.text = widget.customer.carMonthlyRent!;
    carfuel.text = widget.customer.carfuel!;
    carseater.text = widget.customer.carseater!;
    updateTotalRent();
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

  void updateTotalRent() {
    if (dropOffDate.text.isNotEmpty && droppOfftime.text.isNotEmpty) {
      DateTime pickupDateTime = DateFormat('yyyy-MM-dd HH:mm')
          .parse('${widget.customer.pickupdate} ${widget.customer.pickupTime}');

      String combinedDateTimeString =
          '${dropOffDate.text} ${droppOfftime.text}';

      DateTime dropOffDateTime =
          DateFormat('yyyy-MM-dd HH:mm').parse(combinedDateTimeString);

      totalRent = calculateTotalRent(
        pickupDateTime,
        dropOffDateTime,
        double.parse(carRentController.text),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getCustomerData().listenable(),
        builder: (context, box, _) {
          return ValueListenableBuilder<Box<CarModel>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, carBox, _) {
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
                      "DROP OF DETAILS",
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
                        child: Column(
                          children: [
                            _buildSelectedImage(),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'car name',
                              hintText: 'carname',
                              controller: carnameController,
                              enabled: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Daily Rent',
                              hintText: 'Daily Rent',
                              controller: carRentController,
                              enabled: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Car reg number',
                              hintText: 'Car reg number',
                              controller: carRegController,
                              enabled: false,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Customer Name',
                              hintText: 'Customer Name',
                              controller: customerNameController,
                              enabled: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Mobile Number',
                              hintText: 'Mobile Number',
                              controller: mobileNumberController,
                              enabled: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'License Number',
                              hintText: 'License Number',
                              controller: licenseNumberController,
                              enabled: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Pickup Date',
                              hintText: 'Pickup Date',
                              controller: pickupdate,
                              enabled: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Pickup Time',
                              hintText: 'Pickup Time',
                              controller: pickupTime,
                              enabled: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Drop Off Date',
                              hintText: 'Drop Off Date',
                              controller: dropOffDate,
                              enabled: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Security Deposit',
                              hintText: 'Security Deposit',
                              controller: securityDepositController,
                              enabled: false,
                            ),
                            const Gap(15),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.access_time),
                                labelText: 'DropOff Time',
                                hintText: 'DropOff Time',
                              ),
                              controller: droppOfftime,
                              onTap: () async {
                                TimeOfDay currentTime = TimeOfDay.now();
                                TimeOfDay? selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: currentTime,
                                );

                                if (selectedTime != null) {
                                  droppOfftime.text =
                                      selectedTime.format(context);
                                  formKey.currentState?.validate();
                                  updateTotalRent();
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
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              color: Colors.grey[200],
                              child: Text(
                                'Total Rent: $totalRent',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 10, 47, 39),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 52,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (droppOfftime.text.isEmpty) {
                                      // Show a dialog or a snackbar to inform the user to pick a drop-off time
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Value is empty'),
                                            content: const Text(
                                                'Please pick a drop-off time.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      // Proceed with dropping off the details
                                      Navigator.pop(context);
                                      removeCustomerFromScreen(widget.customer);
                                      saveDetails();
                                    }
                                  },
                                  child: const Text(
                                    'DROP OFF',
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                ),

                                // ElevatedButton(
                                //   style: ElevatedButton.styleFrom(
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(15),
                                //     ),
                                //     backgroundColor:
                                //         const Color.fromARGB(255, 10, 47, 39),
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 16, horizontal: 52),
                                //   ),
                                //   onPressed: () {
                                //     // getRemovedCars();
                                //     Navigator.pop(context);
                                //     removeCustomerFromScreen(widget.customer);
                                //     saveDetails();
                                //   },
                                //   child: const Text(
                                //     'DROP OFF',
                                //     style: TextStyle(color: Colors.amber),
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  double calculateTotalRent(
    DateTime pickupDateTime,
    DateTime dropOffDateTime,
    double dailyRent,
  ) {
    Duration timeDifference = dropOffDateTime.difference(pickupDateTime);

    double totalDays = timeDifference.inDays.toDouble();
    double totalHours = timeDifference.inHours.toDouble() % 24;

    double totalRent =
        (totalDays * dailyRent) + ((totalHours / 24) * dailyRent);

    totalRent = double.parse(totalRent.toStringAsFixed(2));

    return totalRent;
  }

  Future<void> saveDetails() async {
    final vehiclename = widget.customer.carname;
    final vehicleReg = widget.customer.carReg;
    final dailyrent = widget.customer.carDailyRent;
    final monthlyrent = widget.customer.carMonthlyRent;
    final carfuel = widget.customer.carfuel;
    final carseater = widget.customer.carseater;
    final imagepath = widget.customer.selectedImage;

    final carsA = CarModel(
        vehiclename: vehiclename,
        vehicleReg: vehicleReg,
        fuel: carfuel!,
        seater: carseater!,
        dailyrent: dailyrent,
        monthlyrent: monthlyrent!,
        selectedImage: imagepath);

    addCar(carsA);
  }
}
