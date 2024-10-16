import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectflut/login.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isObscure = true;
  late VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("images/lvmages.mp4")
      ..initialize().then((_) {
        _controller.setLooping(true);
        Timer(Duration(milliseconds: 1000), () {
          if (mounted) {
            setState(() {
              _controller.play();
              _visible = true;
            });
          }
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    _controller.dispose();
  }

  Future<void> register(BuildContext context) async {
    if (username.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi username dan password terlebih dahulu'),
        ),
      );
    } else {
      final response = await http.post(
        Uri.parse("http://localhost/databasedims/register.php"),
        body: {
          "username": username.text,
          "password": password.text,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data == "Error") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Gagal'),
                content: Text('Username telah digunakan!'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Berhasil'),
                content: Text('Anda Berhasil Membuat akun!'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to connect. Please try again later.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DimsZky Store, Mendaftar',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 2,
        actions: <Widget>[],
      ),
      body: Stack(
        children: [
          _visible
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : Container(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Center(
                    child: Container(
                      width: 500,
                      height: 150,
                      child: Image.asset("images/logotb.jpg"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "REGISTRASI AKUN",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: username,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Masukan username Anda",
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        obscureText: _isObscure,
                        controller: password,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Masukan Password Anda",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.all(16.0),
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextButton(
                            onPressed: () => register(
                                context), // Call register function on button press
                            child: Text(
                              "Daftar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width:
                                50, // Sesuaikan lebar garis yang diinginkan di sini
                            color: Colors.black,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              "Atau",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width:
                                50, // Sesuaikan lebar garis yang diinginkan di sini
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              launch('https://www.facebook.com/'); // Redirect to Facebook
                            },
                            child: Image.asset(
                              'images/facebook_icon.png', // Ganti dengan aset ikon Facebook kamu
                              width: 30,
                              height: 40,
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              launch('https://accounts.google.com'); // Redirect to Gmail
                            },
                            child: Image.asset(
                              'images/google_icon.png', // Ganti dengan aset ikon Gmail kamu
                              width: 30,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
