import 'package:flutter/foundation.dart';

class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact({
    @required this.id,
    @required this.name,
    @required this.accountNumber,
  })  : assert(id != null),
        assert(name != null),
        assert(accountNumber != null);

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        accountNumber = json['accountNumber'];

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountNumber: $accountNumber}';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          accountNumber == other.accountNumber;

  @override
  int get hashCode => name.hashCode ^ accountNumber.hashCode;
}
