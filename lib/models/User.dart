class User {
  int id;
  String firstname;
  String lastname;
  String contact;
  String occupation;
  String specialConditions;
  String residentialAddress;
  String maritalStatus;
  int dependencies;
  String dob;

  User(
      {this.id,
      this.firstname,
      this.lastname,
      this.contact,
      this.occupation,
      this.specialConditions,
      this.residentialAddress,
      this.maritalStatus,
      this.dependencies,
      this.dob});

  // deserializing data
  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'],
        firstname: data['firstname'],
        lastname: data['lastname'],
        contact: data['contact'],
        occupation: data['occupation'],
        specialConditions: data['specialConditions'],
        residentialAddress: data['residentialAddress'],
        maritalStatus: data['maritalStatus'],
        dependencies: data['dependencies'],
        dob: data['dob'],
      );

  //serializing data
  Map<String, dynamic> toMap() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'contact': contact,
        'occupation': occupation,
        'specialConditions': specialConditions,
        'residentialAddress': residentialAddress,
        'maritalStatus': maritalStatus,
        'dependencies': dependencies,
        'dob': dob
      };
}
