import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectflut/login.dart';
import './detail.dart';
import './tambahdata.dart';

class Admin extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Admin> {
  TextEditingController _searchController = TextEditingController();

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://localhost/databasedims/getdata.php"));
    List fullList = json.decode(response.body);
    if (_searchController.text.isEmpty) {
      return fullList;
    } else {
      List filteredList = fullList.where((item) {
        return item['nama_item']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
      return filteredList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 55, 80),
      appBar: AppBar(
        title: Text(""),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 28, 32, 58),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                      color: Colors.black), // Atur warna pinggir saat diklik
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
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
              height: 60, // Sesuaikan tinggi gambar dengan kebutuhan
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // Tambahkan aksi untuk tombol STORE
                  },
                  child: Text(
                    'STORE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10), // Jarak antara tombol
                TextButton(
                  onPressed: () {
                    // Tambahkan aksi untuk tombol FAVORITE
                  },
                  child: Text(
                    'FAVORITE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    // Tambahkan aksi untuk tombol KOMUNITAS
                  },
                  child: Text(
                    'KOMUNITAS',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    // Tambahkan aksi untuk tombol PROFIL
                  },
                  child: Text(
                    'PROFIL',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
                  height: 60, // Sesuaikan tinggi gambar dengan kebutuhan
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
                  // Tambahkan navigasi ke halaman pengaturan profil
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
                  // Tambahkan navigasi ke halaman pengaturan aplikasi
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
                    fontWeight: FontWeight.bold, // Mengatur tebal tulisan
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.brown,
                ), // Menambahkan ikon logout di sebelah kiri teks
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "  SPORTS CAR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10), // Add some space between text and button
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.black,
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TambahData(),
                  )),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder<List>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? ItemList(
                          list: snapshot.data ?? [],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Detail(
                list: list,
                index: i,
              ),
            )),
            child: Card(
              child: ListView(
                shrinkWrap:
                    true, // Agar ListView dapat digunakan di dalam GridView
                children: [
                  Image.asset(
                    'images/${list[i]['gambar_filename']}',
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text(list[i]['nama_item']),
                    leading: Icon(Icons.widgets),
                    subtitle: Text("Stok : ${list[i]['stok']}"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
