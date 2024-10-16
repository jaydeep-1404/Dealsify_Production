
import 'package:dealsify_production/src/common_functions/animations.dart';
import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../state_controllers/production_order_states.dart';

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
  void dispose() {
    scrap.clearAllData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () {
            navigateToPage(context, const OrderDetailScreen());
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Items", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("PO No. :-  ${record.poRecord.value.productionOrderNo}", style: const TextStyle(fontSize: 15)),
            Text("Item :-  ${record.poRecord.value.items![record.poItemIndex.value].itemName}", style: const TextStyle(fontSize: 15)),
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
                if (_formKey.currentState!.validate() && scrap.validateFields()) {
                  Get.snackbar('Success', 'All fields are valid!',
                      snackPosition: SnackPosition.BOTTOM);
                } else {
                  Get.snackbar('Error', 'Please fill all fields correctly.',
                      snackPosition: SnackPosition.BOTTOM);
                }
              });
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 1),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Item ${index + 1}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Align(
                          child: Text("${record.poRecord.value.items![record.poItemIndex.value].itemName}", style: const TextStyle(fontSize: 14)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          qtyField(controller: scrap.qtyCtrl[index]),
                          currentQtyField(controller: scrap.currentQtyCtrl[index]),
                        ],
                      ),
                      description(controller: scrap.descriptionCtrl[index]),
                    ],
                  ),
                ),
              ),
            );
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

  Widget saveButton({void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onTap ?? () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: const Center(
                child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget qtyField({required TextEditingController controller}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            labelText: 'Qty *',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter qty';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget currentQtyField({required TextEditingController controller}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          readOnly: true,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            labelText: 'Current qty',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
        ),
      ),
    );
  }

  Widget description({required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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

  clearAllData() {
    qtyCtrl.clear();
    currentQtyCtrl.clear();
    descriptionCtrl.clear();
  }

  void addNewField() {
    qtyCtrl.add(TextEditingController());
    currentQtyCtrl.add(TextEditingController());
    descriptionCtrl.add(TextEditingController());
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
}