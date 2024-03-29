import 'package:chatting_app/pages/home_screen.dart';
import 'package:chatting_app/pages/login_screen.dart';
import 'package:flutter/material.dart';
import '../services/authentication/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var cnfPassword = TextEditingController();
  bool passwordVisibility = true;
  String hintText = "";
  bool hint = false;

  TextEditingController validateEmail(TextEditingController email) {
    setState(() {
      if (email.text.endsWith("@gmail.com")) {
        hint = true;
      } else if (email.text.isEmpty) {
        hint = false;
      } else {
        hint = false;
        hintText = "Must be ends with @gmail.com";
      }
    });
    return email;
  }

  TextEditingController validatePassword(TextEditingController password) {
    setState(() {
      if (password.text.length >= 6) {
        hint = true;
      } else if (password.text.isEmpty) {
        hint = false;
      } else {
        hint = false;
        hintText = "must contains 6 letters";
      }
    });
    return password;
  }

  void register() {
    var auth = AuthService();
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        cnfPassword.text.isNotEmpty) {
      if (password.text == cnfPassword.text) {
        try {
          auth.signUpWithEmailPassword(email.text, password.text);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(e.toString()),
                  ));
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Password & Confirm Password should be same"),
                ));
      }
    } else {
      setState(() {
        hint = false;
        hintText = "Field should not be empty";
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Field should not be empty"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: validateEmail(email),
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                hint
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Text(
                          hintText,
                          style: TextStyle(color: Colors.red),
                        )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: validatePassword(password),
                    obscureText: passwordVisibility,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          color: Colors.green,
                          icon: Icon(passwordVisibility
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                hint
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Text(
                          hintText,
                          style: TextStyle(color: Colors.red),
                        )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: validatePassword(cnfPassword),
                    obscureText: passwordVisibility,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                          color: Colors.green,
                          icon: Icon(passwordVisibility
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                hint
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Text(
                          hintText,
                          style: TextStyle(color: Colors.red),
                        )),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          hintText = "Field should not be Empty";
                          register();
                        },
                        child: Text("Register")),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?  ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
