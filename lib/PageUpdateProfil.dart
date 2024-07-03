import 'package:app_booking_rs/PageProfil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class PageUpdateProfil extends StatefulWidget {
  @override
  _PageUpdateProfilState createState() => _PageUpdateProfilState();
}

class _PageUpdateProfilState extends State<PageUpdateProfil> {
  TextEditingController pictureController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  String? id;
  bool _obscureText = true;
  Uint8List? _imageData; // Menyimpan data gambar

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pictureController.text = prefs.getString('picture') ?? '';
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      addressController.text = prefs.getString('address') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      statusController.text = prefs.getString('status') ?? '';
      // id = prefs.getString('id');
      id = prefs.getInt('id_user').toString(); // Konversi ke string
    });
  }

  Future<void> _pickImage() async {
    // Menggunakan file_picker untuk memilih gambar dari lokal
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imageData = result.files.single.bytes;
        pictureController.text =
            result.files.single.name; // Update nama file pada text controller
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF424252),
            ),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: Color(0xFFE6E6E6),
        title: Text(
          'Edit My Profile',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: 750,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Card(
                        elevation: 1,
                        color: Color(0xFFFEFBFB),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  'Edit Profil',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Nama tidak boleh kosong";
                                //   }
                                // },
                                controller: pictureController,
                                decoration: InputDecoration(
                                  labelText: 'Foto Profile',
                                  labelStyle: TextStyle(fontSize: 14),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.photo_camera),
                                    onPressed: _pickImage,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                readOnly: true,
                              ),
                              if (_imageData != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Image.memory(
                                    _imageData!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              SizedBox(height: 10),
                              TextFormField(
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Nama tidak boleh kosong";
                                //   }
                                // },
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Nama',
                                  labelStyle: TextStyle(fontSize: 14),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextFormField(
                                // validator: (val) {
                                //   if (val!.isEmpty) {
                                //     return "Tidak Boleh kosong";
                                //   } else if (!emailRegex.hasMatch(val)) {
                                //     return "ex: ex@mail.com";
                                //   }
                                //   return null;
                                // },
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontSize: 14),
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                              TextFormField(
                                obscureText: _obscureText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password tidak boleh kosong";
                                  }
                                },
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontSize: 14),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                      size: 14.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextFormField(
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Nama tidak boleh kosong";
                                //   }
                                // },
                                controller: addressController,
                                decoration: InputDecoration(
                                  labelText: 'Alamat',
                                  labelStyle: TextStyle(fontSize: 14),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextFormField(
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Nama tidak boleh kosong";
                                //   }
                                // },
                                controller: phoneController,
                                decoration: InputDecoration(
                                  labelText: 'No. HP',
                                  labelStyle: TextStyle(fontSize: 14),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(height: 16.0),
                      Text(
                        'ID User: $id',
                        style: TextStyle(
                          fontSize: 5.0,
                          color: Color(0xFFFEFBFB),
                        ),
                      ),
                      // SizedBox(height: 16.0),
                      TextFormField(
                        controller: statusController,
                        decoration: InputDecoration(
                          hintText: 'Status',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.transparent),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            "Simpan",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            _editProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editProfile() async {
    final picture = pictureController.text;
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final address = addressController.text;
    final phone = phoneController.text;
    final status = statusController.text;

    // Validasi jika data kosong
    if (name.isEmpty || phone.isEmpty || email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Isi Semua Data'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('YES'),
              ),
            ],
          );
        },
      );
      return;
    } else if (!email.contains('@')) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Format Email tidak valid'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('YES'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getInt('id_user').toString();
      // id = prefs.getString('id_user');

      // var request = http.MultipartRequest(
      //   'POST',
      //   // Uri.parse('http://127.0.0.1:8000/api/users/$id'),
      //   Uri.parse('http://10.0.2.2:8000/api/users/$id'),
      // );

      if (id == null) {
        throw Exception('User ID is null');
      }
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/api/users/$id'),
      );

      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['address'] = address;
      request.fields['phone'] = phone;
      request.fields['status'] = status;

      if (_imageData != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'picture',
            _imageData!,
            filename: picture,
          ),
        );
      }

      request.headers['Content-Type'] = 'multipart/form-data';

      var response = await request.send();
      print('Status Code: ${response.statusCode}');

      final responseData = await response.stream.bytesToString();
      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');
      final data = json.decode(responseData);

      if (response.statusCode == 200 &&
          data['message'] == 'User updated successfully') {
        prefs.setString('picture', picture);
        prefs.setString('name', name);
        prefs.setString('email', email);
        prefs.setString('password', password);
        prefs.setString('address', address);
        prefs.setString('phone', phone);
        prefs.setString('status', status);

        // Navigator.pop(context, picture);
        // Navigator.pop(context);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Berhasil'),
              content: Text('Data berhasil diupdate.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: ((context) => PageProfil())),
                        (route) => false);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Gagal edit data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat mengedit profile.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('YES'),
              ),
            ],
          );
        },
      );
    }
  }
}
