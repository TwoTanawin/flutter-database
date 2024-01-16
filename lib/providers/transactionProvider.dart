import 'package:flutter/foundation.dart';
import 'package:flutter_database/models/Transaction.dart';
import 'package:flutter_database/database/transactionDB.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransactions() {
    return transactions;
  }

  void initData() async {
    var db = TranscationDB(dbName: "transaction.db");

    // qurey data
    transactions = await db.loadALLData();

    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TranscationDB(dbName: "transaction.db");

    await db.InsertData(statement);

    // qurey data
    transactions = await db.loadALLData();

    // transactions.insert(0, statement);

    // Tell Consumer
    notifyListeners();
  }
}
