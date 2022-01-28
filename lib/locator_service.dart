import 'package:flutter_clean1/core/error/exeption.dart';
import 'package:flutter_clean1/core/platform/network_info.dart';
import 'package:flutter_clean1/future/data/datasourses/person_local_datasourse.dart';
import 'package:flutter_clean1/future/data/datasourses/person_remote_datasourse.dart';
import 'package:flutter_clean1/future/data/repositories/person_repository_impl.dart';
import 'package:flutter_clean1/future/domain/repositories/person_repository.dart';
import 'package:flutter_clean1/future/domain/usecases/get_all_persons.dart';
import 'package:flutter_clean1/future/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_clean1/future/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_clean1/future/presentation/bloc/search_bloc/search_event.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(
    () => PersonListCubit(getAllPersons: sl()),
  );
  sl.registerFactory(
    () => PersonSearchBloc(searchPersons: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  // Repository
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSourse: sl(),
      localDataCourse: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSourse>(
    () => PersonRemoteDataSourseIml(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSourse>(
      () => PersonLocalDataSourseImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
