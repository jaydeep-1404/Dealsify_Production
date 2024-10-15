import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/get/get_po_list.dart';
import '../../Drawer/drawer.dart';
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
    // po.clear();
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
                        return PurchaseOrderCard(
                          onTap: (){
                            record.saveRecord(item);
                            navigateToPage(context, const OrderDetailScreen());
                            },
                          orderNo: item.productionOrderNo,
                          customer: item.customerId!.shortName,
                          // status: item.productionOrderStatus!.priority,
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
      case '1':
        return Colors.green;
      case '2':
        return Colors.red;
      case '3':
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