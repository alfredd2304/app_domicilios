import 'package:app_domicilios/reusable_widgets/reusable_widget.dart';
import 'package:app_domicilios/screens/home_screen.dart';
import 'package:app_domicilios/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
      width: 320,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          reusableTextField("Enter Username", Icons.person_2_outlined, false,
              _userNameTextController),
          const SizedBox(
            height: 30,
          ),
          reusableTextField("Enter Password", Icons.lock_outlined, true,
              _passwordTextController),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 180,
            child: loginSignUpButtonButton(context, true, () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }),
          ),
          signUpOption()
        ],
      ),
    )));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account?",
            style: TextStyle(color: Colors.black54)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign up",
            style: TextStyle(
                color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
