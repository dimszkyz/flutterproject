import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectflut/admin.dart';
import 'package:projectflut/bantuan.dart';
import 'package:projectflut/pengguna.dart';
import 'package:projectflut/registrasi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginPage(),
      routes: <String, WidgetBuilder>{
        'admin': (BuildContext context) => Admin(),
        'pengguna': (BuildContext context) => Pengguna(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String message = '';
  bool _isObscure = true;
  bool _agreedToTerms = false;

  Future<void> _login() async {
    //INI ADALAH TEXT YG KELUAR JIKA BELUM MEMASUKAN PSW ATAU USERNAME
    if (username.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi username dan password terlebih dahulu'),
        ),
      );
    } else if (!_agreedToTerms) { //INI JIKA BELUM MEN-CEKLIS CHECK BOX
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap setujui persyaratan terlebih dahulu.'),
        ),
      );
    } else { //INI UNTUK MENGAMBIL DATABASE LOGIN PHP
      final response = await http.post(
        Uri.parse("http://localhost/databasedims/login.php"),
        body: {
          "username": username.text,
          "password": password.text,
        },
      );

      var datauser = json.decode(response.body);

      if (datauser.length == 0) { //INI ADALAH JIKA SALAH DALAM PENGISIAN USERNAME ATAU PSW
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Login failed!, periksa kembali username atau password anda.'),
            ),
          );
        });
      } else {
        if (datauser[0]['level'] == 'admin') {
          Navigator.pushReplacementNamed(context, 'admin');
        } else if (datauser[0]['level'] == 'pengguna') {
          Navigator.pushReplacementNamed(context, 'pengguna');
        } else if (datauser[0]['level'] == '') {
          Navigator.pushReplacementNamed(context, 'pengguna');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DimsZky Store',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (result) { //TOMBOL YG MENGARAH KE BANTUAN DART YG MEMILIKI CLASS FAQPage
              if (result == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQPage()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('bantuan'),
                value: 0,
              ),
            ],
          )
        ],
      ),
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/loginbg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column( //INI ADALAH IMAGES LOGO
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0, bottom: 10.0),
                    child: Center(
                      child: Container(
                        width: 500,
                        height: 150,
                        child: Image.asset("images/logotb.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                              "LOGIN",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                              value: _agreedToTerms,
                              onChanged: (bool? value) {
                                setState(() {
                                  _agreedToTerms = value!;
                                });
                              },
                            ),
                            Text(
                              'Setuju dengan persyaratan',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Action when text is pressed
                            },
                            child: Text(
                              "Lupa Password?",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: _login,
                            child: Text("Login"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Belum memiliki akun?",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
                                  );
                                },
                                child: Text(
                                  "Daftar disini.",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
