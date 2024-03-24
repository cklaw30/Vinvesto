class InBank {
  final String bankId;
  final double deposit;
  final List<Map<String, dynamic>> fds;

  InBank({
    required this.bankId,
    required this.deposit,
    required this.fds,
  });

  factory InBank.fromMap(Map<String, dynamic> map) {
    return InBank(
        bankId: map['bankId'],
        deposit: map['deposit'],
        fds: List<Map<String, dynamic>>.from(map['fds']),
      );
  }

  Map<String, dynamic> toMap() {
    return{
      'bankId': bankId,
      'deposit': deposit,
      'fds': fds,
    };
  }
}