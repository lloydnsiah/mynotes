import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body:  Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: "Enter Email Here",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10.0,),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter Password Here",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10.0,),
              TextButton(onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try{
                  final usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                  print(usercredential);
                }on FirebaseAuthException catch(e){
                  print(e.code);
                  if(e.code == "user not found"){
                    print("User not found..");
                  }else{
                    print("something else happened");
                    print(e.code);
                    print(e);
                  }
                }
                catch(e){
                  print(e);
                }

              },
                child: Text("Login"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Do not have an account"),
                  SizedBox(width: 5.0,),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil("/register/", (route) => false);
                  },
                      child: Text("click here.."))
                ],
              ),
              TextButton(onPressed: (){
                FirebaseAuth.instance.signOut();
              },
                  child: Text("Logout")),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil("/verifyEmail/", (route) => false);
              },
                  child: const Text("Verify Email click here")),
            ],
          ),

        ),
      ),
    );
  }
}