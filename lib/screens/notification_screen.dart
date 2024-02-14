import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/db/box.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/customer_details.dart';
import 'package:snapdrive/screens/home.dart';
import 'package:snapdrive/screens/search_screen.dart';

class NotificationModel {
  final String customerName;
  final String carName;
  final int daysLate;
  final String selectedImage;
  final String mobileNumber;

  NotificationModel({
    required this.customerName,
    required this.carName,
    required this.daysLate,
    required this.selectedImage,
    required this.mobileNumber,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationsList = [];

  @override
  void initState() {
    super.initState();
    getAllCustomers();
    customerListNotifier.addListener(_onCustomerListChanged);
  }

  @override
  void dispose() {
    customerListNotifier.removeListener(_onCustomerListChanged);
    super.dispose();
  }

  void _onCustomerListChanged() {
    generateNotifications(customerListNotifier.value);
  }

  void generateNotifications(List<CustomerModel> customerList) {
    DateTime currentDate = DateTime.now();
    notificationsList.clear();

    for (var customer in customerList) {
      DateTime dropOffDate =
          DateFormat('dd-MM-yyyy').parse(customer.dropOffDate);

      if (dropOffDate.isBefore(currentDate)) {
        int daysLate = currentDate.difference(dropOffDate).inDays;

        if (daysLate > 0) {
          NotificationModel notification = NotificationModel(
              customerName: customer.customerName,
              carName: customer.carname,
              daysLate: daysLate,
              selectedImage: customer.selectedImage,
              mobileNumber: customer.mobileNumber);
          notificationsList.add(notification);
        }
      }
    }
    setState(() {});
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
          "NOTIFICATIONS",
          style: TextStyle(
            color: Colors.amber,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
      ),
      body: ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getCustomerData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<CustomerModel>();
          if (data.isEmpty) {
            return const Center(
              child: Text(
                'NO NOTIFICATIONS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: notificationsList.length,
              itemBuilder: (context, index) {
                NotificationModel notification = notificationsList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  CustomerDetails(customer: data[index])),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(
                                      File(notification.selectedImage)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${notification.customerName} is late for ${notification.daysLate} DAYS',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'CAR : ${notification.carName}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        const Gap(30),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'CALL NOW : ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: notification.mobileNumber,
                                                style: const TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 62, 133, 64),
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () async {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          notification.mobileNumber);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.amber,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.amber,
            ),
            label: "Search",
            backgroundColor: Color.fromARGB(255, 10, 47, 39),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.currency_rupee_sharp,
              color: Colors.amber,
            ),
            label: "Revenue",
            backgroundColor: Color.fromARGB(255, 10, 47, 39),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.amber,
            ),
            label: "Notification",
            backgroundColor: Color.fromARGB(255, 10, 47, 39),
          ),
        ],
        currentIndex: 3,
        onTap: (index) {
          setState(() {
            if (index == 0) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => const MyHomePage(title: 'home'),
              ));
            } else if (index == 1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const SearchScreen()),
              );
            } else if (index == 2) {}
          });
        },
      ),
    );
  }
}
