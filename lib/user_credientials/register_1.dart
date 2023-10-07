import 'dart:convert';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service/user_credientials/loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/Home_screen.dart';
import 'info_form.dart';


class RegistrationPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> _signUp(BuildContext context) async {


    final String apiUrl =
        'https://apip.trifrnd.com/Services/eng/sereng.php?apicall=signup';

    // Simulate a delay of 1 second
    await Future.delayed(Duration(seconds: 1));

    final response = await http.post(Uri.parse(apiUrl),
        body: {
      "username": _nameController.text,
          "email": _emailController.text,
          "mobile": _mobileController.text,
          "password": _passwordController.text,
        });



    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("Response body: ${response.body}");

      print("Decoded data: $responseData");

      if (responseData == "User registered successfully") {
        // Login successful, you can navigate to the next screen
        print("Register successful");
        final user = json.decode(response.body)[0];

        Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Use Navigator to push HomePage onto the stack
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  HomePage(
            mobileNumber: _mobileController.text,
          ),),
        );

      } else {
        // Login failed, show an error message
        print("Login failed");
        Fluttertoast.showToast(
          msg: "You Are Already Registered, Please Login to Continue",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
    } else {
      // Handle error if the API call was not successful
      print("API call failed");
      Fluttertoast.showToast(
        msg: "Server Connction Error!",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }


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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120,),
               Text(
                'Register',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.teal.shade300,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                    key: _formKey,
                    child: Column(
                  children: [
                    // Code for Entering Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
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
                    SizedBox(height: 30,),

                    // Code for Entering Email

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){

                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                          // Code for Entering Mobile Number
                        },
                      ),
                    ),
                    SizedBox(height: 30,),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _mobileController,
                        decoration: const InputDecoration(
                          labelText: 'Mobile',
                          hintText: 'Enter Mobile Number',
                          prefixIcon: Icon(Icons.mobile_friendly),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){

                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a mobile';
                          } else if (value.length < 10) {
                            return 'Mobile number must be 10 Digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30,),

                    // Code for Entering Password

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password ',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){

                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30,),

                    // Code for Submit button

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () async {
                          // Handle login logic here
                          if (_formKey.currentState!.validate()) {

                            // Perform the login
                            await _signUp(context);

                          }
                        },
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: const Text('Register',
                        style: TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                    ),
                    const SizedBox(height: 20,),

                    // Code for Login Page Button

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage(),),
                        );
                      },
                      child: Text(
                        'Already Registered? Login Here',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.redAccent[100],
                            decoration: TextDecoration.underline
                        ),
                      ),
                    )
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
