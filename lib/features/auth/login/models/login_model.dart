
class LoginModel {
  LoginModel({
      String? message, 
      User? user, 
      String? token,}){
    _message = message;
    _user = user;
    _token = token;
}

  LoginModel.fromJson(dynamic json) {
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  String? _message;
  User? _user;
  String? _token;
LoginModel copyWith({  String? message,
  User? user,
  String? token,
}) => LoginModel(  message: message ?? _message,
  user: user ?? _user,
  token: token ?? _token,
);
  String? get message => _message;
  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

/// name : "Moaz Omran"
/// email : "moazomran22@gmail.com"
/// role : "user"

class User {
  User({
      String? name, 
      String? email, 
      String? role,}){
    _name = name;
    _email = email;
    _role = role;
}

  User.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _role = json['role'];
  }
  String? _name;
  String? _email;
  String? _role;
User copyWith({  String? name,
  String? email,
  String? role,
}) => User(  name: name ?? _name,
  email: email ?? _email,
  role: role ?? _role,
);
  String? get name => _name;
  String? get email => _email;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['role'] = _role;
    return map;
  }

}