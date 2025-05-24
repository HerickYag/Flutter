import 'package:flutter/material.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/routes/routeGenerator.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/state/count.dart';


import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Multi Provider App (${context.watch<Count>().count})'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('O botão foi clicado na seguinte quantidade:'),
            Counter(),
            ElevatedButton(
              onPressed: (){Navigator.of(context).pushNamed(RouteGenerator.second);}, 
              child: Text('nova tela'))
          ],
        ),
      ), 
      floatingActionButton: FloatingActionButton(
        key: Key('increment_floatingActionButton'),
        onPressed:() => context.read<Count>().increment(),//read acessa o  
                                                          //componente sem ter 
                                                          //inscricao no model 
                                                     
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      )
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${context.watch<Count>().count}',// watch se inscreve para receber 
                                        // atualizações do estado do model
      style: Theme.of(context).textTheme.headlineMedium,
      key: Key('counterState'),
    );
  }
}