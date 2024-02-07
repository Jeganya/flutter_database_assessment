import 'package:flutter/material.dart';
import 'package:flutter_database_assessment/user_model.dart';

class UserDetailsFormScreen extends StatelessWidget {
  final UserModel userDetails;

  UserDetailsFormScreen(this.userDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${userDetails.id}'),
          Text('Username: ${userDetails.userName}'),
          Text('Password: ${userDetails.password}'),
          Text('Email: ${userDetails.emailId}'),
          Text('Mobile No: ${userDetails.mobileNo}'),
          Text('DOB: ${userDetails.dob}'),
        ],
      ),
    );
  }
}
