
import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../state_controllers/production_order_states.dart';

class ScraptScreen extends StatefulWidget {
  const ScraptScreen({super.key});

  @override
  State<ScraptScreen> createState() => _ScraptScreenState();
}

class _ScraptScreenState extends State<ScraptScreen> {
  final record = Get.put(PORecordCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () {
            Get.to(const POItemsPage());
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Items"),
            Text("${record.poRecord.customerId!.shortName}",style: const TextStyle(fontSize: 15),),
            Text("${record.poRecord.productionOrderNo}",style: const TextStyle(fontSize: 15),),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.blueGrey[300],
      ),
    );
  }
}
