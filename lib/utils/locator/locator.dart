import 'package:get_it/get_it.dart';
import 'package:weather_auth_app_with_bloc/repository/user_repository.dart';
import 'package:weather_auth_app_with_bloc/repository/weather_repository.dart';
import 'package:weather_auth_app_with_bloc/service/firebase_auth_service.dart';
import 'package:weather_auth_app_with_bloc/service/weather_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => UserRepository());
  getIt.registerLazySingleton(() => WeatherService());
  getIt.registerLazySingleton(() => WeatherRepository());
}
