import 'package:flutter/material.dart';
import 'package:tb2/views/login_page.dart';
import 'package:tb2/views/register_page.dart';
import 'package:tb2/views/my_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Open Sans',
        ),
      ),
      home: const SplashScreen(),
    );
  }


}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(
          onLogin: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyProfile()),
            );
          },
          onRegister: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage(
                onLogin: () {
                  Navigator.pop(context);
                },
                onRegister: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(
                      onLogin: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyProfile()),
                        );
                      },
                      onRegister: () {},
                    )),
                  );
                },
              )),
            );
          },
        )),
      );
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'images/logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}