import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/theme/data/models/theme_model.dart';

abstract class ThemeRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<ThemeModel> fetchTheme();
}

class ThemeRemoteDataSourceImpl implements ThemeRemoteDataSource {
  ThemeRemoteDataSourceImpl();

  @override
  Future<ThemeModel> fetchTheme() {
    throw ServerException();
  }
}
