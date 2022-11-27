import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:stisla_app/animation/fade_animation.dart';
import 'package:stisla_app/components/input_text.dart';
import 'package:stisla_app/page/home.dart';
import 'package:stisla_app/services/registerservices.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nInput = TextEditingController(text: "Akhmadheta Hafid");
  final eInput = TextEditingController();
  final pInput = TextEditingController(text: "12345678");
  final cpInput = TextEditingController(text: "12345678");
  bool _isLoading = false;

  Future<Response> _register() async {
    var log = await RegisterServices.signup(
        nInput.text, eInput.text, pInput.text, cpInput.text);
    return log;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const FadeAnimation(
                    1,
                    Text(
                      "Sign up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    1.2,
                    Text(
                      "Create an account, It's free",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.0,
                      InputText(label: "Name", controller: nInput),
                    ),
                    FadeAnimation(
                      1.2,
                      InputText(label: "Email", controller: eInput),
                    ),
                    FadeAnimation(
                      1.3,
                      InputText(
                        label: "Password",
                        obscureText: true,
                        controller: pInput,
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      InputText(
                        label: "Confirm Password",
                        obscureText: true,
                        controller: cpInput,
                        confirmation: pInput.text,
                      ),
                    ),
                  ],
                ),
              ),
              FadeAnimation(
                1.5,
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: const Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        var res = await _register();
                        print(res.statusCode);

                        setState(() {
                          _isLoading = false;
                        });
                        if (res.statusCode == 422) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                json.decode(res.body)['message'],
                                style: const TextStyle(color: Colors.black),
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          );
                        } else if (res.statusCode == 200) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const Home(),
                            ),
                          );
                        }
                      }
                    },
                    color: Colors.greenAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: !_isLoading
                        ? const Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
              FadeAnimation(
                1.6,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("Already have an account?"),
                    Text(
                      " Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
