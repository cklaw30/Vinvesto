class FD {
  final double rate;
  final int period;

  FD({
    required this.rate,
    required this.period,
  });

  factory FD.fromMap(Map<String, dynamic> map) {
    return FD(
        rate: map['rate'],
        period: map['period'],
      );
  }

  Map<String, dynamic> toMap() {
    return{
      'rate': rate,
      'period': period,
    };
  }
}