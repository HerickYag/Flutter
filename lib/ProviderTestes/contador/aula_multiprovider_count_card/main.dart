import 'package:flutter/material.dart';
import 'routes/routeGenerator.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/state/cart.dart';
import 'state/count.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// usando mais de um provider para armazenar os dados entre telas!
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),//modelo cart
        ChangeNotifierProvider(create: (_) => Count()),//modelo count
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  
  // Lembrar de routeGenerator para navegar entre telas!
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteGenerator.home,
      onGenerateRoute: RouteGenerator.generateRoute,
     );
  }
}