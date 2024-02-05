import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/home.dart';
import 'package:snapdrive/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final usernameController = TextEditingController();
final passwordController = TextEditingController();
final formKey = GlobalKey<FormState>();
bool isVisible = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 248, 254),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                  image: AssetImage('images/Screenshot 2024-01-05 152006.png')),
              const SizedBox(height: 10),
              const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'With username and password',
                style: TextStyle(color: Colors.amber),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Username',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                        obscureText: !isVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 10, 47, 39),
                  fixedSize: const Size(270, 50),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    checkLogin(context);
                  } else {
                    // print('Data empty');
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 10, 47, 39),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final username = usernameController.text;
    final password = passwordController.text;
    if (username == password) {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setBool(saveKey, true);

      Navigator.of(ctx).pushReplacement(MaterialPageRoute(
          builder: (ctx) => MyHomePage(
                title: 'home',
              )));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text('Username or password incorrect'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
