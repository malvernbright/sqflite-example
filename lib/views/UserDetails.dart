import 'package:database_app/database/databaseHelper.dart';
import 'package:database_app/models/User.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  UserDetail({
    this.firstname,
    this.lastname,
    this.contact,
    this.occupation,
    this.specialConditions,
    this.residentialAddress,
    this.maritalStatus,
    this.dependencies,
    this.dob,
  });

  final String firstname,
      lastname,
      contact,
      occupation,
      specialConditions,
      residentialAddress,
      maritalStatus,
      dob;

  final int dependencies;

  @override
  _UserDetailState createState() => _UserDetailState();
}

TextStyle titleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
TextStyle normalStyle = TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

class _UserDetailState extends State<UserDetail> {
  _UserDetailState();

  User user;
  DatabaseHelper db = DatabaseHelper.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.firstname} ${widget.lastname}"),
      ),
      body: Center(
        child: Card(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * .9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Colors.green,
                    ),
                    Text(
                      "\t${widget.firstname} ${widget.lastname}",
                      style: titleStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      color: Colors.green,
                    ),
                    Text(
                      "\t${widget.occupation}",
                      style: normalStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    Text(
                      "\t${widget.contact}",
                      style: normalStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_hospital,
                      color: Colors.red,
                    ),
                    Text(
                      "Conditions:\t ${widget.specialConditions}",
                      style: normalStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Icon(Icons.home_outlined),
                    Text("\t ${widget.residentialAddress}"),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Text("\t ${widget.maritalStatus}"),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.group,
                      color: Colors.blue,
                    ),
                    Text("\t ${widget.dependencies}"),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.brown,
                    ),
                    Text("\t ${widget.dob}"),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: RaisedButton.icon(
                      onPressed: () =>
                          _editUser(context, "Edit ${widget.firstname}"),
                      icon: Icon(Icons.edit),
                      label: Text("Edit ${widget.firstname}")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _editUser(BuildContext context, String title) async {
    return showDialog(
      context: context,
      child: AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "${widget.firstname}",
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(Icons.drive_file_rename_outline),
                        labelText: "FirstName",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) => setState(() => user.firstname = val),
                      validator: (val) =>
                      val.isNotEmpty ? null : "Enter FirstName",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: "${widget.lastname}",
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(Icons.drive_file_rename_outline),
                        labelText: "Last Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) => setState(() => user.lastname = val),
                      validator: (val) =>
                      val.isNotEmpty ? null : "Enter LastName",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: "${widget.contact}",
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        labelText: "Contact Phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => user.contact = val.toString()),
                      validator: (val) => val.isNotEmpty ? null : "Enter Phone",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: "${widget.occupation}",
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(Icons.work),
                        labelText: "Occupation",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) => setState(() => user.occupation = val),
                      validator: (val) =>
                      val.isNotEmpty ? null : "Enter Occupation",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: "${widget.specialConditions}",
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(Icons.local_hospital),
                        labelText: "Any Special Conditions",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => user.specialConditions = val),
                      validator: (val) =>
                      val.isNotEmpty ? null : "Enter Special Condition(s)",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: "${widget.residentialAddress}",
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(Icons.home),
                        labelText: "Residential Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => user.residentialAddress = val),
                      validator: (val) =>
                      val.isNotEmpty ? null : "Enter Residential Address",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: "${widget.maritalStatus}",
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        labelText: "Marital Status",
                        hintText:
                        "enter text Married (if married) or N/A (if not)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => user.maritalStatus = val),
                      validator: (val) =>
                      val.isNotEmpty ? null : "Enter Occupation",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: "${widget.dependencies}",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.child_care),
                        labelText: "Number of Dependencies",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => user.dependencies = int.parse(val)),
                      validator: (val) =>
                      val.isNotEmpty ? null : "Enter Occupation",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: "${widget.dob}",
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: "DOB",
                        hintText: "dd-MM-YYYY",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (val) => setState(() => user.dob = val),
                      validator: (val) => val.isNotEmpty ? null : "Enter DOB",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                )),
          ),
          actions: [
          RaisedButton.icon(
          onPressed: () async => {if (_formKey.currentState.validate()) {
            User(
            firstname: widget.firstname,
            lastname: widget.lastname,
            contact: widget.contact,
            occupation: widget.occupation,
            specialConditions: widget.specialConditions,
            residentialAddress: widget.residentialAddress,
            maritalStatus: widget.maritalStatus,
            dependencies: widget.dependencies,
            dob: widget.dob.toString(),
            ),

    await db.insert(user).then((value) =>
    print("User data update to database $value"))
    }},
      icon: Icon(Icons.save),
      label: Text("Save ${widget.firstname}"),
      color: Theme
          .of(context)
          .primaryColor,
    )],
    )
    ,
    );
  }
}
