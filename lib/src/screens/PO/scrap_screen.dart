import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_functions/animations.dart';
import '../../state_controllers/completeStage.dart';
import '../../state_controllers/production_order_states.dart';

class ScrapScreen extends StatefulWidget {
  const ScrapScreen({super.key});

  @override
  State<ScrapScreen> createState() => _ScrapScreenState();
}

class _ScrapScreenState extends State<ScrapScreen> {
  final record = Get.put(PORecordCtrl());
  final scrapController = Get.put(ScrapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.blueAccent,
        title: Obx(() {
          return Text(
            '${record.poRecord.value.items!.first.itemName}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            navigateToPage(context, const ProductionOrderView());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Select Option',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black54),
                ),
                value: scrapController.dropdownValue.value.isEmpty
                    ? null
                    : scrapController.dropdownValue.value,
                items: const [
                  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
                  DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
                ],
                onChanged: (value) {
                  scrapController.dropdownValue.value = value ?? '';
                },
              ),
            )),
            const SizedBox(height: 10),
            // Row for Quantity and Current Qty
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: scrapController.quantityController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14), // Smaller font size
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      contentPadding: const EdgeInsets.symmetric(vertical: 8), // Reduced input height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelStyle: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: scrapController.currentQtyController,
                    readOnly: true,
                    style: const TextStyle(fontSize: 14), // Smaller font size
                    decoration: InputDecoration(
                      labelText: 'Current Qty',
                      contentPadding: const EdgeInsets.symmetric(vertical: 8), // Reduced input height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelStyle: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Description Input
            TextFormField(
              controller: scrapController.descriptionController,
              maxLines: null,
              style: const TextStyle(fontSize: 14), // Smaller font size
              decoration: InputDecoration(
                labelText: 'Description',
                contentPadding: const EdgeInsets.symmetric(vertical: 8), // Reduced input height
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                labelStyle: const TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Validate Quantity and Dropdown Value
                  if (scrapController.quantityController.text.isEmpty ||
                      scrapController.dropdownValue.value.isEmpty) {
                    Get.snackbar(
                      'Validation Error',
                      'Please select an option and enter a quantity.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  scrapController.addRecord();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: scrapController.records.length,
                  itemBuilder: (context, index) {
                    var record = scrapController.records[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text('Option: ${record.dropdownValue}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: ${record.quantity}'),
                            Text('Current Qty: ${record.currentQty}'),
                            Text('Description: ${record.description}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            scrapController.deleteRecord(index);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}