/*
import 'package:dealsify_production/api/get/get_po_list.dart';
import 'package:dealsify_production/core/routs/routs.dart';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:dealsify_production/src/screens/PO/add_po.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_functions/animations.dart';
import '../../state_controllers/production_order_states.dart';
import '../PO/po_view.dart';

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
            navigateToPage(context, const CreatePurchaseOrder());
          },
          elevation: 0,
          disabledElevation: 0,
          child: const Icon(Icons.add)
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const Stack(),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Dashboard'),
              // background: Image.network(
              //   'https://via.placeholder.com/350x150',
              //   fit: BoxFit.cover,
              // ),
            ),
            backgroundColor: Colors.blueGrey[300],
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
                    navigateToPage(context, const POItemsPage());
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.black45),
                    color: statusColor ?? Colors.transparent,
                  ),
                  child: Text(
                    status ?? '',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
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
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/get/get_po_list.dart';
import '../../common_functions/animations.dart';
import '../../state_controllers/production_order_states.dart';
import '../PO/po_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final po = Get.put(PurchaseOrderController());
  final record = Get.put(PORecordCtrl());
  int _selectedIndex = 0;

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5,),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Purchase Orders...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.teal),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.teal),
                ),
                onChanged: (value) {},
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  child: ListView.builder(
                    itemCount: po.items.length,
                    itemBuilder: (context, index) {
                      final item = po.items[index];
                      return PurchaseOrderCard(
                        onTap: (){
                          record.saveRecord(item);
                          navigateToPage(context, const OrderDetailScreen());
                          },
                        orderNo: item.productionOrderNo,
                        customer: item.customerId!.shortName,
                      );
                    },
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                  break;
              }
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // Added Profile item
          ],
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.teal,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class PurchaseOrderCard extends StatelessWidget {
  final orderNo;
  final status;
  final customer;
  final orderDate;
  final dispatchDate;
  final onTap;

  const PurchaseOrderCard({Key? key, this.orderNo, this.status, this.customer, this.orderDate, this.dispatchDate, this.onTap, }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.red;
      case 'In Progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String convertDateFormat(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Customer: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: customer ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Order Number: ${orderNo ?? ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (status.toString().isNotEmpty && status != null)...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status ?? ""),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ]
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     // const SizedBox(height: 2),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Order Date: ${convertDateFormat(orderDate) ?? ""}',
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //         ),
              //         Text(
              //           'Dispatch Date: ${convertDateFormat(dispatchDate) ?? ""}',
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}