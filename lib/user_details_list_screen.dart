import 'package:flutter/material.dart';
import 'package:flutter_database_assessment/register_screen.dart';
import 'package:flutter_database_assessment/user_model.dart';
import 'database_helper.dart';
import 'main.dart';

class UserDetailsListScreen extends StatefulWidget {
  final String userName;
  const UserDetailsListScreen({super.key, required this.userName});

  @override
  State<UserDetailsListScreen> createState() => _UserDetailsListScreenState();
}

class _UserDetailsListScreenState extends State<UserDetailsListScreen> {
  late List<UserModel> _userDetailsList;

  @override
  void initState() {
    super.initState();
    getAllUserDetails();
  }

  getAllUserDetails() async {
    _userDetailsList = <UserModel>[];
    var userDetailRecords =
        await dbHelper.queryAllRows(DatabaseHelper.registerTable);

    userDetailRecords.forEach((userDetail) {
      setState(() {
        print(userDetail['_id']);
        print(userDetail['_username']);
        print(userDetail['_dob']);
        print(userDetail['_password']);
        print(userDetail['_emailid']);
        print(userDetail['_mobileno']);


        var userDetailsModel = UserModel(
          userDetail['_id'],
          userDetail['_username'],
          userDetail['_dob'],
          userDetail['_password'],
          userDetail['_emailid'],
          userDetail['_mobileno'],

        );
        print(widget.userName);
        print(userDetail['_username']);
        if (widget.userName == userDetail['_username']) {
          _userDetailsList.add(userDetailsModel);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('User Details'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _userDetailsList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print('---------->Edit or Deleted Invoked : Send Data');
                  print(_userDetailsList[index].id);
                  print(_userDetailsList[index].userName);
                  print(_userDetailsList[index].dob);
                  print(_userDetailsList[index].password);
                  print(_userDetailsList[index].emailId);
                  print(_userDetailsList[index].mobileNo);

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                    settings: RouteSettings(
                      arguments: _userDetailsList[index],
                    ),
                  ));
                },
                child: ListTile(
                  title: Text(_userDetailsList[index].userName!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DOB: ${_userDetailsList[index].dob}'),
                      Text('Email: ${_userDetailsList[index].emailId}'),
                      Text('Mobile No: ${_userDetailsList[index].mobileNo}'),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('--------------> Launch Director Details Form Screen');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
