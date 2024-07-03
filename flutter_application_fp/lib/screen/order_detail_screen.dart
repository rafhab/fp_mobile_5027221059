import 'package:flutter/material.dart';
import 'package:laundry_management_app/models/order.dart';
import 'package:laundry_management_app/services/api_service.dart';
import 'order_form_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  OrderDetailScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderFormScreen(order: order),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await ApiService().deleteOrder(order.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Pelanggan: ${order.customerName}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Layanan: ${order.serviceType}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Jenis Pengiriman: ${order.deliveryType}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Berat: ${order.weight} kg', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Harga: Rp ${order.price}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Hari Pengiriman: ${order.deliveryDays} hari',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
