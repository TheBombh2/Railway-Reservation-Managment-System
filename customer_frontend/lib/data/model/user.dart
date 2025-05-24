import 'package:customer_frontend/secrets.dart';

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

class UserRegister{
  String? phoneNumber;
  String? email;
  String? gender;
  String? lastName;
  String? middleName;
  String? firstName;
  String? password;
  String? passwordSalt;


UserRegister(
      {this.phoneNumber,
      this.email,
      this.gender,
      this.lastName,
      this.middleName,
      this.firstName,
      this.password,
      this.passwordSalt});

      UserRegister.empty(){
      email = "";
      gender="";
      phoneNumber ="";
      lastName = "";
      middleName = "";
      firstName = "";
      }

  UserRegister.fromJson(Map<String, dynamic> json) {
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
    data['passwordHash'] = this.password;
    data['passwordSalt'] = this.passwordSalt;
    data['pfpb64'] = Secrets.samplePfp;

    return data;
  }
}

