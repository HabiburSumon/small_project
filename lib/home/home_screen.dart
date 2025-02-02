import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Import for Timer
import 'package:small_project/home/JobStart.dart';

class VerifyCustomer extends StatefulWidget {
  const VerifyCustomer({super.key});

  @override
  _VerifyCustomerState createState() => _VerifyCustomerState();
}

class _VerifyCustomerState extends State<VerifyCustomer> {
  bool isAlternatePerson = false;
  bool isRequestSent = false;
  String mobileNumber = "";
  String otp = "";
  String generatedOTP = ""; // Store the OTP from the API response
  String customerName = "35454, Arif Hossain"; // Default customer name
  String alternateName = ""; // Alternate person name
  final String apiKey = "KsNp0AcYqTNzTxCpoVA6"; // Your API key
  final String senderId = "8809617611744"; // Your sender ID
  int _countdown = 120; // 2 minutes in seconds
  Timer? _timer;
  Future<void> sendOTP() async {
    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a mobile number") ,backgroundColor: Colors.red,),
      );
      return;
    }
    String nameToSend = isAlternatePerson ? alternateName : customerName;
    if (nameToSend.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a name"),backgroundColor: Colors.red),
      );
      return;
    }
    String otpCode = (1000 + (9999 - 1000) * (DateTime.now().millisecondsSinceEpoch % 10000) / 9999).toInt().toString();
    setState(() {
      generatedOTP = otpCode;
      isRequestSent = true;
      _countdown = 60; // Reset countdown to 2 minutes
    });
    _startTimer(); // Start the countdown timer

    String message = "Dear $nameToSend, Your OTP for Verification is $otpCode";
    String url = "http://bulksmsbd.net/api/smsapi?api_key=$apiKey&type=text&number=$mobileNumber&senderid=$senderId&message=$message";

    try {
      var response = await http.get(Uri.parse(url));
      var responseData = json.decode(response.body);

      if (responseData["success_message"] == "SMS Submitted Successfully 1") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP has been sent"),backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP"),backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"),backgroundColor: Colors.red),
      );
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          isRequestSent = false; // Hide OTP field after countdown
        });
      }
    });
  }

  void verifyOTP() {
    if (otp == generatedOTP) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => JobStart()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP"),backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
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
                    value: isAlternatePerson,
                    onChanged: (value) => setState(() => isAlternatePerson = value),
                  ),
                ],
              ),
              if (isAlternatePerson) ...[
                SizedBox(height: 15),
                Text('Alternate Name', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  onChanged: (value) => alternateName = value,
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
                    hintText: customerName,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
              SizedBox(height: 15),
              Text('Mobile No', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) => mobileNumber = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Mobile No',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              SizedBox(height: 20),
              if (!isRequestSent) ...[
                Center(
                  child: ElevatedButton(
                    onPressed: sendOTP,
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
                  onChanged: (value) => otp = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter OTP',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Time remaining: $_countdown seconds',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: verifyOTP,
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