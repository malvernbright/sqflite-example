import 'package:database_app/database/databaseHelper.dart';
import 'package:database_app/main.dart';
import 'package:database_app/models/User.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  UserForm({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  List<User> usersList;
  final String title = "Add User";
  final _formKey = GlobalKey<FormState>();

  // final _dateEditingController = TextEditingController();
  String firstName,
      lastName,
      contactPhone,
      occupation,
      specialConditions,
      resAddress,
      maritalStatus,
      dob;
  int dependencies;

  // DateTime dob = DateTime.now();
  DatabaseHelper db = DatabaseHelper.instance;
  Color myColor = Color(0xFFFFFF);
  Size mySize = Size(14.0, 14.0);
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    icon: Icon(Icons.drive_file_rename_outline),
                    labelText: "FirstName",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) => setState(() => firstName = val),
                  validator: (val) => val.isNotEmpty ? null : "Enter FirstName",
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    icon: Icon(Icons.drive_file_rename_outline),
                    labelText: "Last Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) => setState(() => lastName = val),
                  validator: (val) => val.isNotEmpty ? null : "Enter LastName",
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: "Contact Phone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) => setState(() => contactPhone = val.toString()),
                  validator: (val) => val.isNotEmpty ? null : "Enter Phone",
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    icon: Icon(Icons.work),
                    labelText: "Occupation",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) => setState(() => occupation = val),
                  validator: (val) =>
                      val.isNotEmpty ? null : "Enter Occupation",
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    icon: Icon(Icons.local_hospital),
                    labelText: "Any Special Conditions",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) => setState(() => specialConditions = val),
                  validator: (val) =>
                      val.isNotEmpty ? null : "Enter Special Condition(s)",
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    icon: Icon(Icons.home),
                    labelText: "Residential Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) => setState(() => resAddress = val),
                  validator: (val) =>
                      val.isNotEmpty ? null : "Enter Residential Address",
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    labelText: "Marital Status",
                    hintText: "enter text Married (if married) or N/A (if not)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) => setState(() => maritalStatus = val),
                  validator: (val) =>
                      val.isNotEmpty ? null : "Enter Occupation",
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.child_care),
                    labelText: "Number of Dependencies",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) =>
                      setState(() => dependencies = int.parse(val)),
                  validator: (val) =>
                      val.isNotEmpty ? null : "Enter Occupation",
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: "DOB",
                    hintText: "dd-MM-YYYY",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) => setState(() => dob = val),
                  validator: (val) => val.isNotEmpty ? null : "Enter DOB",
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: RaisedButton.icon(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        User user = User(
                          firstname: firstName,
                          lastname: lastName,
                          contact: contactPhone,
                          occupation: occupation,
                          specialConditions: specialConditions,
                          residentialAddress: resAddress,
                          maritalStatus: maritalStatus,
                          dependencies: dependencies,
                          dob: dob.toString(),
                        );

                        await db.insert(user).then((value) =>
                            print("User data added to database $value"));
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => MyApp()));
                      }
                    },
                    icon: Icon(
                      Icons.save,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Save User",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Future _selectDate() async {
//   DateTime newSelectedDate = await showDatePicker(
//     context: context,
//     initialDate: dob != null ? dob : DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2040),
//   );
//
//   if (newSelectedDate != null)
//     setState(
//         () => {_dateEditingController.text = newSelectedDate.toString()});
// }

// void _save(User user) async {
//       user.firstname= firstName;
//       user.lastname= lastName;
//       contact: contactPhone;
//       occupation: occupation;
//       specialConditions: specialConditions;
//       residentialAddress: resAddress;
//       maritalStatus: maritalStatus;
//       dependencies: dependencies;
//       dob: dob.toString();)
//   await db.insert(user).then((value) =>
//       print("User data added to database $value"));
//   Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => MyApp());
// }
}
