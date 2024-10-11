import 'package:dealsify_production/api/auth/login.dart';
import 'package:dealsify_production/api/get/get_po_list.dart';
import 'package:dealsify_production/core/routs/routs.dart';
import 'package:dealsify_production/core/services/extensions.dart';
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
                  customerName: item.customerId!.shortName,
                  no: item.productionOrderNo,
                  status: item.productionOrderStatus!.statusLabel,
                  statusColor: item.productionOrderStatus!.statusColor!.setColor(),
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
  final String? customerName;
  final String? status;
  final dynamic statusColor;
  final String? no;

  const DashboardItemBox({
    super.key,
    this.onTap,
    this.customerName,
    this.status,
    this.statusColor,
    this.no,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.5,color: Colors.black26),
          borderRadius: BorderRadius.circular(13)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    customerName ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.black87),
                    color: statusColor ?? Colors.transparent,
                  ),
                  child: Text(
                    status ?? '',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white
                    ),
                  ),
                ),
                ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "# ${no ?? ''}",
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black87
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
