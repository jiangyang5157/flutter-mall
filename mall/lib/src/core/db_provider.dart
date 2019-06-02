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

  Database get db => _db;

  /// Must be called before use
  Future<void> initialize() async {
    final String dbDirectory = (await getApplicationDocumentsDirectory()).path;
    final String dbPath = join(dbDirectory, _db_name);
    final DatabaseFactory dbFactory = databaseFactoryIo;
    _db = await dbFactory.openDatabase(dbPath);
  }
}
