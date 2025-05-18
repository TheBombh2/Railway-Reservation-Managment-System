class User {
  String? phoneNumber;
  String? email;
  String? gender;
  String? lastName;
  String? middleName;
  String? firstName;

  User(
      {this.phoneNumber,
      this.email,
      this.gender,
      this.lastName,
      this.middleName,
      this.firstName});

      User.empty(){
      email = "";
      gender="";
      phoneNumber ="";
      lastName = "";
      middleName = "";
      firstName = "";
      }

  User.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    gender = json['gender'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['firstName'] = this.firstName;
    return data;
  }
}


