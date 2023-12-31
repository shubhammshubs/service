import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:service/user_credientials/user_documents_page.dart';
import 'package:http/http.dart' as http;
import 'package:service/Screens/Home_screen.dart';
import 'package:service/user_credientials/user_documents_page.dart';

class registerInfoPage extends StatefulWidget {
  final String mobileNumber;
  const registerInfoPage({super.key, required this.mobileNumber});

  @override
  _registerInfoPage createState() =>
      _registerInfoPage();
}

class _registerInfoPage extends State<registerInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> educations = [];
  String? selectedEducation;
  // We use string for user entered Inputs
  String? panNumber;
  String? aadharCardNumber;
  String? lastEducation;
  String? lastEducationYear;
  String? workExperience;
  String? bankName;
  String? bankAccountNumber;
  String? bankIFSCCode;



  // FocusNode instances for each of your input fields
  final FocusNode panNumberFocus = FocusNode();
  final FocusNode aadharCardNumberFocus = FocusNode();
  final FocusNode lastEducationFocus = FocusNode();
  final FocusNode lastEducationYearFocus = FocusNode();
  final FocusNode workExperienceFocus = FocusNode();
  final FocusNode bankNameFocus = FocusNode();
  final FocusNode bankAccountNumberFocus = FocusNode();
  final FocusNode bankIFSCCodeFocus = FocusNode();


  @override
  void initState() {
    super.initState();
    fetchEducationData();

    // Perform any initializations here if needed.
  }

  //  FOr drop Down List of Education
  Future<void> fetchEducationData() async {
    final response = await http.get(
      Uri.parse('https://apip.trifrnd.com/services/eng/sereng.php?apicall=readeducation'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<String> educationList = data
          .map((item) => item['Edu_Name'].toString())
          .toList();
      setState(() {
        educations = educationList;
      });
    } else {
      throw Exception('Failed to load education data');
    }
  }

  Future<void> registeUserInfo() async {
    // Construct the request body with user information
    // Format the date as "dd-MM-yyyy"
    // final formattedDate = DateFormat('dd-MM-yyyy').format(dateOfBirth ?? DateTime.now());

    // Add All Necessary  keys as given in API With the Values passed by user
    Map<String, dynamic> requestBody = {
      'mobile': widget.mobileNumber,
      'PAN_No': panNumber,
      'Aadhar_No': aadharCardNumber ?? '',
      'Last_Edu': selectedEducation ?? '',
      'Last_Edu_Year': lastEducationYear ?? '',
      'Work_Exp': workExperience ?? '',
      'Bank_Name': bankName ?? '',
      'Bank_Acc_No': bankAccountNumber ?? '',
      'Bank_IFSC': bankIFSCCode ?? '',

    };


    if (kDebugMode) {
      print('Request Body: $requestBody');
    }
    // Send the POST request to the API
    final response = await http.post(
      Uri.parse('https://apip.trifrnd.com/Services/eng/sereng.php?apicall=regist'),
      body: requestBody,
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('API response 0: ${response.statusCode}');
      }
      // Successful response from the API
      // You can handle the response here, e.g., show a success message
      if (kDebugMode) {
        print('API response we got: ${response.body}');
      }

      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      // void showMessageBox() {
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text("Message"),
      //         content: Text("${response.body} \n\n Go To Next Page"),
      //         actions: <Widget>[
      //           TextButton(
      //             child: Text("OK"),
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //               // Navigate to Step 2
      //               // _onStepTapped(1); // Assuming Step 2 is at index 1
      //             },
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // }
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            HomePage(mobileNumber: widget.mobileNumber,),),
            // DocumentUploadPage(mobileNumber: widget.mobileNumber,),),
      );
      // showMessageBox();
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => DocumentUploadPage(mobileNumber: widget.mobileNumber,),
      //   ),
      // );
    } else {
      // Error response from the API
      // Handle the error, e.g., show an error message
      if (kDebugMode) {
        print('API error: ${response.statusCode}, ${response.body}');
      }
    }

  }




  // Once user goes to next cell previous cell will Close
  @override
  void dispose() {
    panNumberFocus.dispose();
    aadharCardNumberFocus.dispose();
    lastEducationFocus.dispose();
    lastEducationYearFocus.dispose();
    workExperienceFocus.dispose();
    bankNameFocus.dispose();
    bankAccountNumberFocus.dispose();
    bankIFSCCodeFocus.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.symmetric(vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Text(
                  'Registration Information ',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.teal.shade300,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text("Hello User, Mobile Number: ${widget.mobileNumber}"),

                const SizedBox(height: 30),

                // Code for Entering Pan Number

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next, // Set the action
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'PAN Number*',
                      hintText: 'Enter PAN Number',
                      prefixIcon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      panNumber = value?.toUpperCase();
                    },
                    validator: (value) {
                      final RegExp panRegex = RegExp(r'^[A-Za-z]{5}[0-9]{4}[A-Za-z]{1}$');

                      if (value!.isEmpty ) {
                        return 'Please enter PAN Number';
                      }else  if (!panRegex.hasMatch(value)) {
                        return 'Invalid PAN Number format';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),
                // Code for Entering Aadhar Card Number
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Aadhar Card Number*',
                      hintText: 'Enter Aadhar Card Number',
                      prefixIcon: Icon(FontAwesomeIcons.solidAddressCard),

                      border: OutlineInputBorder(),

                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12)
                    ],
                    onSaved: (value) {
                      aadharCardNumber = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Please enter Aadhar Card Number';
                      }else if (value.length != 12) {
                        return 'Aadhar Card Number must be 12 digits';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Last Education

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: DropdownButtonFormField<String?>(
                    value: selectedEducation,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEducation = newValue;
                      });
                    },
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Select Education'),
                      ),
                      ...educations
                          .map((education) => DropdownMenuItem<String>(
                        value: education,
                        child: Text(education),
                      ))
                          .toList(),
                      // ..sort((a, b) => a.child.toString().compareTo(b.child.toString())),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Education',
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an education';
                      }
                      return null;
                    },
                    // onChanged: (newValue) {
                    //   // Handle state change here
                    // },
                  ),
                ),

                const SizedBox(height: 25),

                // Code for Entering Last Education Year

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30,),
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     textInputAction: TextInputAction.next, // Set the action
                //     decoration: const InputDecoration(
                //       labelText: 'Last Education Year*',
                //       hintText: 'Enter Last Education Year',
                //       prefixIcon: Icon(FontAwesomeIcons.calendarCheck),
                //
                //       border: OutlineInputBorder(),
                //     ),
                //     onSaved: (value) {
                //       lastEducationYear = value;
                //     },
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Please enter Last Education Year';
                //       }
                //       return null;
                //     },
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Last Education Year*',
                      prefixIcon: Icon(FontAwesomeIcons.calendarCheck),
                      border: OutlineInputBorder(),
                    ),
                    value: lastEducationYear,
                    onChanged: (String? newValue) {
                      setState(() {
                        lastEducationYear = newValue;
                      });
                    },
                    items: List<String>.generate(
                      DateTime.now().year - 1969, (index) => (1970 + index).toString(),
                    )
                    .reversed
                        .map((year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Last Education Year';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // Code for Entering Work Experience

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Work Experience*',
                      hintText: 'Enter Work Experience in Year',
                      prefixIcon: Icon(FontAwesomeIcons.briefcase),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      workExperience = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Work Experience';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Bank Name

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Bank Name*',
                      hintText: 'Enter Bank Name',
                      prefixIcon: Icon(FontAwesomeIcons.buildingColumns),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      bankName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Bank Name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Bank Account Number

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Bank Account Number*',
                      hintText: 'Enter Bank Account Number',
                      prefixIcon: Icon(Icons.account_balance_wallet),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      bankAccountNumber = value;
                    },
                    validator: (value) {
                      final RegExp bankAcRegex = RegExp(r'^[0-9]{9,18}$');

                      if (value!.isEmpty) {
                        return 'Please enter Bank Account Number';
                      } else  if (!bankAcRegex.hasMatch(value)) {
                        return 'Invalid Bank Account Number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Bank IFSC Code

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next, // Set the action
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Bank IFSC Code*',
                      hintText: 'Enter Bank IFSC Code',
                      prefixIcon: Icon(Icons.share_location_outlined),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      bankIFSCCode = value;
                    },
                    validator: (value) {
                      final RegExp IFSCRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

                      if (value!.isEmpty) {
                        return 'Please enter Bank IFSC Code';
                      }
                      else  if (!IFSCRegex.hasMatch(value)) {
                        return 'Invalid IFSC Number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Submit Button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        registeUserInfo();
                        // Perform form submission here
                        // You can access the form field values like firstName, lastName, etc.
                      }
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => DocumentUploadPage(),
                      //   ),
                      // );
                    },
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: const Text('Submit',
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

