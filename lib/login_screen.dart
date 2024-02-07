import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_assessment/register_screen.dart';
import 'package:flutter_database_assessment/user_details_list_screen.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formField = GlobalKey<FormState>();
  var _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _dobController = TextEditingController();
  DateTime? _selectedDate;
  bool passwordToggle = true;

  late DatabaseHelper _databaseHelper;

  Future<void> _initializeDatabase() async {
    _databaseHelper = DatabaseHelper();
    await _databaseHelper.initialization();
  }

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

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

  Future<void> _loginUser() async {
    if (_formField.currentState!.validate()) {
      if (_databaseHelper == null) {
        return;
      }

      bool loginSuccessful = await _databaseHelper.checkLoginCredentials(
        _usernameController.text,
        _passwordController.text,
        _dobController.text,
      );


      if (loginSuccessful) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserDetailsListScreen(
            userName: _usernameController.text,
          ),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.account_circle),
                        labelText: 'Enter User Name',
                        hintText: 'Enter Your User Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter User Name';
                        }
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: 'Enter Date of Birth',
                          hintText: 'Enter Your DOB',
                        ),
                        onTap: () => _selectDate(context),
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Date of Birth';
                          }
                          ;
                        })),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    obscureText: passwordToggle,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            passwordToggle = !passwordToggle;
                          });
                        },
                        child: Icon(passwordToggle
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      } else if (_passwordController.text.length < 6) {
                        return 'Password should be min 6 characters';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _loginUser();
                  },
                  child: Text('Login'),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ));
                  },
                  child: Text('Register'),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
