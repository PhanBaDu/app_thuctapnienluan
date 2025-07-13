class SignUpBody {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;

  SignUpBody({this.fName, this.lName, this.phone, this.email='', this.password, this.confirmPassword});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    fName = json['first_name'];
    lName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = fName;
    data['last_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}
