import 'package:flutter/foundation.dart';
import 'package:flutter_database/models/Transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [
    // Transaction(title: "Book", amount: 500, date: DateTime.now()),
    // Transaction(title: "Movie", amount: 1000, date: DateTime.now()),
    // Transaction(title: "Bus", amount: 25, date: DateTime.now()),
  ];

  List<Transaction> getTransactions() {
    return transactions;
  }

  void addTransaction(Transaction statement) {
    transactions.insert(0, statement);

    //Tell Consumer
    notifyListeners();
  }
}
