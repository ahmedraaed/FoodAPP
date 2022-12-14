class UserModel
{
  int id;
  String name;
  String email;
  String phone;
  int ordercount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.ordercount,
});
  factory UserModel.fromJson(Map<String,dynamic> json)
  {
    return UserModel(
        id: json['id'],
        name: json['f_name'],
        email: json["email"],
        phone: json["phone"],
        ordercount: json["order_count"]
    );

  }
}