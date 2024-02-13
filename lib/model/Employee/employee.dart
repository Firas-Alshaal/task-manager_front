class Employee {
  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.V,
  });

  late final String id;
  late final String name;
  late final String email;
  late final int V;

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['__v'] = V;
    return data;
  }
}
