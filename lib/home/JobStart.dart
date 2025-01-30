import 'package:flutter/material.dart';

class JobStart extends StatelessWidget {
  const JobStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Start"),
        centerTitle: true,
      ),
      body: Center(

          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2, // Smaller image size
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage('https://1000fix.com/wp-content/uploads/2024/11/Color-2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  }
}
