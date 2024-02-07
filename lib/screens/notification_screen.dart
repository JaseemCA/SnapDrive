// import 'package:flutter/material.dart';
// import 'package:snapdrive/screens/home.dart';
// import 'package:snapdrive/screens/search_screen.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationState();
// }

// class _NotificationState extends State<NotificationScreen> {
//   int indexNum = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 240, 251, 252),
//       appBar: AppBar(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//             )),
//         centerTitle: true,
//         title: const Text(
//           "NOTIFICATIONS",
//           style: TextStyle(
//               color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color.fromARGB(255, 10, 47, 39),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color.fromARGB(255, 10, 47, 39),
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.home,
//                 color: Colors.amber,
//               ),
//               label: "Home"),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.search,
//               color: Colors.amber,
//             ),
//             label: "Search",
//             backgroundColor: Color.fromARGB(255, 10, 47, 39),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.currency_rupee_sharp,
//               color: Colors.amber,
//             ),
//             label: "Revenue",
//             backgroundColor: Color.fromARGB(255, 10, 47, 39),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.notifications,
//               color: Colors.amber,
//             ),
//             label: "Notification",
//             backgroundColor: Color.fromARGB(255, 10, 47, 39),
//           ),
//         ],
//         currentIndex: indexNum,
//         onTap: (index) {
//           setState(
//             () {
//               indexNum = index;
//               if (index == 0) {
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (ctx) => const MyHomePage(
//                           title: 'home',
//                         )));
//               } else if (index == 1) {
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (ctx) => const SearchScreen()));
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/home.dart';
import 'package:snapdrive/screens/search_screen.dart';

class NotificationModel {
  final String customerName;
  final String carName;
  final int daysLate;
  final String selectedImage;

  NotificationModel({
    required this.customerName,
    required this.carName,
    required this.daysLate,
    required this.selectedImage,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationsList = [];
  void initState() {
    super.initState();
    getAllCustomers();
    customerListNotifier.addListener(() {
      generateNotifications(customerListNotifier.value);
    });
  }

  void generateNotifications(List<CustomerModel> customerList) {
    DateTime currentDate = DateTime.now();

    notificationsList.clear(); // Clear existing notifications

    for (var customer in customerList) {
      DateTime dropOffDate =
          DateFormat('yyyy-MM-dd').parse(customer.dropOffDate);
      int daysLate = dropOffDate.difference(currentDate).inDays;

      // Calculate the difference in days between drop-off date and current date
      // int daysLate = currentDate.difference(dropOffDate).inDays;

      // Only consider customers who are late (daysLate > 0)
      if (daysLate > 0) {
        NotificationModel notification = NotificationModel(
          customerName: customer.customerName,
          carName: customer.carname,
          daysLate: daysLate,
          selectedImage: customer.selectedImage,
        );

        notificationsList.add(notification);
      }
    }
  }

  // void generateNotifications(List<CustomerModel> customerList) {
  //   DateTime currentDate = DateTime.now();

  //   notificationsList.clear(); // Clear existing notifications

  //   for (var customer in customerList) {
  //     DateTime dropOffDate =
  //         DateFormat('yyyy-MM-dd').parse(customer.dropOffDate);

  //     if (dropOffDate.isBefore(currentDate)) {
  //       int daysLate = currentDate.difference(dropOffDate).inDays;

  //       NotificationModel notification = NotificationModel(
  //         customerName: customer.customerName,
  //         carName: customer.carname,
  //         daysLate: daysLate,
  //         selectedImage: customer.selectedImage,
  //       );

  //       notificationsList.add(notification);
  //     }
  //   }
  // }

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
      body: ListView.builder(
        itemCount: notificationsList.length,
        itemBuilder: (context, index) {
          NotificationModel notification = notificationsList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(notification.selectedImage)),
              radius: 30,
            ),
            title: Text(
              '${notification.customerName} is late for ${notification.daysLate}days',
              style: const TextStyle(fontSize: 16),
            ),
          );
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
                builder: (ctx) => MyHomePage(title: 'home'),
              ));
            } else if (index == 1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const SearchScreen()),
              );
            } else if (index == 2) {
              // Handle revenue tab
            }
          });
        },
      ),
    );
  }
}
