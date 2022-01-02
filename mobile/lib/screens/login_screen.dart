import 'package:cash_manager/screens/home_screen.dart';
import 'package:cash_manager/services/api_service.dart';
import 'package:cash_manager/utils/local_storage.dart';
import 'package:cash_manager/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  bool _secureText = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _region = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _login() async {
    try {
      Map<String, dynamic> res = await API.post('/terminal/login', {
        'region': _region.text,
        'password': _password.text,
      });
      LocalStorage.setString('jwt', res['accessToken']);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      showErrorMessage(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
              top: 0,
              child: SvgPicture.asset(
                'assets/login/top.svg',
                width: 300,
                height: 200,
              )),
          Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      'Login',
                      style: GoogleFonts.pacifico(
                          fontWeight: FontWeight.bold,
                          fontSize: 70,
                          color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _region,
                        onChanged: (value) {},

                        decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Your Region',
                          labelText: 'Region',
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          labelStyle: const TextStyle(fontSize: 20),
                          filled: true,
                          fillColor: Colors.blue[50],
                        ),
                        keyboardType: TextInputType.emailAddress,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Your Region';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _password,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Your Password',
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          labelStyle: const TextStyle(fontSize: 20),
                          filled: true,
                          fillColor: Colors.blue[50],
                          suffixIcon: IconButton(
                              color: Colors.blue,
                              onPressed: () {
                                //Hide Password
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                              icon: Icon(_secureText
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        ),
                        obscureText: !_secureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Your Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          height: 50,
                          width: 350,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            onPressed: () {
                              //authetication Terminal
                              if (_formKey.currentState!.validate()) {
                                _login();
                                print("Okey");
                              } else {
                                // ignore: avoid_print
                                print("not ok");
                              }
                            },
                            child: const Text(
                              "Signin",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )),
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
