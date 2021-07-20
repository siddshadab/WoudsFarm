class SignUpModel {
  String fname;
  String lname;
  String email;
  String password;
  String mobileno;
  String groupcd;

  SignUpModel(
      {this.fname,
        this.lname,
        this.email,
        this.password,
        this.mobileno,
        this.groupcd});

  @override
  String toString() {
    return 'SignUpModel{fname: $fname, lname: $lname, email: $email, password: $password, mobileno: $mobileno, groupcd: $groupcd}';
  }

  SignUpModel.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    password = json['password'];
    mobileno = json['mobileno'];
    groupcd = json['groupcd'];
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