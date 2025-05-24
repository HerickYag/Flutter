import 'package:flutter/material.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/state/cart.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/state/count.dart';
import 'package:provider/provider.dart';

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Provider App (${context.watch<Count>().count})'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${context.watch<Cart>().count})'),
            Text('${context.watch<Cart>().cart})'),
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        key: Key('addItem_floatingActionButton'),
        onPressed:() => context.read<Cart>().addItem('novo item ❤'), 
        tooltip: 'Adicionar novo item!',
        child: const Icon(Icons.add),
      )
    );
  }
}
