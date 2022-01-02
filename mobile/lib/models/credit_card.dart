class CreditCard {
  final int id;

  CreditCard({required this.id});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(id: json['id']);
  }
}
