import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapdrive/controller/db_functions.dart';
import 'package:snapdrive/screens/addcar.dart';
import 'package:snapdrive/screens/availablecarslist.dart';
import 'package:snapdrive/screens/login.dart';
import 'package:snapdrive/screens/notification_screen.dart';
import 'package:snapdrive/screens/rent_outcarlist.dart';
import 'package:snapdrive/screens/search_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexNum = 0;

  @override
  Widget build(BuildContext context) {
    getAllCars();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 251, 252),
        appBar: AppBar(
          bottom: const TabBar(
              tabs: [
                Tab(
                    child: Text(
                  "Available cars",
                  style: TextStyle(fontSize: 18),
                )),
                Tab(
                  child: Text(
                    "Rent out cars",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
              labelColor: Color.fromARGB(255, 250, 249, 249),
              indicatorColor: Colors.amber,
              unselectedLabelColor: Color.fromARGB(107, 253, 253, 252)),
          backgroundColor: const Color.fromARGB(255, 10, 47, 39),
          leading: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(const Duration(seconds: 5), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                        content:
                            const Text('Are you sure you want to SIGN OUT'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                signout(context);
                              },
                              child: const Text(
                                'SIGN OUT',
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('CANCEL'))
                        ]);
                  });
            },
            icon: const Icon(
              Icons.person_2_outlined,
              color: Colors.amber,
              size: 40,
            ),
          ),
        ),
        body: const TabBarView(
          children: [Availablecars(), Rentoutcars()],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const AddCAr()));
          },
          backgroundColor: const Color.fromARGB(255, 10, 47, 39),
          label: const Text(
            'ADD CAR',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
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
            setState(() {
              indexNum = index;
              if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              } else if (index == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              }
            });
          },
          // onTap: (index) {
          //   setState(
          //     () {
          //       indexNum = index;
          //       if (index == 1) {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => SearchScreen()));
          //       }
          //     },
          //   );
          // },
        ),
      ),
    );
  }

  signout(BuildContext ctx) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    passwordController.clear();
    usernameController.clear();

    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => LoginPage(),
      ),
      (route) => false,
    );
  }
}
