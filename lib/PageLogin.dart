import 'dart:convert';
import 'package:app_booking_rs/PageNavigation.dart';
import 'package:app_booking_rs/PageRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  // bool isLoading = true;
  bool isLoading = false;
  bool _obscureText = true;

  // Definisi regex untuk memeriksa format email
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final email = txtEmail.text;
    final password = txtPassword.text;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/login'),
        body: {
          "email": email,
          "password": password,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // if (responseData['status'] == true) {
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   prefs.setString('email', txtEmail.text);
        //   prefs.setString('password', txtPassword.text);
        //   // prefs.setString('username', responseData['username']);
        //   prefs.setString('name', responseData['name']);
        //   prefs.setString('phone', responseData['phone']);
        //   // prefs.setString('address', responseData['address']);
        //   prefs.setString('status', responseData['status']);
        //   // prefs.setString('token', responseData['token']);
        //   // prefs.setString('email_verified_at', responseData['email_verified_at']);
        //   // prefs.setInt('id', responseData['id']);
        //   prefs.setInt('id_user', responseData['id']);

        //   // Navigator.pushReplacement(
        //   //   context,
        //   //   MaterialPageRoute(builder: (context) => BottomNavigationPage()),
        //   // );
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => PageRegister()),
        //   );
        // } else {
        //   showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         title: Text('Login Gagal'),
        //         content: Text('Email atau Password salah.'),
        //         actions: [
        //           TextButton(
        //             onPressed: () => Navigator.pop(context),
        //             child: Text('OK'),
        //           ),
        //         ],
        //       );
        //     },
        //   );
        // }

        // final user = responseData['user'];
        // print('User data: ${user}');

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('email', user['email']);
        // prefs.setString('password', user['password']);
        // prefs.setString('name', user['name']);
        // prefs.setString('phone', user['phone']);
        // prefs.setString('status', user['status']);

        // // Jika address dan picture null, simpan nilai default
        // prefs.setString('address', user['address'] ?? '');
        // prefs.setString('picture', user['picture'] ?? '');
        // prefs.setString('picture', user['picture'] ?? '');
        // prefs.setInt('id', user['id']);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => BottomNavigationPage()),
        // );
        if (responseData['status'] == true) {
          final user = responseData['user'];
          print('User data: ${user}');

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', user['email'] ?? '');
          prefs.setString('password', user['password'] ?? '');
          prefs.setString('name', user['name'] ?? '');
          prefs.setString('phone', user['phone'] ?? '');
          prefs.setString('status', user['status'] ?? '');
          prefs.setString('address', user['address'] ?? '');
          prefs.setString('picture', user['picture'] ?? '');

          if (user['id'] != null) {
            prefs.setInt(
                'id_user', user['id']); // Simpan ID dengan key 'id_user'
          } else {
            throw Exception('User ID is missing');
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationPage()),
          );
        } else {
          throw Exception('Login failed. ${responseData['message']}');
        }
      } else if (response.statusCode == 401) {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text(errorResponse['message'] ??
                  'Email atau Password tidak sesuai.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat melakukan login.'),
            // content: Text('Login Gagal.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _forgotPassword() {
    // Define TextEditingControllers and other state variables
    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtNewPassword = TextEditingController();
    TextEditingController txtConfirmPassword = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool _isEmailValid = false;
    bool _isLoading = false;
    bool _obscureText = true;
    bool _obscureText2 = true;
    int? userId; // Add a variable for user ID

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    _isEmailValid ? Icons.lock_reset : Icons.email_outlined,
                    color: _isEmailValid ? Colors.green : Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text(
                    _isEmailValid ? 'Reset Password' : 'Forgot Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!_isEmailValid) ...[
                      Text(
                        "Please enter your email address to reset your password:",
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: txtEmail,
                        decoration: InputDecoration(
                          hintText: 'Enter your email address',
                          prefixIcon: Icon(Icons.email, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.blue[50],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty.';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Enter a valid email address.';
                          }
                          return null;
                        },
                      ),
                    ] else ...[
                      Text(
                        "Enter your new password:",
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: txtNewPassword,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Enter new password',
                          prefixIcon: Icon(Icons.lock, color: Colors.blue),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.blue[50],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty.';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters long.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: txtConfirmPassword,
                        obscureText: _obscureText2,
                        decoration: InputDecoration(
                          hintText: 'Confirm new password',
                          prefixIcon: Icon(Icons.lock, color: Colors.blue),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.blue[50],
                        ),
                        validator: (value) {
                          if (value != txtNewPassword.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ],
                ),
              ),
              actions: <Widget>[
                if (!_isEmailValid) ...[
                  TextButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });

                      final email = txtEmail.text;

                      try {
                        final response = await http.post(
                          Uri.parse('http://127.0.0.1:8000/api/check-email'),
                          body: {'email': email},
                        );

                        final Map<String, dynamic> responseData =
                            json.decode(response.body);

                        if (response.statusCode == 200 &&
                            responseData['user'] != null) {
                          setState(() {
                            _isEmailValid = true;
                            userId = responseData['user']['id']; 
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text(responseData['message'] ??
                                  'Email not found.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } catch (error) {
                        print('Error: $error');

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content:
                                Text('An error occurred while checking email.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                ] else ...[
                  TextButton(
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        final response = await http.post(
                          Uri.parse(
                              'http://127.0.0.1:8000/api/reset-password/$userId'),
                          body: {
                            'password': txtNewPassword.text,
                            'password_confirmation': txtConfirmPassword.text,
                          },
                        );

                        final Map<String, dynamic> responseData =
                            json.decode(response.body);

                        if (response.statusCode == 200) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Success',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                'Password has been reset successfully.',
                                style: TextStyle(color: Colors.black54),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Error',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                responseData['message'] ??
                                    'Failed to reset password.',
                                style: TextStyle(color: Colors.black54),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } catch (error) {
                        print('Error: $error');

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Error',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              'An error occurred during password reset.',
                              style: TextStyle(color: Colors.black54),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                ],
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(0xFFf5ffff),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              // Text(
              //   "Welcome back",
              //   style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //       ),
              // ),
              Image.asset(
                'assets/logo1.png',
                height: 120,
              ),
              const SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 60),
              Form(
                key: keyForm,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtEmail,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.person_outline),
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
                        } else if (!emailRegex.hasMatch(val)) {
                          return "ex: ex@mail.com";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: _obscureText,
                controller: txtPassword,
                // keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
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
                // validator: (String? value) {
                //   if (value == null || value.isEmpty) {
                //     return "Please enter password.";
                //   } else if (value !=
                //       _boxAccounts.get(_controllerUsername.text)) {
                //     return "Wrong password.";
                //   }

                //   return null;
                // },

                validator: (val) {
                  if (val!.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  return null;
                },
              ),

              // forgot password
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: _forgotPassword,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF3a5baa),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: isLoading ? null : () => _login(),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Log In',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3a5baa), // Warna tombol
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    // manual
                    // onPressed: () {
                    //   // Navigator.push(
                    //   //     context,
                    //   //     MaterialPageRoute(
                    //   //         builder: (context) => PageRegister()));
                    // },
                    // child: const Text(
                    //   "Login",
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageRegister()));
                        },
                        child: const Text("Sign up"),
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
