import 'package:dealsify_production/api/auth/login.dart';
import 'package:dealsify_production/api/get/get_po_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final po = Get.put(PurchaseOrderController());

  @override
  void initState() {
    super.initState();
    po.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Dashboard'),
              background: Image.network(
                'https://via.placeholder.com/350x150',
                fit: BoxFit.cover,
              ),
            ),
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
                childCount: po.items.length, (BuildContext context, int index) {
                  final item = po.items[index];
                  return ListTile(
                    leading: const Icon(Icons.inventory),
                    title: Text(item.customerId!.customerName ?? ''),
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