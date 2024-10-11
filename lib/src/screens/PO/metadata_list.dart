
import 'package:dealsify_production/src/state_controllers/production_order_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ProductionMetaDataList extends StatefulWidget {
  const ProductionMetaDataList({super.key});

  @override
  State<ProductionMetaDataList> createState() => _ProductionMetaDataListState();
}

class _ProductionMetaDataListState extends State<ProductionMetaDataList> {
  final record = Get.put(PORecordCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Production Metadata'),
      ),
      body: ListView(
        children: [
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: record.productionMetadata.,
          //   itemBuilder: (context, index) {
          //     return ItemBoxBox(
          //       itemName: 'Products',
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}

class ItemBoxBox extends StatelessWidget {
  final String? itemName;
  final String? quantity;
  final void Function()? onTap;

  const ItemBoxBox({
    Key? key,
    this.itemName,
    this.quantity,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.orangeAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemName?.toString() ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
