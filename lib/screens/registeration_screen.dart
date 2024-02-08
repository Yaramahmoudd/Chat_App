import 'package:chat_app/core/constant.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:chat_app/widgets/custome_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterationScreen extends StatefulWidget {
  RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
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
                        Text('REGISTER',
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
                      cont: emailCont,
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      onChanged: (data) {
                        email = data;
                      },
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
                      cont: passCont,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomeButton(
                        text: 'REGISTER',
                        color: bordercolor,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await RegisterUser();
                              Navigator.pushNamed(
                                  context, 'ChatScreen');
                            } on FirebaseAuthException catch (ex) {
                              if (ex.code == 'weak-password') {
                                ShowSnackBar(context,
                                    'The password provided is too weak.');
                              } else if (ex.code == 'email-already-in-use') {
                                ShowSnackBar(context,
                                    'The account already exists for that email.');
                              }
                            } catch (ex) {
                              print(ex);
                            }
                            isLoading = false;
                            setState(() {});
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("already have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: bordercolor,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
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

  Future<void> RegisterUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
    );
  }
}
