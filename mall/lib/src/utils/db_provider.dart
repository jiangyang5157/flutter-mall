import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DbProvider {
  static final DbProvider _instance = DbProvider._internal();

  factory DbProvider() {
    return _instance;
  }

  DbProvider._internal();

  static Database _db;
  static const String _db_name = 'database';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initialize();
    return _db;
  }

  Future<Database> _initialize() async {
    final String dbDirectory = (await getApplicationDocumentsDirectory()).path;
    final String dbPath = join(dbDirectory, _db_name);
    final DatabaseFactory dbFactory = databaseFactoryIo;
    return await dbFactory.openDatabase(dbPath);
  }
}
