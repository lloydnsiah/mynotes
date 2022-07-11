import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verifyemail.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomePage(),
    routes: {
      "/login/": (context) => const LoginView(),
      "/register/": (context) => const RegisterView(),
      "/verifyEmail/": (context) => const VerifyEmailView()
    },
  ));

}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.done:
            final auth = FirebaseAuth.instance;
            final currentuser = auth.currentUser;
            print("Details");
            print(currentuser);
            if(currentuser != null){
              if(currentuser.emailVerified){
                print("User is Verified");
              }else{
                return const VerifyEmailView();
              }
            }else{
              return const LoginView();
            }
            return const Text("Done");
          default:
            return const SizedBox(
              width: 20.0,
              height: 20.0,
              child: Center(
                  child: CircularProgressIndicator(color: Colors.red,)),
            );
        }
      },
    );
  }
}














