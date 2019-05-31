import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> getDb() async {
  final String dbDirectory = (await getApplicationDocumentsDirectory()).path;
  final String dbPath = join(dbDirectory, 'database');
  print('#### dbDirectory=$dbDirectory');
  print('#### dbPath=$dbPath');
  final DatabaseFactory dbFactory = databaseFactoryIo;
  return await dbFactory.openDatabase(dbPath);
}
