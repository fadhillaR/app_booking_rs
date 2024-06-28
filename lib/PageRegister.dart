import 'dart:convert';
import 'dart:core'; //validasi format email

import 'package:app_booking_rs/PageLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  // TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  // TextEditingController txtAddress = TextEditingController();
  // // TextEditingController txtRole = TextEditingController(text: 'customer');
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool _obscureText = true;
  // // bool _obscureText1 = true;

  // Definisi regex untuk memeriksa format email
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<int> _register() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/register'),
        body: {
          // "username": txtUsername.text,
          "name": txtName.text,
          "email": txtEmail.text,
          "password": txtPassword.text,
          "phone": txtPhone.text,
          // "address": txtAddress.text,
          // "role": txtRole.text,
        },
      );

      // if (response.statusCode == 200) {
      //   final responseData = jsonDecode(response.body);
      //   final registerStatus = responseData['status'];

      //   if (registerStatus == true) {
      //     // Registration successful
      //     return 1;

      //   } else {
      //     return 0;
      //   }
      // } else if (response.statusCode == 400) {
      //   // Registration failed karena validation errors
      //   return 2;
      // } else {
      //   return 3;
      // }

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'];

        if (message == 'Data Berhasil di Regist') {
          // Registration successful
          return 1;
        } else {
          return 0;
        }
      } else if (response.statusCode == 400) {
        // Registration failed due to validation errors
        return 2;
      } else {
        return 3;
      }
    } catch (e) {
      print(e);
      return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 1000,
        color: const Color(0xFFf5ffff),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                "Register",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 35),
              Form(
                key: keyForm,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtName,
                      // keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Enter Nama",
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // validator: (String? value) {
                      //   if (value == null || value.isEmpty) {
                      //     return "Please enter username.";
                      //   } else if (_boxAccounts.containsKey(value)) {
                      //     return "Username is already registered.";
                      //   }

                      //   return null;
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tidak Boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: txtEmail,
                // keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  } else if (!(value.contains('@') && value.contains('.'))) {
                    return "Invalid email";
                  }
                  return null;
                },
                // validator: (val) {
                //   if (val!.isEmpty) {
                //     return "Tidak Boleh kosong";
                //   } else if (!emailRegex.hasMatch(val)) {
                //     return "e.g. ex@mail.com";
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: txtPhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter No Hp",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Tidak Boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: txtPassword,
                obscureText: _obscureText,
                // keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  // suffixIcon: IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         _obscurePassword = !_obscurePassword;
                  //       });
                  //     },
                  //     icon: _obscurePassword
                  //         ? const Icon(Icons.visibility_outlined)
                  //         : const Icon(Icons.visibility_off_outlined)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Color(0xFF424252),
                      size: 14.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Tidak Boleh kosong";
                  } else if (val.length < 8) {
                    return "Password harus minimal 8 karakter";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3a5baa),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      // // manual
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => PageLogin()));

                      // tes
                      if (keyForm.currentState?.validate() == true) {
                        _register().then((registerStatus) {
                          if (registerStatus == 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Berhasil didaftarkan!'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           PageVerif(email: txtEmail.text,)), //pass email
                            // );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageLogin()));
                          } else if (registerStatus == 2) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'username atau email telah digunakan!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (registerStatus == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Gagal didaftarkan'),
                                backgroundColor: Colors.deepOrange,
                              ),
                            );
                          } else {}
                        }).catchError((error) {
                          print("Error during login: $error");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'An error occurred during login. Please try again later.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        });
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
