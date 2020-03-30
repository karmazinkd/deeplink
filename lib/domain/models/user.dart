class User {
  final String name;
  final String email;
  final int id;

  User({this.name, this.email, this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['user']['name'],
      email: json['user']['email'],
      id: json['user']['id'],
    );
  }

  bool isValid(){
    return email != null && id != null;
  }

  @override
  String toString() {
    if(name != null)
      return name;
    else{
      return "User_$id";
    }
  }


}