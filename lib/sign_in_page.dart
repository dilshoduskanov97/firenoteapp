import 'package:firebase_auth/firebase_auth.dart';
import 'package:firenoteapp/auth_service.dart';
import 'package:firenoteapp/home_page.dart';
import 'package:firenoteapp/sign_up_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'sign_in_page';

  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _doSignIn() async {
    String email = emailController.text.trim().toString();
    String password = passwordController.text.trim().toString();

    if (email.isEmpty || password.isEmpty) {
      //error msg
      return;
    }
    print('test0');
    await AuthService.signInUser(email, password)
        .then((value) => _getFirebaseUser(value));
  }

  void _getFirebaseUser(User? user) {
    print('test1');
    if (user != null) {
      print('test2');
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      print('test3');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: _doSignIn,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                height: 50,
                minWidth: MediaQuery.of(context).size.width - 50,
                color: Colors.blueAccent,
                child: Text("Sign In"),
                textColor: Colors.white,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, SignUpPage.id);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
