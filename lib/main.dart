import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'homepage.dart';

const supabaseUrl = 'https://lzyejjztndqwwqwloter.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://lzyejjztndqwwqwloter.supabase.co', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx6eWVqanp0bmRxd3dxd2xvdGVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1NTM5MjMsImV4cCI6MjA0NzEyOTkyM30.t9GJ4GPKHV5eTk-7__N_cEAxptYnGRy5QgKTiZeKFBk');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

