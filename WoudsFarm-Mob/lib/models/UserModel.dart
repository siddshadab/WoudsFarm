class UserModel {
  String fname;
  String firstName;
  String lname;
  String email;
  String password;
  String mobileno;
  String groupcd;
  String lastName;

  UserModel(
      {this.fname,
      this.lname,
      this.email,
      this.password,
      this.mobileno,
      this.groupcd,
      this.firstName,
      this.lastName});

  @override
  String toString() {
    return 'UserModel{fname: $fname, lname: $lname, email: $email, password: $password, mobileno: $mobileno, groupcd: $groupcd}';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      password: json['password'],
      mobileno: json['mobileno'],
      groupcd: json['groupcd'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobileno'] = this.mobileno;
    data['groupcd'] = this.groupcd;
    return data;
  }
}
