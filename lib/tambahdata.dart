import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectflut/admin.dart';


class TambahData extends StatefulWidget {
  @override
  _TambahDataState createState() => new _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  TextEditingController controllerKode = new TextEditingController();
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerStok = new TextEditingController();

  @override
  void TambahData() {
    var url = Uri.parse ("http://localhost/databasedims/tambahdata.php");

    http.post(url, body: {
      "kode_item": controllerKode.text,
      "nama_item": controllerNama.text,
      "harga": controllerHarga.text,
      "stok": controllerStok.text,
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 147, 18, 18),
        title: new Text("Tambah Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerKode,
                  decoration: new InputDecoration(
                      hintText: "Kode Item", labelText: "Kode Item"),
                ),
                new TextField(
                  controller: controllerNama,
                  decoration: new InputDecoration(
                      hintText: "Nama Item", labelText: "Nama Item"),
                ),
                new TextField(
                  controller: controllerHarga,
                  decoration: new InputDecoration(
                      hintText: "Harga", labelText: "Harga"),
                ),
                new TextField(
                  controller: controllerStok,
                  decoration:
                      new InputDecoration(hintText: "Stok", labelText: "Stok"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                MaterialButton(
                  child: new Text("Tambah Data"),
                  color: Colors.green,
                  onPressed: () {
                    TambahData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Admin()),
                    ).then((value) => setState(() {}));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}