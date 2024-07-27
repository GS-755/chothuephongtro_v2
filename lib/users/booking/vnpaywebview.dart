import 'package:chothuephongtro_v2/users/transactions/paymenturlnode.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VnPayWebView extends StatefulWidget {
  final PaymentUrlNode websiteUrl;

  VnPayWebView({super.key, required this.websiteUrl});

  @override
  _MyWebViewState createState() => _MyWebViewState(websiteUrl: this.websiteUrl);
}

class _MyWebViewState extends State<VnPayWebView> {
  final PaymentUrlNode websiteUrl;
  late final WebViewController _controller;

  _MyWebViewState({required this.websiteUrl});

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(
        Uri.parse(this.websiteUrl.paymentUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán giao dịch VNPay'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
