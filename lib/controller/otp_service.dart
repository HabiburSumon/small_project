// services/otp_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPService {
  final String apiKey = "KsNp0AcYqTNzTxCpoVA6"; // Your API key
  final String senderId = "8809617611744"; // Your sender ID

  Future<String> sendOTP(String mobileNumber, String nameToSend) async {
    String otpCode = (1000 + (9999 - 1000) * (DateTime.now().millisecondsSinceEpoch % 10000) / 9999).toInt().toString();
    String message = "Dear $nameToSend, Your OTP for Verification is $otpCode";
    String url = "http://bulksmsbd.net/api/smsapi?api_key=$apiKey&type=text&number=$mobileNumber&senderid=$senderId&message=$message";

    try {
      var response = await http.get(Uri.parse(url));
      var responseData = json.decode(response.body);

      if (responseData["success_message"] == "SMS Submitted Successfully 1") {
        return otpCode; // Return the generated OTP
      } else {
        throw Exception("Failed to send OTP");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}