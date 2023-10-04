import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:service/user_credientials/loginpage.dart';

class DocumentUploadPage extends StatefulWidget {
  @override
  _DocumentUploadPageState createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  // Define variables to store file paths for each document.
  String? panCardPath;
  String? aadharCardPath;
  String? lightBillPath;
  String? certificatePath;
  String? bankProofPath;
  String? educationCertificatePath;

  // Track whether all required documents are selected
  // bool _isFormValid = false;

  // // Function to validate the form
  // void _validateForm() {
  //   setState(() {
  //     _isFormValid =
  //         panCardPath != null &&
  //             aadharCardPath != null &&
  //             bankProofPath != null;
  //   });
  // }

  // Function to check authentication for starred fields
  bool _areStarredFieldsAuthenticated() {
    return panCardPath != null && aadharCardPath != null && bankProofPath != null;
  }

  Future<void> _selectDocument(String documentType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg'],
      );

      if (result != null) {
        setState(() {
          if (documentType == 'PAN Card*') {
            panCardPath = result.files.single.path;
          } else if (documentType == 'Certificate') {
            certificatePath = result.files.single.path;
          } else if (documentType == 'Aadhar Card*') {
            aadharCardPath = result.files.single.path;
          } else if (documentType == 'Bank Proof*') {
            bankProofPath = result.files.single.path;
          } else if (documentType == 'Light Bill') {
            lightBillPath = result.files.single.path;
          } else if (documentType == 'Education Certificate') {
            educationCertificatePath = result.files.single.path;
          }
          // After selecting a document, validate the form.
          // _validateForm();
        });
      } else {
        // User canceled the file picker.
        // After canceling, validate the form.
        // _validateForm();
      }
    } catch (e) {
      // Handle any errors that occur during the file picking process.
      print('Error picking a file: $e');
    }
  }

  void _onSubmitButtonPressed() {
    if (_areStarredFieldsAuthenticated()) {
      // Perform form submission here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your Documents Has Been Uploaded Successfully ."),
          duration: Duration(seconds: 3),
        ),
      );
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => LoginPage(),
      //   ),
      // );
      // You can access the selected file paths like panCardPath, aadharCardPath, etc.
    } else {
      // Display an error message if starred fields are not authenticated.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Upload All Required Documents."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // void _onSubmitButtonPressed() {
  //   if (_areStarredFieldsAuthenticated()) {
  //     // Perform form submission here
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => LoginPage()),
  //     );
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Error"),
  //           content: Text("Please Upload All Required Documents."),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text("OK"),
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 110,),

            // Code for Document Upload

            Text(
              'Document Upload',
              style: TextStyle(
                fontSize: 30,
                color: Colors.teal.shade300,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),

            // Code for List of Documents Display

            SizedBox(height: 20.0),
            _buildDocumentField('PAN Card*', panCardPath),
            _buildDocumentField('Aadhar Card*', aadharCardPath),
            _buildDocumentField('Light Bill', lightBillPath),
            _buildDocumentField('Certificate', certificatePath),
            _buildDocumentField('Bank Proof*', bankProofPath),
            _buildDocumentField('Education Certificate', educationCertificatePath),
            SizedBox(height: 20.0),

            // Code for Submit Button

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: _onSubmitButtonPressed,
                color: Colors.teal,
                textColor: Colors.white,
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // Helper function to build a document upload field.
  Widget _buildDocumentField(String documentType, String? filePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          documentType,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        // Code for To Display File Status

        Row(
          children: [
            Expanded(
              child: Text(filePath ?? 'No file selected'),
            ),
            ElevatedButton(
              onPressed: () {
                _selectDocument(documentType);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Set button background color to teal
                onPrimary: Colors.white, // Set text color to white
              ),
              child: Text('Select File'),
            ),
          ],
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
