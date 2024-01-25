import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/addcar.dart';
import 'package:snapdrive/screens/home.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  int indexNum = 0;
  List<CarModel> searchCarResults = [];
  List<CustomerModel> searchCustomerResults = [];
  @override
  void initState() {
    super.initState();
    performSearch('');
  }

  void performSearch(String query) {
    setState(() {
      searchCarResults = searchCars(query);
      searchCustomerResults = searchCustomers(query);
    });
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
            )),
        centerTitle: true,
        title: const Text(
          "SEARCH",
          style: TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
      ),
      body: Column(
        children: [
          const Gap(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) => performSearch(query),
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 240, 251, 252),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (var car in searchCarResults)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(car.selectedImage)),
                      radius: 30,
                    ),
                    title: Text(car.vehiclename),
                    subtitle: Text(
                      ' ₹ ${car.dailyrent}/DAY -AVAILABLE FOR RENT-',
                    ),
                  ),
                const Gap(10),
                for (var customer in searchCustomerResults)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(customer.selectedImage!)),
                      radius: 30,
                    ),
                    title: Text(customer.customerName),
                    subtitle: Text(customer.carname),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.amber,
              ),
              label: "Home"),
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
        currentIndex: indexNum,
        onTap: (index) {
          setState(
            () {
              indexNum = index;
              if (index == 0) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const MyHomePage(title: 'home')));
              }
            },
          );
        },
      ),
    );
  }
}
