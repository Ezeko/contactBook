import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  String name;

  @HiveField(1)
  int phone;

  @HiveField(2)
  String address;

  
  Map toMap() {
    return (
      {'name': name, 'phone_number': phone, 'address': address}
      );
  }
}