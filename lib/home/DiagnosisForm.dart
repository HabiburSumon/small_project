import 'package:flutter/material.dart';

class DiagnosisForm extends StatefulWidget {
  @override
  _DiagnosisFormState createState() => _DiagnosisFormState();
}

class _DiagnosisFormState extends State<DiagnosisForm> {
  List<String> symptoms = ['Symptom 1', 'Symptom 2',]; // Static API Data
  List<String> solutionTypes = ['Solution 1', 'Solution 2']; // Static API Data
  List<String> parts = ['Part 1', 'Part 2', 'Part 3']; // Static API Data for parts
  String serviceCharge = '\$100'; // Static API Data

  List<String> selectedSymptoms = [];
  List<String> selectedSolutions = [];
  String? selectedPart;
  TextEditingController engineerObservationController = TextEditingController();
  TextEditingController facultyTagController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController failedReasonController = TextEditingController();

  bool isPartsRequired = false;
  bool isCustomerAgree = false;
  String diagnosisStatus = 'Success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade100,
      appBar: AppBar(
          backgroundColor: Colors.indigo.shade100,
          title: Text('Diagnosis Form')),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Symptoms:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Wrap(
                    children: symptoms.map((symptom) {
                      return CheckboxListTile(
                        title: Text(symptom),
                        value: selectedSymptoms.contains(symptom),
                        onChanged: (value) {
                          setState(() {
                            value!
                                ? selectedSymptoms.add(symptom)
                                : selectedSymptoms.remove(symptom);
                          });
                        },
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 16),
                  Text('Solution Type:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Wrap(
                    children: solutionTypes.map((solution) {
                      return CheckboxListTile(
                        title: Text(solution),
                        value: selectedSolutions.contains(solution),
                        onChanged: (value) {
                          setState(() {
                            value!
                                ? selectedSolutions.add(solution)
                                : selectedSolutions.remove(solution);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Text('Learner ID:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8), // Reduced spacing for better alignment
                  Row(
                    children: [
                      Text(
                        '33333',
                        style: TextStyle(fontSize: 15, color: Colors.black87), // Added color for better readability
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Text('Engineer Observation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextField(
                    controller: engineerObservationController,
                    decoration: InputDecoration(
                      hintText: 'Checked system',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Faculty Tag', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextField(
                    controller: facultyTagController,
                    decoration: InputDecoration(
                      hintText: 'Engineering',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Remarks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextField(
                    controller: remarksController,
                    decoration: InputDecoration(
                      hintText: 'No issues found',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 16),
                  SwitchListTile(
                    title: Text('Is Parts Required?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    value: isPartsRequired,
                    onChanged: (value) {
                      setState(() {
                        isPartsRequired = value;
                      });
                    },
                  ),

                  if (isPartsRequired)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedPart,
                          decoration: InputDecoration(labelText: 'Select Part'),
                          items: parts.map((part) {
                            return DropdownMenuItem(
                              value: part,
                              child: Text(part),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPart = value;
                            });
                          },
                        ),
                      ],
                    ),

                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: diagnosisStatus,

                    decoration: InputDecoration(labelText: 'Diagnosis Status'),
                    items: ['Success', 'Failed'].map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        diagnosisStatus = value!;
                      });
                    },
                  ),

                  if (diagnosisStatus == 'Failed')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                         Text('Failed Reason', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        TextField(
                          controller: failedReasonController,
                          decoration: InputDecoration(
                            hintText: 'Failed reason',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),

                  SizedBox(height: 16),
                  SwitchListTile(
                    title: Text('Is Customer Agree?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    value: isCustomerAgree,
                    onChanged: (value) {
                      setState(() {
                        isCustomerAgree = value;
                      });
                    },
                  ),

                  SizedBox(height: 16),
                  Text('Service Charge: $serviceCharge', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade400, foregroundColor: Colors.white),
                      onPressed: () {
                        // Handle form submission
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}