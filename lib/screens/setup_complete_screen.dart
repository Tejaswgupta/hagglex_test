import 'package:flutter/material.dart';
import 'package:hagglex_test/screens/dashboard.dart';
import 'package:hagglex_test/screens/login_screen.dart';

class SetupCompleteScreen extends StatefulWidget {
  static final id = "SetupCompleteScreen";

  @override
  _SetupCompleteScreenState createState() => _SetupCompleteScreenState();
}

class _SetupCompleteScreenState extends State<SetupCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(width: double.infinity),
                CircleAvatar(
                    radius: 30,
                    // backgroundColor: Colors.amber[900],
                    child: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.purple[900],
                        size: 30,
                      ),
                      onPressed: () {},
                    )),
                SizedBox(height: 20),
                Text("Setup Complete",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(height: 20),
                Text("Thank you for setting up your HaggleX account",
                    style: TextStyle(color: Colors.white, fontSize: 11)),
              ],
            ),
            CustomButton(
              text: "START EXPLORING",
              onTap: () {
                Navigator.pushNamed(context, Dashboard.id);
              },
            )
          ],
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.blue, Colors.red],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
