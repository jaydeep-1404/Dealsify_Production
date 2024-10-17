import 'package:dealsify_production/api/auth/login.dart';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:dealsify_production/src/common_functions/snackbars.dart';
import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:dealsify_production/src/state_controllers/scrap_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/Models/bomItems.dart';
import '../../../api/post/comlete_stage.dart';
import '../../common_functions/animations.dart';
import '../../state_controllers/production_order_states.dart';

class ScrapScreen extends StatefulWidget {
  const ScrapScreen({super.key});

  @override
  State<ScrapScreen> createState() => _ScrapScreenState();
}

class _ScrapScreenState extends State<ScrapScreen> {
  final record = Get.put(PORecordCtrl());
  final scrapController = Get.put(ScrapController());
  final save = Get.put(CompleteStageController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigateToPage(context, const ProductionOrderView());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${record.poRecord.value.items!.first.itemName}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${record.activeStage.value.label}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          }),
          toolbarHeight: 80,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              navigateToPage(context, const ProductionOrderView());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Obx(() {
                    return DropdownButtonFormField<BomItems>(
                      hint: const Text('Select Item...'),
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Select Item',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: Colors.transparent,
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
                            fillColor: Colors.transparent,
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
                            fillColor: Colors.transparent,
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
                      fillColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
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
                  const Divider(),
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
              _completeButton(
                onTap: () {
                  if (scrapController.records.isEmpty){
                    Open.openDateErrorSnackbar("Add items");
                  } else {
                    scrapController.payload().printFormattedJson();
                    save.post(
                      record.poRecord.value.id,
                      scrapController.payload(),
                      context,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _completeButton({onTap}){
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
          height: 35,
          width: Get.width / 1.2,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            border: Border.all(color: Colors.blue.shade700),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }


}


