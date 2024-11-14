import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Map<String, dynamic>> Buku = [];

  @override

  void iniState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client
      .from('Buku')
      .select();

    setState(() {
      Buku = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku'),
        actions: [
          IconButton(
            onPressed: fetchBooks,
             icon: const Icon(Icons.refresh)
          ),
        ],
      ),
      body: Buku.isEmpty
        ? const Center(child: CircularProgressIndicator(),)
        : ListView.builder(
          itemCount: Buku.length,
          itemBuilder: (context, index) {
            final book = Buku[index];
            return ListTile(
              title: Text(
                book['title'] ?? 'No Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book['author'] ?? 'No Author',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  Text(
                    book['description'] ?? 'No Description',
                    style: TextStyle(
                      fontSize: 12
                    ),
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
                    icon: const Icon(Icons.edit, color: Colors.blue,)
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,);
                    }, 
                    icon: const Icon(Icons.delete, color: Colors.red,)
                  ),
                ],
              ),
            );
          }
        )
    );
  }
}