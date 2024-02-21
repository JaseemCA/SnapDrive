import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapdrive/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapdrive/screens/home.dart';
import 'package:snapdrive/screens/login.dart';
// import 'package:snapdrive/screens/login.dart';
// import 'package:snapdrive/main.dart';

class Splash extends StatefulWidget {
  const Splash({
    super.key,
  });

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // _navigatetologin();
    checkUserLoggedIn();
  }

  _navigatetologin() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/logo.png'),
        ),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPrefs.getBool(saveKey);
    if (userLoggedIn == null || userLoggedIn == false) {
      _navigatetologin();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx1) => MyHomePage(
            title: 'home',
          ),
        ),
      );
    }
  }
}
