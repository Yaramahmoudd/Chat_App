import 'package:chat_app/core/constant.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:chat_app/widgets/custome_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCont = TextEditingController();

  TextEditingController passCont = TextEditingController();

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  bool Show_Pass = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kprimaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      photo,
                      height: 100,
                    ),
                    const Text('Scolar chat',
                        style: TextStyle(
                            color: bordercolor,
                            fontSize: 40,
                            fontFamily: 'Pacifico')),
                    const SizedBox(
                      height: 60,
                    ),
                    const Row(
                      children: [
                        Text('LOGIN',
                            style: TextStyle(
                              color: bordercolor,
                              fontSize: 30,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomeTextField(
                      icon: Icons.email,
                      obscureText: false,
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      cont: emailCont,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomeTextField(
                      obscureText: Show_Pass,
                      icon: Icons.lock,
                      iconButton: IconButton(onPressed: (){
                        setState(() {
                              Show_Pass = !Show_Pass;
                            });
                      }, icon: Icon(
                              Show_Pass ? Icons.visibility_off : Icons.visibility),),
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      cont: passCont,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomeButton(
                        text: 'LOGIN',
                        color: bordercolor,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await LoginUser();
                              Navigator.pushNamed(
                                  context, 'ChatScreen', arguments: email);
                            } on FirebaseAuthException catch (ex) {
                              if (ex.code == 'user-not-found') {
                                print('No user found for that email.');
                                ShowSnackBar(
                                    context, 'No user found for that email.');
                              } else if (ex.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                                ShowSnackBar(context,
                                    'Wrong password provided for that user.');
                              }
                            } catch (ex) {
                              print(ex);
                              ShowSnackBar(context, 'there was an error');
                            }
                            isLoading = false;
                            setState(() {});
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("don't have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: bordercolor,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, 'RegisterationScreen');
                            },
                            child: const Text(
                              "Register ",
                              style: TextStyle(
                                  color: bordercolor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LoginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
    );
  }
}
