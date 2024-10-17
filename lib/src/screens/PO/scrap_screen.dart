import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/Models/bomItems.dart';
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
        title: Obx(() {
          return Text(
            '${record.poRecord.value.items!.first.itemName}',
            style: const TextStyle(
              color: Colors.black,
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
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Obx(() => Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.1),
            //         spreadRadius: 1,
            //         blurRadius: 4,
            //       ),
            //     ],
            //   ),
            //   child: DropdownButtonFormField(
            //     isExpanded: true,
            //     decoration: const InputDecoration(
            //       labelText: 'Select Option',
            //       border: OutlineInputBorder(),
            //       labelStyle: TextStyle(color: Colors.black54),
            //       filled: true,
            //       fillColor: Colors.white,
            //     ),
            //     value: scrapController.dropdownValue.value.isEmpty ? null : scrapController.dropdownValue.value,
            //     // items: const [
            //     //   DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
            //     //   DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
            //     //   DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
            //     // ],
            //     items: record.bomItems.map<DropdownMenuItem<String>>((BomItems item) {
            //       return DropdownMenuItem<String>(
            //         value: item.id,
            //         child: Text('${item.materialName} - Qty: ${item.quantity}'), // Display material name and quantity
            //       );
            //     }).toList(),
            //     onChanged: (value) {
            //       scrapController.dropdownValue.value = value ?? '';
            //
            //     },
            //   ),
            // )),
            Obx(() {
              return DropdownButtonFormField<BomItems>(
                hint: const Text('Select Item'),
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Select Option',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: scrapController.selectedBomItem.value,
                onChanged: scrapController.onBomItemSelected,
                items: record.bomItems.map<DropdownMenuItem<BomItems>>((BomItems item) {
                  return DropdownMenuItem<BomItems>(
                    value: item,
                    child: Text('${item.materialName}'),
                  );
                }).toList(),
              );
            }),
            // Obx(() {
            //   return Text("Selected BOM Item Group ID: ${scrapController.selectedBomItem.value!.groupId ?? 'None'}");
            // }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: scrapController.quantityController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10), // Adjusted input height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: scrapController.currentQtyController,
                    readOnly: true,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'Current Qty',
                      contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10), // Adjusted input height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: scrapController.descriptionController,
              maxLines: null,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Description',
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10), // Adjusted input height
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                labelStyle: const TextStyle(color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // if (scrapController.quantityController.text.isEmpty ||
                  //     scrapController.selectedBomItem.value.isEmpty) {
                  //   Get.snackbar(
                  //     'Validation Error',
                  //     'Please select an option and enter a quantity.',
                  //     snackPosition: SnackPosition.BOTTOM,
                  //   );
                  //   return;
                  // }

                  scrapController.addRecord();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF78909C),
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
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text('Option: ${record.dropdownValue}', style: const TextStyle(color: Color(0xFF455A64))),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: ${record.quantity}', style: const TextStyle(color: Colors.black87)),
                            Text('Current Qty: ${record.currentQty}', style: const TextStyle(color: Colors.black87)),
                            Text('Description: ${record.description}', style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
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

