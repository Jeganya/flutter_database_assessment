import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'login_screen.dart';
import 'main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();

  var _emailIdController = TextEditingController();
  var _mobileNocontroller = TextEditingController();

  var _dobController = TextEditingController();
  DateTime? _selectedDate;
  bool passwordToggle = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Register Form',
        style: TextStyle(fontSize: 20,
        fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter UserName',
                    hintText: 'Enter Your UserName'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  labelText: 'Enter Date of Birth',
                  hintText: 'Enter Your DOB',
                ),
                onTap: () => _selectDate(context),
                readOnly: true,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter Password',
                    hintText: 'Enter Your Password'),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailIdController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter Email ID',
                    hintText: 'Enter Your Email ID'),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _mobileNocontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter Mobile No',
                    hintText: 'Enter Your Mobile No'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: Text('Register')),
          ],
        ),
      ),
    );
  }

  void _register() async {
    print('--------------> _register');
    print('--------------> user Name: ${_userNameController.text}');
    print('--------------> Password: ${_passwordController.text}');
    print('--------------> email: ${_emailIdController.text}');
    print('--------------> Mobile no: ${_mobileNocontroller.text}');
    print('--------------> Dob: ${_dobController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.colUserName: _userNameController.text,
      DatabaseHelper.colPassword: _passwordController.text,
      DatabaseHelper.colEmailId: _emailIdController.text,
      DatabaseHelper.colMobileNo: _mobileNocontroller.text,
      DatabaseHelper.colDob: _dobController.text,
    };

    final result = await dbHelper.insertDirectorDetails(
        row, DatabaseHelper.registerTable);
    debugPrint('--------> Inserted Row Id: $result');

    if (result > 0) {
      _showSuccessSnackBar(context, 'Saved');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

}
