import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex_test/screens/setup_complete_screen.dart';
import 'package:hagglex_test/screens/signup_screen.dart';

const resendQuery = r'''

query ($email:String!){
  
  resendVerificationCode(data:{email:$email})
  
}

''';

const verifyMutation = r'''

mutation ($code:Int!){
  
  verifyUser(data:{code:$code}){
    user{
      _id
    }
  }
  
}

''';

class VerificationScreen extends StatefulWidget {
  static final id = "VerificationScreen";

  final email;

  VerificationScreen({this.email});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.3),
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Verify your account",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple[900].withOpacity(0.3),
                        child: Icon(
                          Icons.check,
                          color: Colors.purple[900],
                          size: 30,
                        )),
                  ),
                  Text("We just sent a verification code to your email"),
                  Text("Please enter the code"),
                  SizedBox(height: 20),
                  CustomInputField(
                    controller: otpController,
                    text: "Verification Code",
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Mutation(
                        options: MutationOptions(
                            document: gql(verifyMutation),
                            onCompleted: (result) {
                              log(result.toString());
                            }),
                        builder: (RunMutation runMutation, QueryResult result) {
                          return TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).canvasColor)),
                            onPressed: () {
                              runMutation({"code": otpController.text});

                              Navigator.pushNamed(
                                  context, SetupCompleteScreen.id);
                            },
                            child: Text(
                              "Verify Me",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "The code will expire in 10 minutes ",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 40),
                  Query(
                    options:
                        QueryOptions(document: gql(resendQuery), variables: {
                      "email": widget.email,
                    }),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      return TextButton(
                        onPressed: () {
                          if (result.data['resendVerificationCode']) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("OTP Sent")));
                          }
                        },
                        child: Text(
                          "Resend code",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
