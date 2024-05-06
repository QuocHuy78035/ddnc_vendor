import 'package:ddnangcao_project/providers/add_food_provider.dart';
import 'package:ddnangcao_project/providers/category_provider.dart';
import 'package:ddnangcao_project/providers/menu_provider.dart';
import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/views/merchant_auth/login_screen.dart';
import 'features/main/views/navbar_custom.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => OrderProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CategoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddFoodProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => MenuProvider(),
          ),
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String accessToken = '';

  getUserData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString("accessToken") ?? "";
  }

  @override
  void initState(){
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
        home: accessToken != ""  ? CustomerHomeScreen() : LoginScreen(),
      //home: RegisterStoreScreen(email: '',),
    );
  }
}


