import 'package:flutter/material.dart';
import 'package:service/user_credientials/loginpage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'info_form_2_register.dart';



class userInfoPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  // Form fields variables
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


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Register Screen'),
        //   backgroundColor: Colors.teal,
        //   centerTitle: true,
        // ),
        body: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120,),
              Text(
                'Personal Information',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.teal.shade300,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 30),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        // Code for Entering First Name

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,),
                          child: TextFormField(
                            // controller: _nameController,
                            keyboardType: TextInputType.name,
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
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 25,),

                        // Code for Entering Middle Name

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _nameController,
                            keyboardType: TextInputType.name,
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
                                return 'Please enter your Middle name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 25,),

                        // Code for Entering Last Name

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _nameController,
                            keyboardType: TextInputType.name,
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
                                return 'Please enter your Last name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 25,),

                        // Code for Date of Birth

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _nameController,

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
                                // setState(() {
                                //   dateOfBirth = selectedDate;
                                // });
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

                        SizedBox(height: 25,),

                        // Code for Entering Address

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 25,),

                        // Code for Entering State

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 25,),

                        // Code for Entering District

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 25,),

                        // Code for Entering City

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 25,),

                        // Code for Entering Pin Code

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _mobileController,
                            keyboardType: TextInputType.number,
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
                        SizedBox(height: 25,),

                        // Code for Entering Country

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 25,),

                        // Code for Submit Button

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();


                                // Perform form submission here
                                // You can access the form field values like firstName, lastName, etc.
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => registerInfoPage(),),
                              );
                            },
                            child: Text('Submit',
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                            color: Colors.teal,
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
