import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String customerId;

  const Home({required this.customerId, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
