import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/Custom_button_widget.dart';
import '../widgets/constant_widget.dart';
import '../widgets/custom_text_field_widget.dart';
import 'chat_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hide = true;
  var formKey = GlobalKey<FormState>();
  String? email;
  String?password;
  bool isLoaded=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(//باكدج جبتها عشان تعمل circular indicator
      inAsyncCall: isLoaded,//circular indicator متغير بيعرفني حالة ال indicator
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
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 75,),
                    Row(mainAxisAlignment:MainAxisAlignment.start ,
                      children: const [
                        Text(
                          'Login',
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
                      onChanged: (data){email=data;},// بستقبل الداتا اللي جيه من textFormField
                        hintText: 'Email',
                        prefixIcon: Icons.email,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'It is required to enter Email';
                          }
                          return null;
                        }),
                    const SizedBox(height: 10,),
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
                    const SizedBox(height: 75,),
                    CustomButton(
                        buttonName: 'Log in',
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                isLoaded=true;//بنشغل ال circular indicator
                              });
                              await signInFunction();
                              // ignore: use_build_context_synchronously
                              showSnackBar(context,  'Login Success');
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatScreen(email: email!,)),);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showSnackBar(context, 'user not found');
                              } else if (e.code == 'wrong-password') {
                                showSnackBar(context,'wrong password');
                              }
                              setState(() {
                                isLoaded=false;//بنطفي ال circular indicator
                              });
                            }
                          }
                        }),
                    const SizedBox(height: 75,),
                    InkWell(onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),);
                    },child: const Text('Dont have an account? Register',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),)),

                  ],
                ),
              ),
            ),

          )),
    );
  }

  void showSnackBar(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> signInFunction() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    );
  }
}
