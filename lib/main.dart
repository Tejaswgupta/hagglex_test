import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex_test/screens/dashboard.dart';
import 'package:hagglex_test/screens/login_screen.dart';
import 'package:hagglex_test/screens/setup_complete_screen.dart';
import 'package:hagglex_test/screens/signup_screen.dart';
import 'package:hagglex_test/screens/verification_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://hagglex-backend-staging.herokuapp.com/graphql',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        theme: ThemeData(
          canvasColor: Colors.purple[900],
        ),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          VerificationScreen.id: (context) => VerificationScreen(),
          SetupCompleteScreen.id: (context) => SetupCompleteScreen(),
          Dashboard.id: (context) => Dashboard(),
        },
      ),
    );
  }
}
