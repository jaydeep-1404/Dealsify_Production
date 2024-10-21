import 'dart:io';

import 'package:dealsify_production/core/services/extensions.dart';
import 'package:dealsify_production/src/common_functions/snackbars.dart';
import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:dealsify_production/src/state_controllers/scrap_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/Models/bomItems.dart';
import '../../../api/post/comlete_stage.dart';
import '../../../core/colors_and_icons/colors.dart';
import '../../../core/colors_and_icons/images.dart';
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
                const Text(
                  'Scrap Material',
                  // '${record.poRecord.value.items!.itemName}',
                  maxLines: 3,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontFamily: FontFamily.boldMulish,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${record.poRecord.value.items!.itemName}',
                  // '${record.activeStage.value.label}',
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: FontFamily.boldMulish,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black87,
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
              color: Colors.black87,
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
                      hint: const Text(
                          'Select Item...',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: FontFamily.regularMulish,
                        ),
                      ),
                      isExpanded: true,
                      style: const TextStyle(
                        fontFamily: FontFamily.regularMulish,
                        color: Colors.black87,
                        fontSize: 15
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Select Item',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: FontFamily.regularMulish,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      value: scrapController.selectedBomItem.value,
                      onChanged: scrapController.onBomItemSelected,
                      items: record.bomItems.map<DropdownMenuItem<BomItems>>((BomItems item) {
                        return DropdownMenuItem<BomItems>(
                          value: item,
                          child: Text(
                            '${item.materialName}',
                            style: const TextStyle(
                                fontFamily: FontFamily.regularMulish
                            ),
                          ),
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
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: FontFamily.regularRoboto,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10), // Adjusted input height
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontFamily: FontFamily.regularMulish,
                            ),
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
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: FontFamily.regularRoboto,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Current Qty',
                            contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10), // Adjusted input height
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontFamily: FontFamily.regularMulish,
                            ),
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.regularMulish,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10), // Adjusted input height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontFamily: FontFamily.regularMulish,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (scrapController.quantityController.text.trim().isEmpty){
                          Open.openDateErrorSnackbar("Enter Quantity");
                        } else if (compareStringDoubles(
                          scrapController.quantityController.text,
                          scrapController.currentQtyController.text,
                        ) == false){
                          Open.openDateErrorSnackbar("Quantity is bigger than Current Quantity");
                        } else {
                          scrapController.addRecord();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        minimumSize: const Size(100,35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.regularMulish,
                          )),
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
                              // title: Text('Item: ${record.dropdownValue}', style: const TextStyle(color: Color(0xFF455A64))),
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Item : ${record.dropdownValue}',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontFamily: FontFamily.regularMulish,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: record.description.isNotEmpty ? record.description : "-",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontFamily: FontFamily.regularMulish,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Quantity : ',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: FontFamily.regularMulish,
                                            fontWeight: FontWeight.bold, // Optional: To make the label bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: record.quantity,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontFamily: FontFamily.regularRoboto,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Current Qty : ',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: FontFamily.regularMulish,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: record.currentQty,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontFamily: FontFamily.regularRoboto,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Description : ',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: FontFamily.regularMulish,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: record.description.isNotEmpty ? record.description : "-",
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontFamily: FontFamily.regularMulish,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
              Obx(() {
                return _saveButton(
                  loading: save.loadingScrap.value,
                  onTap: () {
                    if (scrapController.records.isEmpty){
                      Open.openDateErrorSnackbar("Add items");
                    } else {
                      scrapController.payload().printFormattedJson();
                      save.post(
                        isScrap: true,
                        record.poRecord.value.id,
                        scrapController.payload(),
                        context,
                      );
                    }
                  },
                );
              },),

            ],
          ),
        ),
      ),
    );
  }

  bool compareStringDoubles(String firstString, String secondString) {
    try {
      double firstDouble = double.parse(firstString);
      double secondDouble = double.parse(secondString);
      return firstDouble <= secondDouble;
    } catch (e) {
      if (kDebugMode) {
        print("Invalid input: ${e.toString()}");
      }
      return false;
    }
  }

  Widget _saveButton({onTap,loading}){
    return Positioned(
      bottom: Platform.isIOS ? 40 : 30,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
          height: 35,
          width: Get.width / 1.2,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            border: Border.all(color: green_high),
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
            child: loading == true ? const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(strokeWidth: 1.5,)) : const Text(
              'Save',
              style: TextStyle(
                color: green_high,
                fontSize: 15,
                fontFamily: FontFamily.regularMulish,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }


}


