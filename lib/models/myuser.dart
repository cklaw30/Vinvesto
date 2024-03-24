class MyUser {
  final String name;
  final String email;
  final int age;
  // final String employmentStatus; // employed or student
  // final String salary;
  final String role;
  // any investment before

  MyUser({
    required this.name,
    required this.email,
    required this.age,
    // required this.employmentStatus,
    // required this.salary,
    required this.role,
  });

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      name: map['name'], 
      email: map['email'], 
      age: map['age'], 
      // employmentStatus: map['employmentStatus'], 
      // salary: map['salary'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'name': name,
      'email': email,
      'age': age,
      // 'employmentStatus': employmentStatus,
      // 'salary': salary,
      'role': role,
    };
  }
}