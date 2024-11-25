import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpustakaan/insert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Map<String, dynamic>> Buku = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client.
    from('Buku').select();

    setState(() {
      Buku = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> tambah(String title, String author, String description) async {
    final response = await Supabase.instance.client.from('Buku').insert([
      {
        'judul': title,
        'penulis': author,
        'deskripsi': description,
      }
    ]);

    if (response.error == null) {
      fetchBooks(); // Refresh the list after adding a new book
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
        title: Text(
          'Daftar Buku',
          style: GoogleFonts.lora(
            color: Color(0xFFFAF3E0),
          ),
        ),
        backgroundColor: const Color(0xFF003366),
        actions: [
          IconButton(
            onPressed: fetchBooks,
            icon: const Icon(Icons.refresh),
            color: Color(0xFFFAF3E0),
          ),
        ],
      ),
      body: Buku.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: Buku.length,
              itemBuilder: (context, index) {
                final book = Buku[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: Colors.white, // White card background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                        color: Color(0xFF003366), width: 1), // Navy blue border
                  ),
                  child: ListTile(
                    title: Text(
                      book['judul'] ?? 'No Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['penulis'] ?? 'No Author',
                          style: TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                        Text(
                          book['deskripsi'] ?? 'No Description',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBookDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          ),
        backgroundColor: const Color(0xFF003366),
      ),
    );
  }
 void _showAddBookDialog(BuildContext context)  async{
    final result= await showDialog<bool>(
      context: context,
      builder: (context) {
        return AddBookPage(onAddBook: (title, author, description) {
          tambah(title, author, description);
          Navigator.pop(context,true);
        }
        );
        
      },
    );
    if(result==true){
      fetchBooks();
    }
  }
}

