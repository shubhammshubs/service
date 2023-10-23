
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'info_form_2_register.dart';


class UserInfoPage extends StatefulWidget {
  final String mobileNumber;
  const UserInfoPage({super.key, required this.mobileNumber});
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<UserInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, String>> cities = [];
  String? selectedState;
  String? selectedDistrict;
  String? selectedCity;

  // TextEditingController mobileController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController mNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  String dob = ''; // Store the selected date
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, send data to the API
      sendUserDataToAPI();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchListData();
  }
  //  API for Dropdown List [state,District,City]
  Future<void> fetchListData() async {
    final response = await http.get(
        Uri.parse('https://apip.trifrnd.com/services/eng/sereng.php?apicall=readcities'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Map<String, String>> cityList = data
          .map((item) => Map<String, String>.from(item))
          .toList();
      setState(() {
        cities = cityList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<String?> getStates() {
    return cities.map((city) => city['State']).toSet().toList();
  }

  List<String?> getDistricts() {
    if (selectedState == null) return [];
    return cities
        .where((city) => city['State'] == selectedState)
        .map((city) => city['District'])
        .toSet()
        .toList();
  }

  List<String?> getCities() {
    if (selectedDistrict == null) return [];
    return cities
        .where((city) =>
    city['State'] == selectedState && city['District'] == selectedDistrict)
        .map((city) => city['City'])
        .toList();
  }



  Future<void> sendUserDataToAPI() async {
    final url = Uri.parse(
        'https://apip.trifrnd.com/Services/eng/sereng.php?apicall=engreg');

    final response = await http.post(url, body: {
      'mobile': widget.mobileNumber,
      'FName': fNameController.text,
      'MName': mNameController.text,
      'LName': lNameController.text,
      'DoB': dob, // Use the selected date
      'Address': addressController.text,
      'City': selectedCity,
      'State': selectedState,
      'District': selectedDistrict,
      'Pincode': pincodeController.text,
    });

    if (response.statusCode == 200) {
      // Successfully sent data to the API
      print(response.statusCode);
      print(response.body);

      print('Data sent successfully');
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => registerInfoPage(mobileNumber: widget.mobileNumber,),),
      );
      // You can add code here to handle a successful response
    } else {
      // Handle errors
      print('Error sending data to the API: ${response.statusCode}');
      // You can add code here to handle API errors
    }
  }





  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dob = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.teal,
      //   centerTitle: true,
      //   title: const Text(
      //     'Personal Inforamtion',
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      // ),
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
                  'Personal Information',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.teal.shade300,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text("Hello User, Mobile Number: ${widget.mobileNumber}"),
                const SizedBox(height: 30),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    controller: fNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'First Name*',
                      hintText: 'First Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                // TextFormField(
                //   controller: fNameController,
                //   decoration: InputDecoration(labelText: 'First Name'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your first name';
                //     }
                //     return null;
                //   },
                // ),


                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    controller: mNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Middle Name*',
                      hintText: 'Middle Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Middle name';
                      }
                      return null;
                    },
                  ),
                ),
                // TextFormField(
                //   controller: mNameController,
                //   decoration: InputDecoration(labelText: 'Middle Name'),
                // ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    controller: lNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Last Name*',
                      hintText: 'Last Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Last Name';
                      }
                      return null;
                    },
                  ),
                ),
                // TextFormField(
                //   controller: lNameController,
                //
                //   decoration: InputDecoration(labelText: 'Last Name'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your last name';
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(height: 30),


                Card(
                  elevation: 1, // Adjust the elevation if desired
                  child: Container(
                    width: 320,
                    height: 60,
                    // Adjust the width as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0,          // Border width
                      ),
                      borderRadius: BorderRadius.circular(3.0), // Border radius
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.calendar_today, color: Colors.blue), // Icon
                      title: const Text(
                        'Date of Birth',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      subtitle: Text(dob),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                ),
                // const SizedBox(height: 30),

                //   ListTile(
                //   title: Text(
                //     'Date of Birth',
                //     style: TextStyle(fontSize: 18.0),
                //   ),
                //   subtitle: Text(dob),
                //   onTap: () => _selectDate(context),
                // ),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Address*',
                      hintText: 'Address',
                      prefixIcon: Icon(Icons.home),
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ),
                // TextFormField(
                //   controller: addressController,
                //   decoration: InputDecoration(labelText: 'Address'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your address';
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: DropdownButtonFormField<String?>(
                    value: selectedState,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedState = newValue;
                        selectedDistrict = null;
                        selectedCity = null;
                      });
                    },
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Select State'),
                      ),
                      ...getStates().map((state) => DropdownMenuItem<String?>(
                        value: state,
                        child: Text(state ?? ""),
                      )).toList()
                  ..sort((a, b) => a.child.toString().compareTo(b.child.toString())),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'State*',
                      prefixIcon: Icon(FontAwesomeIcons.mapLocationDot),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a state';
                      }
                      return null;
                    },
                    // onChanged: (newValue) {
                    //   // Handle state change here
                    // },
                  ),
                ),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: DropdownButtonFormField<String?>(
                    value: selectedDistrict,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDistrict = newValue;
                        selectedCity = null;
                      });
                    },
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Select District'),
                      ),
                      ...getDistricts().map((district) => DropdownMenuItem<String?>(
                        value: district,
                        child: Text(district ?? ""),
                      )).toList()
                        ..sort((a, b) => a.child.toString().compareTo(b.child.toString())),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'District*',
                      prefixIcon: Icon(Icons.location_pin),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a district';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: DropdownButtonFormField<String?>(
                    value: selectedCity,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue;
                      });
                    },
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        
                        child: Text('Select City'),
                      ),
                      ...getCities().map((city) => DropdownMenuItem<String?>(
                        value: city,
                        child: Text(city ?? ""),
                      )).toList()
                  ..sort((a, b) => a.child.toString().compareTo(b.child.toString())),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'City*',
                      prefixIcon: Icon(Icons.location_city),

                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a city';
                      }
                      return null;
                    },
                  ),
                ),
                // const SizedBox(height: 30),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Pincode*',
                      hintText: 'Pincode',
                      prefixIcon: Icon(FontAwesomeIcons.mapPin),
                      border: OutlineInputBorder(),
                    ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),  // Limit the input to 6 characters
                      ],

                      validator: (value) {
                        final sanitizedValue = value?.replaceAll(" ", "");
                        if (sanitizedValue == null || sanitizedValue.isEmpty) {
                          return 'Please enter your Pincode';
                        } else if (sanitizedValue.length != 6 || !sanitizedValue.contains(RegExp(r'^[0-9]*$'))) {
                          return 'Please enter a valid 6-digit Pincode';
                        }
                        return null;
                      },

                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next, // Set the action
                    decoration: const InputDecoration(
                      labelText: 'Country*',
                      prefixIcon: Icon(FontAwesomeIcons.earthAsia),
                      border: OutlineInputBorder(),
                    ),
                    initialValue: 'INDIA', // Display "India" as the initial value
                    enabled: false, // Make the field read-only
                    // validator: (value) {
                    //   if (value != 'India') {
                    //     return 'Please select "India" as the country';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                // TextFormField(
                //   controller: pincodeController,
                //   decoration: InputDecoration(labelText: 'Pincode'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your pincode';
                //     }
                //     return null;
                //   },
                // ),
                // ElevatedButton(
                //   onPressed: _submitForm,
                //   child: Text('Submit'),
                // ),
                const SizedBox(height: 25,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _submitForm();
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
