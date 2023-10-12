// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
//
// import 'info_form_2_register.dart';
//
//
//
// // import 'info_form_2_register.dart';
//
// class UserInfoPage extends StatefulWidget {
//   final String mobileNumber;
//   const UserInfoPage({super.key, required this.mobileNumber});
//
//   @override
//   _UserInfoPageState createState() => _UserInfoPageState();
// }
//
// class _UserInfoPageState extends State<UserInfoPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController dateController = TextEditingController(text: '');
//
//   // We use string for user entered Inputs
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   DateTime? dateOfBirth;
//   String? address;
//   String? state;
//   String? district;
//   String? city;
//   String? pinCode;
//   String? country;
//
//   // FocusNode instances for each of your input fields
//   final FocusNode firstNameFocus = FocusNode();
//   final FocusNode middleNameFocus = FocusNode();
//   final FocusNode lastNameFocus = FocusNode();
//   final FocusNode dateOfBirthFocus = FocusNode();
//   final FocusNode addressFocus = FocusNode();
//   final FocusNode stateFocus = FocusNode();
//   final FocusNode districtFocus = FocusNode();
//   final FocusNode cityFocus = FocusNode();
//   final FocusNode pinCodeFocus = FocusNode();
//   final FocusNode countryFocus = FocusNode();
//
//   //  API to insert users info to Database
//   Future<void> submitUserInfo() async {
//     // Construct the request body with user information
//     // Format the date as "dd-MM-yyyy"
//     final formattedDate = DateFormat('dd-MM-yyyy').format(dateOfBirth ?? DateTime.now());
//
//     // Add All Necessary  keys as given in API With the Values passed by user
//     Map<String, dynamic> requestBody = {
//       'mobile': widget.mobileNumber,
//       'FName': firstName ?? '',
//       'MName': middleName ?? '',
//       'LName': lastName ?? '',
//       'DoB': formattedDate, // Use the formatted date
//       'Address': address ?? '',
//       'City': city ?? '',
//       'State': state ?? '',
//       'Pincode': pinCode ?? '',
//     };
//
//     // Optional fields (if applicable)
//     // if (country != null) {
//     //   requestBody['Country'] = country;
//     // }
//     // Print the request body for debugging
//     if (kDebugMode) {
//       print('Request Body: $requestBody');
//     }
//     // Send the POST request to the API
//     final response = await http.post(
//       Uri.parse('https://apip.trifrnd.com/Services/eng/sereng.php?apicall=engreg'),
//       body: requestBody,
//     );
//
//     if (response.statusCode == 200) {
//       if (kDebugMode) {
//         print('API response 0: ${response.statusCode}');
//       }
//       // Successful response from the API
//       // You can handle the response here, e.g., show a success message
//       if (kDebugMode) {
//         print('API response we got: ${response.body}');
//       }
//
//       Fluttertoast.showToast(
//         msg: response.body,
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => registerInfoPage(mobileNumber: widget.mobileNumber,),
//         ),
//       );
//     }
//     else {
//       // Error response from the API
//       // Handle the error, e.g., show an error message
//       if (kDebugMode) {
//         print('API error: ${response.statusCode}, ${response.body}');
//       }
//     }
//
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     // Perform any initializations here if needed.
//   }
//
//   // Once user goes to next cell previous cell will Close
//   @override
//   void dispose() {
//     firstNameFocus.dispose();
//     middleNameFocus.dispose();
//     lastNameFocus.dispose();
//     dateOfBirthFocus.dispose();
//     addressFocus.dispose();
//     stateFocus.dispose();
//     districtFocus.dispose();
//     cityFocus.dispose();
//     pinCodeFocus.dispose();
//     countryFocus.dispose();
//     super.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       // MaterialApp(
//       // home:
//     Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // const SizedBox(height: 120,),
//               Text(
//                 'Personal Information',
//                 style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.teal.shade300,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//               Text("Hello User, Mobile Number: ${widget.mobileNumber}"),
//
//               Padding(
//                 padding:  const EdgeInsets.symmetric(vertical: 30),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//
//                       // Code for Entering First Name
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30,),
//                         child: TextFormField(
//                           // controller: _nameController,
//                           keyboardType: TextInputType.name,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'First Name*',
//                             hintText: 'Enter Name',
//                             prefixIcon: Icon(Icons.person),
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) {
//                             firstName = value;
//                           },
//                           onChanged: (String value){
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter your Name';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//
//                       // Code for Entering Middle Name
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           // controller: _nameController,
//                           keyboardType: TextInputType.name,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'Middle Name*',
//                             hintText: 'Enter Middle Name',
//                             prefixIcon: Icon(Icons.person),
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) {
//                             middleName = value;
//                           },
//                           onChanged: (String value){
//                           },
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter your Middle Name';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           // controller: _nameController,
//                           keyboardType: TextInputType.name,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'Last Name*',
//                             hintText: 'Enter Last Name',
//                             prefixIcon: Icon(Icons.person),
//                             border: OutlineInputBorder(),
//                           ),
//                           onSaved: (value) {
//                             lastName = value;
//                           },
//                           onChanged: (String value){
//                           },
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter your Last Name';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//
//
//                       // Code for Date of Birth
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           controller: dateController, // Use the _dateController here
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'Date of Birth*',
//                             hintText: 'Select Date of Birth',
//                             prefixIcon: Icon(Icons.date_range),
//                             border: OutlineInputBorder(),
//                           ),
//                           onTap: () async {
//                             final selectedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime.now(),
//                             );
//
//                             if (selectedDate != null) {
//                               final formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate); // Format the date
//                               setState(() {
//                                 dateOfBirth = selectedDate;
//                                 dateController.text = formattedDate; // Set the formatted date in the text field
//                               });
//                             }
//                           },
//
//
//                           readOnly: true,
//                           validator: (value) {
//                             if (dateOfBirth == null) {
//                               return 'Please select your date of birth';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//
//
//                       const SizedBox(height: 25,),
//
//                       // Code for Entering Address
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           // controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'Address*',
//                             hintText: 'Enter Address',
//                             prefixIcon: Icon(Icons.home),
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (String value){
//
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your address';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             address = value;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//
//                       // Code for Entering State
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           // controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'State*',
//                             hintText: 'Enter State',
//                             prefixIcon: Icon(FontAwesomeIcons.mapLocationDot),
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (String value){
//
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your state';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             state = value;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//
//                       // Code for Entering District
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           // controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'District*',
//                             hintText: 'Enter District',
//                             prefixIcon: Icon(Icons.location_pin),
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (String value){
//
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your district';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             district = value;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//
//                       // Code for Entering City
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           // controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'City*',
//                             hintText: 'Enter City',
//                             prefixIcon: Icon(Icons.location_city),
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (String value){
//
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your city';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             city = value;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//
//                       // Code for Entering Pin Code
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           // controller: _mobileController,
//                           keyboardType: TextInputType.number,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'Pin Code*',
//                             hintText: 'Enter Pin Code',
//                             prefixIcon: Icon(FontAwesomeIcons.mapPin),
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (String value){
//
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your pin code';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             pinCode = value;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//
//                       // Code for Entering Country
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           // controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           textInputAction: TextInputAction.next, // Set the action
//                           decoration: const InputDecoration(
//                             labelText: 'Country*',
//                             hintText: 'Enter Country',
//                             prefixIcon: Icon(FontAwesomeIcons.earthAsia),
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (String value){
//
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your country';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             country = value;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//
//                       // Code for Submit Button
//
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 35),
//                         child: MaterialButton(
//                           minWidth: double.infinity,
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               _formKey.currentState!.save();
//                               // called the API Function here
//                               submitUserInfo(); // Call the function to submit user information
//
//                             }
//                           },
//                           color: Colors.teal,
//                           textColor: Colors.white,
//                           child: const Text(
//                             'Submit ',
//                             style: TextStyle(
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20,),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     // );
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'info_form_2_register.dart';



// import 'info_form_2_register.dart';

class UserInfoPage extends StatefulWidget {
  final String mobileNumber;
  const UserInfoPage({super.key, required this.mobileNumber});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController(text: '');

  // We use string for user entered Inputs
  String? firstName;
  String? middleName;
  String? lastName;
  DateTime? dateOfBirth;
  String? address;
  String? state;
  String? district;
  String? city;
  String? pinCode;
  String? country;

  // FocusNode instances for each of your input fields
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode middleNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode dateOfBirthFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode districtFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode pinCodeFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();


  // In StepperPage
  // void showMessageBox() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Message"),
  //         content: Text("User Register Successfully. \n\n Go To Next Page"),
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

  //  API to insert users info to Database
  Future<void> submitUserInfo() async {
    // Construct the request body with user information
    // Format the date as "dd-MM-yyyy"
    final formattedDate = DateFormat('yyyy-dd-MM').format(dateOfBirth ?? DateTime.now());

    // Add All Necessary  keys as given in API With the Values passed by user
    Map<String, dynamic> requestBody = {
      'mobile': widget.mobileNumber,
      'FName': firstName ?? '',
      'MName': middleName ?? '',
      'LName': lastName ?? '',
      'DoB': formattedDate, // Use the formatted date
      'Address': address ?? '',
      'City': city ?? '',
      'State': state ?? '',
      'District': district ?? '',
      'Pincode': pinCode ?? '',
    };

    // Optional fields (if applicable)
    // if (country != null) {
    //   requestBody['Country'] = country;
    // }
    // Print the request body for debugging
    if (kDebugMode) {
      print('Request Body: $requestBody');
    }
    // Send the POST request to the API
    final response = await http.post(
      Uri.parse('https://apip.trifrnd.com/Services/eng/sereng.php?apicall=engreg'),
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
      void showMessageBox() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Message"),
              content: Text("${response.body} \n\n Go To Next Page"),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to Step 2
                    // _onStepTapped(1); // Assuming Step 2 is at index 1
                  },
                ),
              ],
            );
          },
        );
      }

      showMessageBox();
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => registerInfoPage(mobileNumber: widget.mobileNumber,),
      //   ),
      // );
    }
    else {
      // Error response from the API
      // Handle the error, e.g., show an error message
      if (kDebugMode) {
        print('API error: ${response.statusCode}, ${response.body}');
      }
    }

  }


  @override
  void initState() {
    super.initState();
    // Perform any initializations here if needed.
  }

  // Once user goes to next cell previous cell will Close
  @override
  void dispose() {
    firstNameFocus.dispose();
    middleNameFocus.dispose();
    lastNameFocus.dispose();
    dateOfBirthFocus.dispose();
    addressFocus.dispose();
    stateFocus.dispose();
    districtFocus.dispose();
    cityFocus.dispose();
    pinCodeFocus.dispose();
    countryFocus.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.symmetric(vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 110,),
                Text(
                  'Personal Information',
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
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'First Name*',
                      hintText: 'Enter Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      firstName = value;
                    },
                    onChanged: (String value){
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),
                // Code for Entering Aadhar Card Number
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Middle Name*',
                      hintText: 'Enter Middle Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      middleName = value;
                    },
                    onChanged: (String value){
                    },

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Middle Name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Last Education

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Last Name*',
                      hintText: 'Enter Last Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      lastName = value;
                    },
                    onChanged: (String value){
                    },

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Last Name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Last Education Year

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: dateController, // Use the _dateController here
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth*',
                      hintText: 'Select Date of Birth',
                      prefixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (selectedDate != null) {
                        final formattedDate = DateFormat('yyyy-dd-MM').format(selectedDate); // Format the date
                        setState(() {
                          dateOfBirth = selectedDate;
                          dateController.text = formattedDate; // Set the formatted date in the text field
                        });
                      }
                    },


                    readOnly: true,

                    validator: (value) {
                      if (dateOfBirth == null) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Work Experience

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Address*',
                      hintText: 'Enter Address',
                      prefixIcon: Icon(Icons.home),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      address = value;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Bank Name

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'State*',
                      hintText: 'Enter State',
                      prefixIcon: Icon(FontAwesomeIcons.mapLocationDot),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your state';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      state = value;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Bank Account Number

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'District*',
                      hintText: 'Enter District',
                      prefixIcon: Icon(Icons.location_pin),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your district';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      district = value;
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Code for Entering Bank IFSC Code

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'City*',
                      hintText: 'Enter City',
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      city = value;
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    // controller: _mobileController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Pin Code*',
                      hintText: 'Enter Pin Code',
                      prefixIcon: Icon(FontAwesomeIcons.mapPin),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your pin code';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      pinCode = value;
                    },
                  ),
                ),
                const SizedBox(height: 25,),

                // Code for Entering Country

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Country*',
                      hintText: 'Enter Country',
                      prefixIcon: Icon(FontAwesomeIcons.earthAsia),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your country';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      country = value;
                    },
                  ),
                ),
                const SizedBox(height: 25,),

                // Code for Submit Button


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        submitUserInfo();
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

