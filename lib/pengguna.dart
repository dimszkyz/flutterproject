import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projectflut/login.dart';
import './detail.dart';

class Pengguna extends StatefulWidget {
  @override
  _PenggunaState createState() => _PenggunaState();
}

class _PenggunaState extends State<Pengguna> {
  Future<List> getProductData() async {
    final response =
        await http.get(Uri.parse("http://localhost/databasedims/getdata.php"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 55, 80),
      appBar: AppBar(
        title: Text(''),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 28, 32, 58),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Colors.white,
            onPressed: () {
              // Aksi ketika ikon akun diklik
            },
          ),
        ],
        flexibleSpace: Row(
          children: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            Image.asset(
              'images/logotb.jpg',
              fit: BoxFit.contain,
              height: 60,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/sidemages.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: kToolbarHeight,
                color: Color.fromARGB(255, 146, 124, 103),
                child: Image.asset(
                  'images/logotb.jpg',
                  fit: BoxFit.contain,
                  height: 60,
                ),
              ),
              ListTile(
                title: Text(
                  'Beranda',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                onTap: () {
                  // Tambahkan navigasi ke halaman beranda
                },
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                onTap: () {
                  // Tambahkan navigasi ke halaman pengaturan
                },
              ),
              ListTile(
                title: Text(
                  'Help & Support',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(
                  Icons.help,
                  color: Colors.green,
                ),
                onTap: () {
                  // Tambahkan navigasi ke halaman bantuan
                },
              ),
              ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(
                  Icons.info,
                  color: Colors.orange,
                ),
                onTap: () {
                  // Tambahkan navigasi ke halaman tentang aplikasi
                },
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.brown,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List>(
        future: getProductData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ProductList(list: snapshot.data ?? [])
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List list;

  const ProductList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white, // Warna kontainer putih
            borderRadius: BorderRadius.circular(
                8.0), // Misalkan ingin tambahkan border radius
          ),
          child: ListTile(
            title: Text(list[i]['nama_item']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Stok : ${list[i]['stok']}"),
                Text("Harga : ${list[i]['harga']}"),
              ],
            ),
            leading: Icon(Icons.widgets),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    productName: list[i]['nama_item'],
                    productStock: list[i]['stok'],
                    productPrice: list[i]['harga'],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ProductDetail extends StatelessWidget {
  final String productName;
  final String productStock;
  final String productPrice;

  const ProductDetail({
    Key? key,
    required this.productName,
    required this.productStock,
    required this.productPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nama Produk: $productName',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Stok: $productStock',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Harga: $productPrice',
              style: TextStyle(fontSize: 18),
            ),
            // Tambahkan informasi atau aksi lainnya jika diperlukan
          ],
        ),
      ),
    );
  }
}
