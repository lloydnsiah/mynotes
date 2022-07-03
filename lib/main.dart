import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomePage(),
  ));

}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              final auth = FirebaseAuth.instance;
              final currentuser = auth.currentUser;
              print(currentuser);
              final emailverified = currentuser?.emailVerified ?? false;
              if(emailverified){
                print("Current user is Verified");
              }else{
                print("You need to verify your email");
              }
                return const Center(
                    child: Text("Done "));
            default:
              return const Text("Loading.....");
          }

        },
      ),
    );
  }
}












