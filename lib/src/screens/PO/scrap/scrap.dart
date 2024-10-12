
import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../state_controllers/production_order_states.dart';

class ScraptScreen extends StatefulWidget {

  const ScraptScreen({super.key});

  @override
  State<ScraptScreen> createState() => _ScraptScreenState();
}

class _ScraptScreenState extends State<ScraptScreen> {
  final ScrapController scrap = Get.put(ScrapController());
  final record = Get.put(PORecordCtrl());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void _saveForm() {
  //   if (_formKey.currentState!.validate() && scrap.validateFields()) {
  //     Get.snackbar('Success', 'All fields are valid!',
  //         snackPosition: SnackPosition.BOTTOM);
  //   } else {
  //     Get.snackbar('Error', 'Please fill all fields correctly.',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

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
      body: Form(
        key: _formKey,
        child: Obx(() => ListView.builder(
          itemCount: scrap.qtyCtrl.length + 1,
          itemBuilder: (context, index) {
            if (index == scrap.qtyCtrl.length) {
              return saveButton(onTap: () {

                });
            }
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26,width: 1),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,top: 5),
                          child: Text("Item ${index + 1}"),
                        ),
                      ),
                      // Obx(() {
                      //   return Container(
                      //     margin: const EdgeInsets.symmetric(horizontal: 8),
                      //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(4.0),
                      //     ),
                      //     child: DropdownButton<DemoList>(
                      //       hint: const Text('Select an item'),
                      //       value: scrap.selectedItems[index],
                      //       isExpanded: true,
                      //       underline: const SizedBox(),
                      //       onChanged: (DemoList? newValue) {
                      //         scrap.updateSelectedItem(index, newValue);
                      //       },
                      //       items: scrap.items.map<DropdownMenuItem<DemoList>>((DemoList item) {
                      //         return DropdownMenuItem<DemoList>(
                      //           value: item,
                      //           child: Text(item.name),
                      //         );
                      //       }).toList(),
                      //     ),
                      //   );
                      // }),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Align(
                          child: Text("${record.poRecord.items![record.poItemIndex.value].itemName}"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          qtyField(controller: scrap.qtyCtrl[index]),
                          currentQtyField(controller: scrap.currentQtyCtrl[index]),
                        ],
                      ),
                      description(controller: scrap.currentQtyCtrl[index]),
                    ],
                  ),
                ),
                const SizedBox(height: 3,),
                const Divider(indent: 10,endIndent: 10,height: 1,)
              ],);
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scrap.addNewField,
        tooltip: 'Add new field',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget saveButton({void Function()? onTap}){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onTap ?? () {

              },
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10,),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: const Center(
                  child: Text("Save",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget qtyField({controller}){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            labelText: 'Qty',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget currentQtyField({controller}){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            labelText: 'Current qty ',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget description({controller}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          labelText: 'Description',
        ),
      ),
    );
  }


}

class DemoList {
  final int id;
  final String name;

  DemoList({required this.id, required this.name});
}



class ScrapController extends GetxController {
  var qtyCtrl = <TextEditingController>[].obs;
  var currentQtyCtrl = <TextEditingController>[].obs;
  var descriptionCtrl = <TextEditingController>[].obs;

  List<DemoList> items = [
    DemoList(id: 1, name: 'Item 1'),
    DemoList(id: 2, name: 'Item 2'),
    DemoList(id: 3, name: 'Item 3'),
  ];

  var selectedItems = <int, DemoList?>{}.obs;

  void updateSelectedItem(int recordId, DemoList? item) {
    selectedItems[recordId] = item;
    if (item != null) {
      print('Selected ID for Record $recordId: ${item.id}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _addNewField();
  }

  void _addNewField() {
    qtyCtrl.add(TextEditingController());
    currentQtyCtrl.add(TextEditingController());
    descriptionCtrl.add(TextEditingController());
  }

  void addNewField() {
    _addNewField();
  }

  bool validateFields() {
    for (var controller in qtyCtrl) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    for (var controller in currentQtyCtrl) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    for (var controller in descriptionCtrl) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void onClose() {
    // for (var controller in qtyCtrl) {
    //   controller.dispose();
    // }
    // for (var controller in currentQtyCtrl) {
    //   controller.dispose();
    // }
    // for (var controller in currentQtyCtrl) {
    //   controller.dispose();
    // }
    super.onClose();
  }
}