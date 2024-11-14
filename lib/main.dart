import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/ui/cubit/anasayfa_cubit.dart';
import 'package:todos/ui/views/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // MultiBlocProvider doğru kullanım
      providers: [
        BlocProvider(create: (context) =>AnasayfaCubit()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AnasayfaCubit()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Anasayfa(),
        ),
      ),
    );
  }
}
