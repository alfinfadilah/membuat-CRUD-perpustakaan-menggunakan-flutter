import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key, required this.onAddBook});

  final Function(String, String, String) onAddBook;

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>(); // Key untuk form
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _penulisController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  Future<void> tambah(String judul, String penulis, String deskripsi) async {
    final response = await Supabase.instance.client.from('Buku').insert([
      {
        'judul': judul,
        'penulis': penulis,
        'deskripsi': deskripsi,
      }
    ]);

    if (response.error == null) {
      Navigator.pop(context);
       // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding book: ${response.error?.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tambah Buku',
          style: TextStyle(
            color: Color(0xFFFAF3E0),
          ),
        ),
        backgroundColor: const Color(0xFF003366),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _judulController,
                  decoration: const InputDecoration(
                    labelText: 'Judul Buku',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _penulisController,
                  decoration: const InputDecoration(
                    labelText: 'Penulis Buku',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Penulis tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _deskripsiController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi Buku',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi tidak boleh kosong';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        
                        widget.onAddBook(
                          _judulController.text,
                          _penulisController.text,
                          _deskripsiController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    ),
                    child: const Text(
                      'Tambah Buku',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFFFAF3E0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}