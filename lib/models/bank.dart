class Bank {
  final String imagePath;
  final String name;
  final List<Map<String, dynamic>> ffs;
  final List<Map<String, dynamic>> ffo;
  final double minDeposit;

  Bank({
    required this.imagePath,
    required this.name,
    required this.ffs,
    required this.ffo,
    required this.minDeposit,
  });

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
        imagePath: map['imagePath'],
        name: map['name'],
        ffs: List<Map<String, dynamic>>.from(map['ffs']),
        ffo: List<Map<String, dynamic>>.from(map['ffo']),
        minDeposit: map['minDeposit'],
        );
  }

  Map<String, dynamic> toMap() {
    return{
      'imagePath': imagePath,
      'name': name,
      'ffs': ffs,
      'ffo': ffo,
      'minDeposit': minDeposit,
    };
  }
}