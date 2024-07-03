import 'package:flutter/material.dart';
import 'package:laundry_management_app/models/order.dart';
import 'package:laundry_management_app/services/api_service.dart';

class OrderFormScreen extends StatefulWidget {
  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _customerName = '';
  String _serviceType = 'Cuci Kering';
  String _deliveryType = 'Reguler';
  double _weight = 0.0;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Order order = Order(
        id: 0, // ID akan diatur oleh backend
        customerName: _customerName,
        serviceType: _serviceType,
        deliveryType: _deliveryType,
        weight: _weight,
        price: 0, // Harga akan dihitung oleh backend
        deliveryDays: 0, // Hari pengiriman akan dihitung oleh backend
      );

      try {
        await ApiService().createOrder(order);
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Pelanggan'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama pelanggan tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _customerName = value!;
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Layanan'),
                value: _serviceType,
                items: ['Cuci Kering', 'Cuci Setrika', 'Setrika']
                    .map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _serviceType = newValue!;
                  });
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Jenis Pengiriman'),
                value: _deliveryType,
                items: ['Reguler', 'Kilat', 'Super Kilat'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _deliveryType = newValue!;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Berat (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Berat harus berupa angka';
                  }
                  return null;
                },
                onSaved: (value) {
                  _weight = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Tambah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
