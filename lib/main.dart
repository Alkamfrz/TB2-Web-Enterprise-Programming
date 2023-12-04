import 'package:flutter/material.dart';
import 'package:tb2/views/login_page.dart';
import 'package:tb2/views/register_page.dart';
import 'package:tb2/views/student_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginPage(
          onLogin: () {
            Navigator.pushNamed(context, '/student');
          },
          onRegister: () {
            Navigator.pushNamed(context, '/register');
          },
        ),
        '/register': (context) => RegisterPage(
          onLogin: () {
            Navigator.pushNamed(context, '/login');
          },
          onRegister: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
        '/student': (context) => StudentPage(
          students: [
            Student(id: '1', name: 'John Doe', age: '20', grade: 'A'),
            Student(id: '2', name: 'Jane Smith', age: '19', grade: 'B'),
            Student(id: '3', name: 'Bob Williams', age: '21', grade: 'C'),
            Student(id: '4', name: 'Mike Johnson', age: '22', grade: 'D'),
            Student(id: '5', name: 'Mary Davis', age: '20', grade: 'E'),
          ],
        ),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
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