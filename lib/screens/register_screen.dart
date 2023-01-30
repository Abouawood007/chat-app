// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/Custom_button_widget.dart';
import '../widgets/constant_widget.dart';
import '../widgets/custom_text_field_widget.dart';
import 'chat_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hide = true;
  var formKey = GlobalKey<FormState>();
  String? email ;
  String? password ;
  String? retypePassword ;
  bool isLoaded=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      // in this app we used modal progress hud to show indicator while loading
      inAsyncCall:isLoaded ,
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 75,),
                    Image.asset(
                      'assets/images/icons8-chat-messages-100.png',
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      'Chat up !',
                      style: TextStyle(
                          fontFamily: 'assets/fonts/ArimaMadurai-ExtraBold.ttf',
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 75,),
                    Row(mainAxisAlignment:MainAxisAlignment.start ,
                      children: const [
                        Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customTextFormField(
                        onChanged: (data){
                          email=data;
                        },
                        hintText: 'Email',
                        prefixIcon: Icons.email,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'It is required to enter Email';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    customTextFormField(
                        onChanged: (data){password=data;},
                        isPassword: hide,
                        prefixIcon: Icons.lock,
                        hintText: 'Password',
                        suffixIcon: hide ? Icons.visibility : Icons.visibility_off,
                        suffixFunction: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'you have to enter password';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    customTextFormField(
                        onChanged: (data){retypePassword=data;},
                        isPassword: hide,
                        prefixIcon: Icons.lock,
                        hintText: 'Retype Password',
                        suffixIcon: hide ? Icons.visibility : Icons.visibility_off,
                        suffixFunction: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'you have to enter password';
                          }
                          return null;
                        }),
                    const SizedBox(height: 75,),
                    CustomButton(
                        buttonName: 'Sign Up',
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                isLoaded=true;
                              });
                              await createUser();
                              showSnackBAr(context, 'Success');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ChatScreen(email:email!)),);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showSnackBAr(context,e.code.toString());
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBAr(context,e.code.toString() );
                              }
                              setState(() {
                                isLoaded=false;
                              });
                            }
                          }
                        }),
                    const SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text(
                              'Already have an account? Log In',
                              style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),
                            ))
                      ],
                    ),

                  ],
                ),
              ),
            ),
          )),
    );
  }

  void showSnackBAr(BuildContext context,String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      //طريقة اظهار ال snackBar بنستخدم حاجة اسمها scaffoldMessenger
  }

  Future<void> createUser() async {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
