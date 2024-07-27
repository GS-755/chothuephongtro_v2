class PaymentUrlNode {
  final String paymentUrl;

  PaymentUrlNode({required this.paymentUrl});

  factory PaymentUrlNode.fromJson(Map<String, dynamic> json) {
    return PaymentUrlNode(paymentUrl: json['PaymentUrl']);
  }
  Map<String, dynamic> toJson() {
    return {
      'PaymentUrl': this.paymentUrl
    };
  }
}
