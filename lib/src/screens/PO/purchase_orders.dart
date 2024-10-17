import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/Models/bomItems.dart';
import '../../../api/get/get_po_list.dart';
import '../../Drawer/drawer.dart';
import '../../common_functions/animations.dart';
import '../../state_controllers/production_order_states.dart';
import '../../state_controllers/stage_controller.dart';
import 'po_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final po = Get.put(PurchaseOrderController());
  final record = Get.put(PORecordCtrl());
  final stageController = Get.put(StageController());

  final searchCtrl = TextEditingController();

  int _selectedIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    po.get();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Dashboard',style: TextStyle(fontWeight: FontWeight.bold),),
          ],),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5,),
              child: TextField(
                onChanged: (value){
                  if (_timer?.isActive ?? false) _timer?.cancel();
                  _timer = Timer(const Duration(milliseconds: 1000), () {
                    if(value.toString().trim().isNotEmpty){
                      FocusManager.instance.primaryFocus?.unfocus();
                      po.get(searchValue: value.toString());
                    } else {
                      FocusManager.instance.primaryFocus?.unfocus();
                      po.get();
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.teal),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.teal),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Obx(() {
                if (po.loading.value) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }

                if (po.items.isEmpty) {
                  return const Expanded(child: Center(child: Text("No purchase orders available.")));
                }

                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2));
                      po.get();
                    },
                    child: ListView.builder(
                      itemCount: po.items.length,
                      itemBuilder: (context, index) {
                        final item = po.items[index];
                        final stage = item.items!.findFirstIncompleteStage();
                        return ProductionOrderBox(
                          onTap: () {
                            if (item.items!.incompleteStages().isNotEmpty){
                              record.saveRecord(item);
                              record.saveStage(stage);
                              if (item.items!.getAllBomItems().isEmpty){
                                BomItems i = BomItems(
                                  materialId: item.items!.id,
                                  categoryId: item.items!.categoryId,
                                  materialName: item.items!.itemName,
                                  quantity: item.items!.qty,
                                );
                                record.saveBomItems([i]);
                              } else {
                                record.saveBomItems(item.items!.getAllBomItems());
                              }

                              stageController.setStartDateTime(
                                stage.startingDate?.toString() ?? '',
                                stage.startingTime?.toString() ?? '',
                              );

                              stageController.setEndDateTime(
                                stage.endingDate?.toString() ?? '',
                                stage.endingTime?.toString() ?? '',
                              );
                              navigateToPage(context, const ProductionOrderView());
                            }
                          },
                          orderNo: item.productionOrderNo.toString(),
                          itemName: item.items!.itemName.toString(),
                          priority: item.productionPriorityLevel.toString(),
                          currentStage: stage!.label?.toString() ?? "",
                        );
                      },
                    ),
                  ),
                );
              },),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              switch (index) {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  break;
              }
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Settings'),
          ],
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.teal,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}


class ProductionOrderBox extends StatelessWidget {
  final String orderNo;
  final String itemName;
  final String currentStage;
  final String priority;
  final void Function()? onTap;

  const ProductionOrderBox({
    Key? key,
    required this.orderNo,
    required this.itemName,
    required this.currentStage,
    required this.priority,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildCompactInfoRow(
                  icon: Icons.numbers,
                  label: orderNo,
                  iconColor: Colors.blue.shade300,
                ),
                const Spacer(),
                _buildCompactInfoRow(
                  // icon: Icons.widgets,
                  label: itemName,
                  iconColor: Colors.orange.shade300,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // if(currentStage.isNotEmpty)
                _buildCompactInfoRow(
                  icon: currentStage.isNotEmpty ? Icons.assignment : Icons.check_circle,
                  label: currentStage.isNotEmpty ? currentStage : "All stages completed",
                  iconColor: Colors.green.shade300,
                ),
                const Spacer(),
                _buildCompactInfoRow(
                  icon: Icons.warning_amber_rounded,
                  label: _getPriorityLabel(priority),
                  iconColor: _getPriorityColor(priority),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactInfoRow({
    IconData? icon,
    String? label,
    Color? iconColor,
  }) {
    return Row(
      children: [
        if (icon != null)Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 6),
        Text(
          label!,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case '100':
        return Colors.red.shade300;
      case '50':
        return Colors.orange.shade300;
      case '20':
        return Colors.green.shade300;
      default:
        return Colors.black54;
    }
  }

  String _getPriorityLabel(String priority) {
    switch (priority.toLowerCase()) {
      case '100':
        return "High";
      case '50':
        return "Medium";
      case '20':
        return "Low";
      default:
        return "";
    }
  }
}