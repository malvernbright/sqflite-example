import 'package:database_app/database/databaseHelper.dart';
import 'package:database_app/models/User.dart';
import 'package:database_app/views/UserDetails.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper db = DatabaseHelper.instance;
  User user;
  List<User> usersList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          usersList = snapshot.data;
          return RefreshIndicator(
            onRefresh: db.getAllUsers,
            child: ListView.builder(
                itemCount: usersList == null ? 0 : usersList.length,
                itemBuilder: (BuildContext context, int index) {
                  user = usersList[index];
                  return Card(
                    child: ListTile(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDetail(
                                      firstname: usersList[index].firstname,
                                      lastname: usersList[index].lastname,
                                      contact: usersList[index].contact,
                                      occupation: usersList[index].occupation,
                                      specialConditions:
                                          usersList[index].specialConditions,
                                      residentialAddress:
                                          usersList[index].residentialAddress,
                                      maritalStatus:
                                          usersList[index].maritalStatus,
                                      dob: usersList[index].dob,
                                    )))
                      },
                      isThreeLine: true,
                      title: Text('${user.firstname} ${user.lastname}'),
                      leading: CircleAvatar(
                        child: Center(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(user.firstname[0]),
                                SizedBox(
                                  width: 2.0,
                                ),
                                Text(user.lastname[0]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Marital Status: ${user.maritalStatus}'),
                            Text('Date Of Birth: ${user.dob}'),
                          ],
                        ),
                      ),
                      trailing: GestureDetector(
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                          size: 35.0,
                        ),
                        onTap: () {
                          db.deleteUser(user.id);
                          setState(() {
                            usersList.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                }),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  navigateToDetail() {
  }

  void updateListView() {
    final Future<Database> dbFuture = db.initiateDatabase();
    dbFuture.then((database) => setState(() {
          this.usersList = usersList;
          this.count = usersList.length;
        }));
  }

  _showUserDetailAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${user.firstname} ${user.lastname}'s Details"),
            content: Container(
              height: MediaQuery.of(context).size.height * .6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${user.firstname} ${user.lastname}"),
                  Text("Occupation: ${user.occupation}"),
                ],
              ),
            ),
          );
        });
  }
}
