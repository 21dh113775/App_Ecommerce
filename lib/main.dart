// main.dart
import 'package:ecommerce/Data/Model/Repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'presentation/blocs/Login_Bloc/login_bloc.dart';
import 'presentation/blocs/Product_Bloc/product_bloc.dart';
import 'presentation/blocs/Product_Bloc/product_event.dart';
import 'presentation/blocs/Register_Bloc/register_bloc.dart';
import 'services/auth_service.dart';
import 'routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    RepositoryProvider(
      create: (context) => ProductRepository(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(authService: AuthService()),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(RepositoryProvider.of<ProductRepository>(context))
                ..add(LoadProducts()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grid',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        getPages: AppRoutes.routes,
        initialRoute: '/onboarding',
      ),
    );
  }
}
