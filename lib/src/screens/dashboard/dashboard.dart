import 'package:dealsify_production/api/get/get_po_list.dart';
import 'package:dealsify_production/core/routs/routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/production_order_states.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final po = Get.put(PurchaseOrderController());
  final record = Get.put(PORecordCtrl());

  @override
  void initState() {
    super.initState();
    po.get();
  }

  @override
  void dispose() {
    super.dispose();
    po.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.toNamed(ConstRoute.poCreate);
          },
          elevation: 0,
          disabledElevation: 0,
          child: const Icon(Icons.add)
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text('Dashboard'),
              // background: Image.network(
              //   'https://via.placeholder.com/350x150',
              //   fit: BoxFit.cover,
              // ),
            ),
            backgroundColor: Colors.yellow,
          ),
          Obx(() {
            if (po.loading.value) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (po.items.isEmpty) {
              return const SliverFillRemaining(
                child: Center(child: Text("No purchase orders available.")),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: po.items.length, (context, index) {
                final item = po.items[index];
                return DashboardItemBox(
                  onTap: () {
                    record.saveRecord(item);
                    Get.toNamed(ConstRoute.poView);
                  },
                  itemName: item.customerId!.shortName,
                  itemDescription: item.customerId!.notes,
                  status: item.productionOrderStatus!.priority,
                );
              },
              ),
            );
          })
        ],
      ),
    );
  }
}

class DashboardItemBox extends StatelessWidget {
  final void Function()? onTap;
  final String? itemName;
  final String? itemDescription;
  final String? status;

  const DashboardItemBox({
    super.key,
    this.onTap,
    this.itemName,
    this.itemDescription,
    this.status,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case '1':
        return Colors.red;
      case '2':
        return Colors.yellow;
      case '3':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(4, 4),
            ),
          ],
          border: Border.all(
            width: 1.5,
            color: Colors.blueAccent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemName ?? 'Item Name',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              itemDescription ?? 'Description',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                    color: getStatusColor(status ?? ''),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      status ?? 'Status',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


