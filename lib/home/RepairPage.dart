import 'package:flutter/material.dart';

class RepairPage extends StatefulWidget {
  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  bool isPartsRequired = true; // Set this to true or false based on your logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repair Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Repair Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Is parts required for the repair?',
              style: TextStyle(fontSize: 18),
            ),
            Switch(
              value: isPartsRequired,
              onChanged: (value) {
                setState(() {
                  isPartsRequired = value;
                });
              },
            ),
            SizedBox(height: 20),
            if (isPartsRequired) ...[
              Text(
                'Select Service Type:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ServiceOption(
                title: 'Home Service',
                description: 'Our technician will come to your location.',
                onTap: () {
                  // Handle Home Service selection
                  print('Home Service Selected');
                },
              ),
              SizedBox(height: 10),
              ServiceOption(
                title: 'Pickup & Delivery',
                description: 'We will pick up and deliver your device.',
                onTap: () {
                  // Handle Pickup & Delivery selection
                  print('Pickup & Delivery Selected');
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ServiceOption extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  ServiceOption({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}