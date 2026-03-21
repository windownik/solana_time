import 'package:get_it/get_it.dart';

import '../data/repository/main_api_impl.dart';
import '../domain/repository/i_main_api.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<IMainApi>(() => MainApi());
}
