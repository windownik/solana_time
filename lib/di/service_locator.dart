
import 'package:get_it/get_it.dart';

import '../domain/repository/api.dart';

final getIt = GetIt.instance;


void setupGetIt() {
  getIt.registerLazySingleton<MainApi>(() => MainApi());
}