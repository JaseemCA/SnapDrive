import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:snapdrive/components/custom_text_field.dart';
import 'package:snapdrive/screens/addcar.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

final carnameController = TextEditingController();
final carRegController = TextEditingController();
final customerNameController = TextEditingController();
final mobileNumberController = TextEditingController();
final licenseNumberController = TextEditingController();
TextEditingController pickupdate = TextEditingController();
TextEditingController pickupTime = TextEditingController();
TextEditingController dropOffDate = TextEditingController();
final securityDepositController = TextEditingController();

TimeOfDay timeOfDay = TimeOfDay.now();

class _AddCustomerState extends State<AddCustomer> {
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
}
