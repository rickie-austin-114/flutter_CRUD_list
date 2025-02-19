class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String address;

  Patient({required this.id, required this.name, required this.age, required this.gender, required this.address});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'address': address,
    };
  }
}
