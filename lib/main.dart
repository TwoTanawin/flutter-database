// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_database/models/Transaction.dart';
import 'package:flutter_database/pages/Form2.dart';
import 'package:flutter_database/pages/homeScreen.dart';
import 'package:flutter_database/providers/transactionProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Accountant  APP'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.purple[200],
        body: TabBarView(
          children: [
            HomeScreen(),
            Form2(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.list),
              text: "Task of Transaction",
            ),
            Tab(
              icon: Icon(Icons.add),
              text: "Edit Imformation",
            ),
          ],
        ),
      ),
    );
  }
}
