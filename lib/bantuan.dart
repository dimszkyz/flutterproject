import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'Bagaimana cara membuat akun?',
      'answer':
          'Untuk membuat akun, klik tombol "Daftar" dan ikuti langkah-langkahnya.'
    },
    {
      'question': 'Bagaimana jika lupa password?',
      'answer':
          'Jika Anda lupa password, klik "Lupa Password" di layar login dan ikuti petunjuknya.'
    },
    {
      'question': 'Bagaimana cara melakukan login?',
      'answer':
          'Untuk login, masukkan username dan password Anda di layar login.'
    },
    {
      'question': 'Bagaimana cara mengubah pengaturan profil?',
      'answer':
          'Anda dapat mengubah pengaturan profil dengan masuk ke akun dan mengunjungi halaman "Pengaturan".'
    },
    {
      'question': 'Apakah akun bisa dihapus?',
      'answer':
          'Ya, Anda bisa menghapus akun dengan mengunjungi halaman "Hapus Akun" dalam pengaturan.'
    },
    {
      'question': 'Bagaimana cara menghubungi dukungan pelanggan?',
      'answer':
          'Anda dapat menghubungi dukungan pelanggan melalui email kami di support@contoh.com.'
    },
    {
      'question': 'Apakah ada biaya untuk membuat akun?',
      'answer': 'Tidak, membuat akun di platform kami gratis.'
    },
    {
      'question': 'Bagaimana cara mengubah kata sandi?',
      'answer':
          'Untuk mengubah kata sandi, masuk ke akun lalu pilih opsi "Ubah Kata Sandi".'
    },
    {
      'question': 'Apakah informasi pribadi aman di platform ini?',
      'answer':
          'Kami mengambil langkah-langkah keamanan yang ketat untuk melindungi informasi pribadi Anda.'
    },
    {
      'question': 'Bagaimana cara melakukan verifikasi akun?',
      'answer':
          'Anda dapat melakukan verifikasi akun dengan mengikuti petunjuk yang dikirimkan ke email Anda saat mendaftar.'
    },
    // Tambahkan pertanyaan dan jawaban lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pertanyaan Umum"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.grey,
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ExpansionTile(
                  title: Text(faqs[index]['question']!),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(faqs[index]['answer']!),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
