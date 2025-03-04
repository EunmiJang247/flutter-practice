import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() {
    return _WalletState();
  }
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('?'),
      ),
    );
  }
}
