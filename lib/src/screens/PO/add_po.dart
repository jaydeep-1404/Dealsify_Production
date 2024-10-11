
import 'package:flutter/material.dart';

class CreatePurchaseOrder extends StatefulWidget {
  const CreatePurchaseOrder({super.key});

  @override
  State<CreatePurchaseOrder> createState() => _CreatePurchaseOrderState();
}

class _CreatePurchaseOrderState extends State<CreatePurchaseOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create PO"),
      ),
      body: ListView(
        children: const [

        ],
      ),
    );
  }
}
