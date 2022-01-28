import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean1/common/app_colors.dart';
import 'package:flutter_clean1/future/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_clean1/future/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_clean1/locator_service.dart' as di;

import 'future/presentation/pages/person_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
            create: (context) => di.sl<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc>(
            create: (context) => di.sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground),
        home: const HomePage(),
      ),
    );
  }
}
