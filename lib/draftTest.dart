// import 'package:flutter/material.dart';
// import 'package:service/user_credientials/info_form.dart';
// import 'package:service/user_credientials/info_form_2_register.dart';
// import 'package:service/user_credientials/user_documents_page.dart';
//
// class StepperPage extends StatefulWidget {
//   final String mobileNumber;
//   StepperPage({required this.mobileNumber});
//
//   @override
//   _StepperPageState createState() => _StepperPageState();
// }
//
// class _StepperPageState extends State<StepperPage> {
//   double screenHeight = 0;
//   double screenWidth = 0;
//   int _currentStep = 0;
//
//
//   void _onStepTapped(int value) {
//     setState(() {
//       _currentStep = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//     List<Step> steps = [
//       Step(
//         title: Text('Step 1'),
//
//         content:
//         Container(
//
//           height: screenHeight- 150, // Set a suitable height
//           child:
//           UserInfoPage(mobileNumber: widget.mobileNumber,),
//         ),
//
//         // ElevatedButton(
//         //   onPressed: _goToStep1Page,
//         //
//         //   child: Text('Go to Step 1 Page'),
//         // ),
//         isActive: _currentStep == 0,
//       ),
//       Step(
//         title: Text('Step 2'),
//         content:
//         Container(
//
//           height: screenHeight- 160, // Set a suitable height
//           child:
//           registerInfoPage(mobileNumber: widget.mobileNumber,),
//         ),
//         // ElevatedButton(
//         //   onPressed: _goToStep2Page,
//         //   child: Text('Go to Step 2 Page'),
//         // ),
//         isActive: _currentStep == 1,
//       ),
//       Step(
//         title: Text('Step 3'),
//         content:
//         Container(
//
//           height: screenHeight- 170, // Set a suitable height
//           child:
//           DocumentUploadPage(mobileNumber: widget.mobileNumber,),
//         ),
//         // ElevatedButton(
//         //   onPressed: _goToStep3Page,
//         //   child: Text('Go to Step 3 Page'),
//         // ),
//         isActive: _currentStep == 2,
//       ),
//     ];
//     //  Returning empty container to remove Continue and Cancel Buttons .
//     Widget controlsBuilder(context, details) {
//       return Container();
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//         title: Text(
//           'Services',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Stepper(
//         currentStep: _currentStep,
//         steps: steps,
//         type: StepperType.horizontal,
//         onStepTapped: _onStepTapped,
//         // onStepContinue: _on,
//         controlsBuilder: controlsBuilder,
//       ),
//     );
//   }
// }
