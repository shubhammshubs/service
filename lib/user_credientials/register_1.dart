import 'package:flutter/material.dart';
import 'package:service/user_credientials/loginpage.dart';

import '../Screens/Home_screen.dart';
import 'info_form.dart';


class RegistrationPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
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
                        onPressed:() {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomePage(mobileNumber: '',),),
                          );
                          if (_formKey.currentState!.validate()) {
                            // // Perform registration logic here
                            // String name = _nameController.text;
                            // String email = _emailController.text;
                            // String mobile = _mobileController.text;
                            // String password = _passwordController.text;
                            //
                            // // You can handle the form data here
                            // print('Name: $name');
                            // print('Email: $email');
                            // print('Mobile: $mobile');
                            // print('Password: $password');

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
