import 'package:flutter/material.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/state/cart.dart'; //
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/state/count.dart'; //
import 'package:provider/provider.dart';
import 'dart:math'; // For generating distinct new items, optional

class Second extends StatefulWidget {
  const Second({super.key}); //

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> _displayedItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize the local list with items from the Cart provider
    // We use listen: false because this is a one-time initialization.
    // The list will be updated manually upon adding new items.
    final cart = Provider.of<Cart>(context, listen: false);
    _displayedItems = List.from(cart.cart); //
  }

  // Helper method to build each item with an animation
  Widget _buildAnimatedItem(
      BuildContext context, String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: -1.0, // Item grows from top to bottom
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          title: Text(item),
        ),
      ),
    );
  }

  void _addItem() {
    final cartProvider = context.read<Cart>(); //
    // Example: create a new unique item string
    final String newItem =
        'novo item ❤ ${Random().nextInt(100)}'; // You can customize your new item

    // 1. Determine the index for insertion
    final int insertIndex = _displayedItems.length;

    // 2. Add to the Cart provider (updates global state and other listeners like the count)
    cartProvider.addItem(newItem); //

    // 3. Add to the local list that AnimatedList uses
    _displayedItems.insert(insertIndex, newItem);

    // 4. Trigger the animation in AnimatedList
    _listKey.currentState
        ?.insertItem(insertIndex, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Provider App (${context.watch<Count>().count})'), //
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Itens no carrinho: ${context.watch<Cart>().count}', // Displays the count from Cart provider //
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _displayedItems.length,
              itemBuilder: (context, index, animation) {
                // Check bounds to be safe, though _displayedItems should be in sync
                if (index < _displayedItems.length) {
                  return _buildAnimatedItem(
                      context, _displayedItems[index], animation);
                }
                return const SizedBox.shrink(); // Should not happen
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('addItem_floatingActionButton'), //
        onPressed: _addItem,
        tooltip: 'Adicionar novo item!', //
        child: const Icon(Icons.add), //
      ),
    );
  }
}
