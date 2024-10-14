
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../state_controllers/production_order_states.dart';

class AdonScreen extends StatefulWidget {

  const AdonScreen({super.key});

  @override
  State<AdonScreen> createState() => _AdonScreenState();
}

class _AdonScreenState extends State<AdonScreen> {
  final AdonController scrap = Get.put(AdonController());
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

  void _saveForm() {
    if (_formKey.currentState!.validate() && scrap.validateFields()) {
      Get.snackbar('Success', 'All fields are valid!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'Please fill all fields correctly.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () {
            // Get.to(const OrderDetailScreen());
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
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Save'),
                ),
              );
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: scrap.qtyCtrl[index],
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
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: scrap.currentQtyCtrl[index],
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
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: scrap.currentQtyCtrl[index],
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
                      ),
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
}

class AdonController extends GetxController {
  var qtyCtrl = <TextEditingController>[].obs;
  var currentQtyCtrl = <TextEditingController>[].obs;
  var descriptionCtrl = <TextEditingController>[].obs;

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
    super.onClose();
  }
}