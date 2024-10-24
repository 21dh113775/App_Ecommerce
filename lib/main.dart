import 'package:ecommerce/presentation/blocs/Login_Bloc/login_bloc.dart';
import 'package:ecommerce/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/blocs/_Bloc/register_bloc.dart';
import 'routes/app_routes.dart';
import 'firebase/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => RegisterBloc()), // Khởi tạo RegisterBloc
        BlocProvider(
            create: (context) => LoginBloc(
                authService:
                    AuthService())), // Khởi tạo LoginBloc với AuthService
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grid',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        getPages: AppRoutes.routes,
        initialRoute: '/onboarding', // Onboarding là trang đầu tiên
      ),
    );
  }
}
