import '../auth/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Components/CustomTextFormField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Back"),),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                const SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Get started",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22,color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Enter Your Personal Information",
                        style:
                            TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 20),

                      // First Name
                      const Text(
                        "First name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Customtextformfield(
                        hintext: "Enter your first name",
                        obscuretext: false,
                        myController: firstName,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your first name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Last Name
                      const Text(
                        "Last name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Customtextformfield(
                        hintext: "Enter your last name",
                        obscuretext: false,
                        myController: lastName,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your last name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Email
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Customtextformfield(
                        hintext: "Enter your email",
                        obscuretext: false,
                        myController: email,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!val.contains('@')) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Customtextformfield(
                        hintext: "Enter your password",
                        obscuretext: true,
                        myController: password,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your password";
                          }
                          if (val.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Register Button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                final userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );

                                String uid =
                                    FirebaseAuth.instance.currentUser!.uid;

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .set({
                                  "firstName": firstName.text,
                                  "lastName": lastName.text,
                                  "email": email.text,
                                  "createdAt": FieldValue.serverTimestamp(),
                                });

                                print("User created: ${userCredential.user}");

                                setState(() {
                                  isLoading = false;
                                });

                                // Optionally navigate to login or home
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message ?? "Error")),
                                );
                              }
                            }
                          },
                          child: const Text("Next",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Redirect
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account?",
                            style: TextStyle(color: Colors.grey.shade200),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.white)
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
