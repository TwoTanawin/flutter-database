import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:flutter_database/models/Transaction.dart';

class TranscationDB {
  String dbName;

  TranscationDB({
    required this.dbName,
  });

  Future<Database> openDatabase() async {
    var appDir = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDir.path, dbName);

    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);

    return db;
  }

  // save data
  Future<int> InsertData(Transactions statement) async {
    // data => to store

    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String(),
    });

    db.close();

    return keyID;
  }

  // load data
  Future<List<Transactions>> loadALLData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    var snapShort = await store.find(db,
        // sort false : old => new
        // sort false : new => old
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));

    List<Transactions> transcationLIST = [];
    for (var record in snapShort) {
      transcationLIST.add(Transactions(
        title: record["title"] as String,
        amount: (record["amount"] as num?)?.toDouble() ?? 0.0,
        date: DateTime.parse(record["date"] as String),
      ));
    }

    return transcationLIST; // Return the populated list
  }
}
