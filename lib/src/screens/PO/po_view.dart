
import 'package:dealsify_production/core/routs/routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/production_order_states.dart';

class PoView extends StatefulWidget {
  const PoView({super.key});

  @override
  State<PoView> createState() => _PoViewState();
}

class _PoViewState extends State<PoView> {
  final record = Get.put(PORecordCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.toNamed(ConstRoute.dashboard);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Column(
          children: [
            Text("Items")
            ],
        ),
        centerTitle: false,
        backgroundColor: Colors.yellow,
      ),
      body: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: record.poRecord.items!.length,
              itemBuilder: (context, index) {
                final item = record.poRecord.items![index];
                return ItemBox(
                  onTap: () {
                    // record.saveProductionMetaData(item.productionMeta);
                    Get.toNamed(ConstRoute.productionMetaData);
                  },
                  itemName: item.itemName,
                );
              },
            ),
          ],
      ),
    );
  }
}



class ItemBox extends StatelessWidget {
  final String? itemName;
  final String? quantity;
  final void Function()? onTap;

  const ItemBox({
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
          border: Border.all(width: 1.5,color: Colors.black26),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemName?.toString() ?? '',
              style: const TextStyle(
                color: Colors.grey,
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