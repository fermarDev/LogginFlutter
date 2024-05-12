import 'package:flutter/material.dart';
import 'package:logginapp/src/auth/loginAuth.dart';
import 'package:logginapp/src/providers/menu_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(checkTokenFuture: menuProvider.checkToken()));
}

class MyApp extends StatelessWidget {
  final Future<bool> checkTokenFuture;
  const MyApp({super.key, required this.checkTokenFuture});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:FutureBuilder(
        future: checkTokenFuture, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            bool sesion = snapshot.data ?? false;
            if (sesion) {
              print('con sesión');
              return const LoginAuth(); // Pantalla principal si el usuario está autenticado
            } else {

              print('sin sesión');
              return const LoginAuth(); // Pantalla de login si no hay sesión
            }
          }
        },)
    );

  }

 
}
