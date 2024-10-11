
import 'package:dealsify_production/src/state_controllers/production_order_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/routs/routs.dart';

class ProductionMetaDataList extends StatefulWidget {
  const ProductionMetaDataList({super.key});

  @override
  State<ProductionMetaDataList> createState() => _ProductionMetaDataListState();
}

class _ProductionMetaDataListState extends State<ProductionMetaDataList> {
  final record = Get.put(PORecordCtrl());

  @override
  Widget build(BuildContext context) {
    final itemMetaData = record.poRecord.items![record.poItemIndex.value].productionMeta!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Production Metadata'),
        leading: IconButton(
          onPressed: () {
            Get.toNamed(ConstRoute.poItems);
          },
          icon: const Icon(Icons.arrow_back_ios,),
        ),
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: itemMetaData.length,
            itemBuilder: (context, index) {
              final item = itemMetaData[index];
              return ItemMetaData(
                itemName: item.serialNo,
              );
            },
          )
        ],
      ),
    );
  }
}

class ItemMetaData extends StatelessWidget {
  final String? itemName;
  final String? unit;
  final void Function()? onTap;

  const ItemMetaData({
    Key? key,
    this.itemName,
    this.unit,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(width: 1.5,color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemName?.toString() ?? '',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}