
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CreatePurchaseOrder extends StatefulWidget {
  const CreatePurchaseOrder({super.key});

  @override
  State<CreatePurchaseOrder> createState() => _CreatePurchaseOrderState();
}

class _CreatePurchaseOrderState extends State<CreatePurchaseOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create PO"),
      ),
      body: ListView(
        children: [
          TextFormField(

          ),
        ],
      ),
    );
  }
}

class MyController extends GetxController {
  var isSwitched = false.obs;
  var textField1 = ''.obs;
  var textField2 = ''.obs;
  var selectedDate1 = DateTime.now().obs;
  var selectedDate2 = DateTime.now().obs;
  var selectedDate3 = DateTime.now().obs;

  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }
}

class MyApp extends StatelessWidget {
  final MyController controller = Get.put(MyController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX Page Example")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text("Enable Feature"),
              value: controller.isSwitched.value,
              onChanged: controller.toggleSwitch,
            ),
            SizedBox(height: 20),
            Obx(() {
              return TextFormField(
                decoration: InputDecoration(
                  labelText: "Text Field 1",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(),
                  ),
                ),
                initialValue: controller.textField1.value,
                onChanged: (value) => controller.textField1.value = value,
              );
            }),
            Obx(() {
              return TextFormField(
                decoration: InputDecoration(
                  labelText: "Text Field 2",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(),
                  ),
                ),
                initialValue: controller.textField2.value,
                onChanged: (value) => controller.textField2.value = value,
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate1.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    controller.selectedDate1.value = pickedDate;
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Date 1: ${controller.selectedDate1.value.toLocal()}".split(' ')[0]),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              );
            }),
            Obx(() {
              return InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate2.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    controller.selectedDate2.value = pickedDate;
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Date 2: ${controller.selectedDate2.value.toLocal()}".split(' ')[0]),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              );
            }),
            Obx(() {
              return InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate3.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    controller.selectedDate3.value = pickedDate;
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Date 3: ${controller.selectedDate3.value.toLocal()}".split(' ')[0]),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: MyApp(),
  ));
}