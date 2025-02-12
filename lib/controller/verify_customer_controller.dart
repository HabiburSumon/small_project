// controllers/verify_customer_controller.dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:small_project/home/JobStart.dart';

import 'otp_service.dart';

class VerifyCustomerController {
  bool isAlternatePerson = false;
  bool isRequestSent = false;
  String mobileNumber = "";
  String otp = "";
  String generatedOTP = ""; // Store the OTP from the API response
  String customerName = "35454, Arif Hossain"; // Default customer name
  String alternateName = ""; // Alternate person name
  int _countdown = 120; // 2 minutes in seconds
  Timer? _timer;

  // Public getter for _countdown
  int get countdown => _countdown;

  final OTPService _otpService = OTPService(); // Create an instance of OTPService

  // Callback to notify the UI when the state changes
  VoidCallback? onStateChanged;

  // Method to send OTP
  Future<void> sendOTP(BuildContext context) async {
    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a mobile number"), backgroundColor: Colors.red),
      );
      return;
    }

    String nameToSend = isAlternatePerson ? alternateName : customerName;
    if (nameToSend.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a name"), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      String otpCode = await _otpService.sendOTP(mobileNumber, nameToSend); // Use the service
      generatedOTP = otpCode;
      isRequestSent = true;
      _countdown = 120; // Reset countdown to 2 minutes
      _startTimer(); // Start the countdown timer

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP has been sent"), backgroundColor: Colors.green),
      );

      // Notify the UI to rebuild
      onStateChanged?.call();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP: $e"), backgroundColor: Colors.red),
      );
    }
  }

  // Method to start the countdown timer
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
        // Notify the UI to rebuild
        onStateChanged?.call();
      } else {
        _timer?.cancel();
        isRequestSent = false; // Hide OTP field after countdown
        // Notify the UI to rebuild
        onStateChanged?.call();
      }
    });
  }

  // Method to verify OTP
  void verifyOTP(BuildContext context) {
    if (otp == generatedOTP) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => JobStart()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP"), backgroundColor: Colors.red),
      );
    }
  }

  // Method to dispose of the timer
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
  }
}