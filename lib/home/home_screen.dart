import 'package:flutter/material.dart';

import '../controller/verify_customer_controller.dart';

class VerifyCustomer extends StatefulWidget {
  const VerifyCustomer({super.key});

  @override
  _VerifyCustomerState createState() => _VerifyCustomerState();
}

class _VerifyCustomerState extends State<VerifyCustomer> {
  final VerifyCustomerController _controller = VerifyCustomerController();

  @override
  void initState() {
    super.initState();
    // Listen for state changes in the controller
    _controller.onStateChanged = _updateState;
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the timer
    super.dispose();
  }

  // Method to update the UI when the state changes
  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Text(
                'Customer Verification',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Alternate Person?', style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Switch(
                    value: _controller.isAlternatePerson,
                    onChanged: (value) {
                      setState(() {
                        _controller.isAlternatePerson = value;
                      });
                    },
                  ),
                ],
              ),
              if (_controller.isAlternatePerson) ...[
                SizedBox(height: 15),
                Text('Alternate Name', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  onChanged: (value) => _controller.alternateName = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Alternate Name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ] else ...[
                SizedBox(height: 15),
                Text('Customer Name', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: _controller.customerName,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
              SizedBox(height: 15),
              Text('Mobile No', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) => _controller.mobileNumber = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Mobile No',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              SizedBox(height: 20),
              if (!_controller.isRequestSent) ...[
                Center(
                  child: ElevatedButton(
                    onPressed: () => _controller.sendOTP(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('Send Request'),
                  ),
                ),
              ] else ...[
                SizedBox(height: 20),
                Text('OTP', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _controller.otp = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter OTP',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Time remaining: ${_controller.countdown} seconds', // Use the getter
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _controller.verifyOTP(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('Authorize'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
