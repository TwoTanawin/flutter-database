// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_database/main.dart';
import 'package:flutter_database/models/Transaction.dart';
import 'package:flutter_database/pages/homeScreen.dart';
import 'package:flutter_database/providers/transactionProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_database/main.dart';

// ignore: use_key_in_widget_constructors
class Form2 extends StatefulWidget {
  @override
  _Form2State createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  final formKey = GlobalKey<FormState>();

  //Controllder
  final titleCoontroller = TextEditingController();
  final amountCoontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Information Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Task Name'),
                autofocus: false,
                controller: titleCoontroller,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return "PLease Field Task";
                  }
                  return null;
                },
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  controller: amountCoontroller,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return "PLease Field Amount";
                    }
                    if (double.parse(str) <= 0) {
                      return "PLease Field grater then 0";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Your form is valid, perform necessary actions
                    var title = titleCoontroller.text;
                    var amount = amountCoontroller.text;

                    Transactions statement = Transactions(
                        title: title,
                        amount: double.parse(amount),
                        date: DateTime.now());

                    //Call Provider

                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);

                    provider.addTransaction(statement);

                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return MyHomePage(title: 'Accountant  APP');
                            }));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
