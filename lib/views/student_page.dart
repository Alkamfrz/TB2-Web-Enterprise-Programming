import 'package:flutter/material.dart';
import 'package:tb2/widgets/nav_bar.dart';

class Student {
  final String id;
  final String name;
  final String age;
  final String grade;

  Student({required this.id, required this.name, required this.age, required this.grade});
}

class StudentPage extends StatelessWidget {
  final List<Student> students;

  const StudentPage({super.key, required this.students});

  DataRow getRow(Student student) {
    return DataRow(cells: [
      DataCell(Text(student.id)),
      DataCell(Text(student.name)),
      DataCell(Text(student.age)),
      DataCell(Text(student.grade)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: NavBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.blue[100]),
          columnSpacing: 32,
          columns: const [
            DataColumn(label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
            DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
            DataColumn(label: Text('Age', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
            DataColumn(label: Text('Grade', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
          ],
          rows: students.map((student) => getRow(student)).toList(),
        ),
      ),
    );
  }
}