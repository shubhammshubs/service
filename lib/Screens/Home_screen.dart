import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:service/CallS/Call_History.dart';

import '../CallS/Accepted_Calls.dart';
import '../CallS/Completed_Calls.dart';
import '../CallS/Hold_Calls.dart';
import '../CallS/InProcess_Calls.dart';
import '../CallS/Incomplete_Calls.dart';
import '../Widgets/NavBar.dart';
import '../API/data_provider.dart';
import '../draftTest.dart';
class HomePage extends StatefulWidget {
  final String mobileNumber;

  HomePage({required this.mobileNumber});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double screenHeight = 0;
  double screenWidth = 0;
  int itemCount = 0; // Initialize the count to 0
  int itemCountHold = 0;
  int itemCountInProcess = 0;
  int itemCountIncomplete = 0;
  int itemCountAccepted = 0;
  int itemCountCallHistory = 0;


  @override
  void initState() {
    super.initState();
    _fetchCompletedCallsCount(widget.mobileNumber);
    _fetchHoldCallsCount(widget.mobileNumber);
    _fetchInprocessCallsCount(widget.mobileNumber);
    _fetchIncompleteCallsCount(widget.mobileNumber);
    _fetchAcceptedCallsCount(widget.mobileNumber);
    _fetchCallHistoryCount(widget.mobileNumber);
  }



  void _fetchCompletedCallsCount(String mobileNumber) {
    fetchCompletedCallsCount(mobileNumber).then((count) {
      setState(() {
        itemCount = count;
      });
    });
  }
  void _fetchCallHistoryCount(String mobileNumber) {
    fetchCallHistoryCount(mobileNumber).then((count) {
      setState(() {
        itemCountCallHistory = count;
      });
    });
  }


  void _fetchHoldCallsCount(String mobileNumber) {
    fetchHoldCallsCount(mobileNumber).then((count) {
      setState(() {
        itemCountHold = count;
      });
    });
  }

  void _fetchInprocessCallsCount(String mobileNumber) {
    fetchInprocessCallsCount(mobileNumber).then((count) {
      setState(() {
        itemCountInProcess = count;
      });
    });
  }
  void _fetchIncompleteCallsCount(String mobileNumber) {
    fetchIncompleteCallsCount(mobileNumber).then((count) {
      setState(() {
        itemCountIncomplete = count;
      });
    });
  }
  void _fetchAcceptedCallsCount(String mobileNumber) {
    fetchAcceptedCallsCount(mobileNumber).then((count) {
      setState(() {
        itemCountAccepted = count;
      });
    });
  }
  void _updateHomePageData() async {
    // Fetch call counts and update state
    // For example, you can call your API here to get the counts

    final itemCount = await fetchCompletedCallsCount(widget.mobileNumber);
    final itemCountHold = await fetchHoldCallsCount(widget.mobileNumber);
    final itemCountInProcess = await fetchInprocessCallsCount(widget.mobileNumber);
    final itemCountIncomplete = await fetchIncompleteCallsCount(widget.mobileNumber);
    // final itemCountAccepted = await fetchAcceptedCallsCount(widget.mobileNumber);
    final itemCountCallHistory = await fetchCallHistoryCount(widget.mobileNumber);


    setState(() {
      this.itemCount = itemCount;
      this.itemCountHold = itemCountHold;
      this.itemCountInProcess = itemCountInProcess;
      this.itemCountIncomplete = itemCountIncomplete;
      // this.itemCountAccepted = itemCountAccepted;
      this.itemCountCallHistory = itemCountCallHistory;

    });
  }


  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        // Handle back button press here
        // You can use the following code to exit the app:
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        drawer: NavBar(mobileNumber: widget.mobileNumber),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: const Text(
            'Services',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: LiquidPullToRefresh(
          color: Colors.teal,
          springAnimationDurationInMilliseconds: 200,
          onRefresh: () async {
            // Implement your refresh logic here
            await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
            _updateHomePageData(); // Fetch your data again
            print('Refreshing...'); // Add this line

          },
          showChildOpacityTransition: false, // Disable child opacity transition
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Hello User, Mobile Number: ${widget.mobileNumber}"),
                ),

                const SizedBox(height: 20,),
                // Wrap each pair of buttons in a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
                  children: [
                    // Button 1
                    // Container(
                    //   width: 150, // Fixed width for all buttons
                    //   child: MaterialButton(
                    //     height: 50,
                    //     onPressed: () async {
                    //       // Implement button 1 logic
                    //     },
                    //     color: Colors.lightBlueAccent,
                    //     textColor: Colors.black,
                    //     child: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         Icon(
                    //           Icons.call, // Choose the icon you want
                    //           size: 24, // Adjust the size as needed
                    //         ),
                    //         SizedBox(width: 8), // Add some spacing between the icon and text
                    //         Text(
                    //           'Total Calls',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
                      children: [
                        // Button 3
                        Container(
                          width: 150, // Fixed width for all buttons
                          child: MaterialButton(
                            height: 50,
                            onPressed: () async {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>
                                      CallHistory(mobileNumber: widget.mobileNumber,))
                              );
                            },
                            color: Colors.lightBlueAccent,
                            textColor: Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
                              children: [
                                const Text(
                                  'Total Calls',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' ($itemCountCallHistory)',
                                  style: const TextStyle(
                                    fontSize: 14, // Adjust the size as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Button 4

                      ],
                    ),
                    // Button 2
                    Container(
                      width: 150, // Fixed width for all buttons
                      child: MaterialButton(
                        height: 50,
                        onPressed: () async {
                          // Implement button 2 logic
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                                DisplayAcceptedCall(mobileNumber: widget.mobileNumber,))
                          );
                        },
                        color: Colors.teal[300],
                        textColor: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically

                          children: [

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
                              children: [

                                const Text(
                                  'Accepted Calls',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '($itemCountAccepted)',
                                  style: const TextStyle(
                                    fontSize: 14, // Adjust the size as needed
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                // Repeat the Row widget for other pairs of buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
                  children: [
                    // Button 3
                    Container(
                      width: 150, // Fixed width for all buttons
                      child: MaterialButton(
                        height: 50,
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                            InCompleteCalls(mobileNumber: widget.mobileNumber,))
                          );
                        },
                        color: Colors.orange[300],
                        textColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
                          children: [
                            const Text(
                              'Not Attended Calls',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' ($itemCountIncomplete)',
                              style: const TextStyle(
                                fontSize: 14, // Adjust the size as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Button 4
                    Container(
                      width: 150, // Fixed width for all buttons
                      child: MaterialButton(
                        height: 50,
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                            InProcessCalls(mobileNumber: widget.mobileNumber,))
                          );
                        },
                        color: Colors.red[300],
                        textColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
                          children: [
                            const Text(
                              'In Process Calls',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' ($itemCountInProcess)',
                              style: const TextStyle(
                                fontSize: 14, // Adjust the size as needed
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
                  children: [
                    // Button 5
                    Container(
                      width: 150, // Fixed width for all buttons
                      child: MaterialButton(
                        height: 50,
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                            HoldCalls(mobileNumber: widget.mobileNumber,))
                          );
                        },
                        color: Colors.pink[300],
                        textColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
                          children: [
                            const Text(
                              'Calls On Hold',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' ($itemCountHold)',
                              style: const TextStyle(
                                fontSize: 14, // Adjust the size as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Button 6
                    Container(
                      width: 150, // Fixed width for all buttons
                      child: MaterialButton(
                        height: 50,
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                            CompletedCalls(mobileNumber: widget.mobileNumber,))
                          );
                        },
                        color: Colors.green[300],
                        textColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
                          children: [
                            const Text(
                              'Completed Calls',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' ($itemCount)',
                              style: const TextStyle(
                                fontSize: 14, // Adjust the size as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 474,),

              ],
            ),
          ),
        )

      ),
    );
  }
}
