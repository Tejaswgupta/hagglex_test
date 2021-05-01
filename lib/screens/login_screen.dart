import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex_test/screens/signup_screen.dart';
import 'package:hagglex_test/screens/verification_screen.dart';

const loginMutation = r'''
mutation($email:String! , $password:String!){
  
                    login(data:{input:$email, password:$password}){
                      user{
                        _id
                        username
    
                      }
                      token
                      
                    }
  
                  }

''';

class LoginScreen extends StatefulWidget {
  static final id = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Mutation(
              options: MutationOptions(
                  document: gql(loginMutation),
                  onCompleted: (result) {
                    log(result.toString());
                  }),
              builder: (
                RunMutation runMutation,
                QueryResult result,
              ) {
                return TextButton(
                  child: Text(result?.data['login'].toString()),
                  onPressed: () {
                    runMutation({
                      "email": "tejaswgupta2002@gmail.com",
                      "password": "Abcd_1234",
                    });
                  },
                );
              }),
          Text(
            "Welcome!",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          CustomInputField(
            controller: emailController,
            text: "Email Address",
            color: Colors.white,
          ),
          CustomInputField(
            controller: passwordController,
            text: "Password (Min 8 characters)",
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          Mutation(
              options: MutationOptions(
                  document: gql(loginMutation),
                  onCompleted: (result) {
                    log(result.toString());
                    if (!(result == null)) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return VerificationScreen(email: emailController.text);
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Incorrect Credentials or no network connection")));
                    }
                  }),
              builder: (
                RunMutation runMutation,
                QueryResult result,
              ) {
                return CustomButton(
                  text: emailController.text,
                  onTap: () {
                    runMutation({
                      "email": emailController.text,
                      "password": passwordController.text,
                    });
                  },
                );
              }),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.id);
              },
              child: Text(
                "New User?Create a new account",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomButton extends StatelessWidget {
  final text;
  final onTap;
  CustomButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        height: 35,
        child: Center(
          child: Text(
            "LOGIN",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
