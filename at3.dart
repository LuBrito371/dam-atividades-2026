import 'package:flutter/material.dart';

void main() {
  runApp(const PedidoFlashApp());
}

class PedidoFlashApp extends StatelessWidget {
  const PedidoFlashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedido Flash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

class Produto {
  final String nome;
  final double preco;
  final IconData icone;

  const Produto({
    required this.nome,
    required this.preco,
    required this.icone,
  });
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  static const List<Produto> _produtos = [
    Produto(
      nome: 'Pizza de calabresa com cebola e azeitonas',
      preco: 45.00,
      icone: Icons.local_pizza,
    ),
    Produto(
      nome: 'Suco de laranja',
      preco: 12.00,
      icone: Icons.local_cafe,
    ),
    Produto(
      nome: 'Hambúrguer duplo',
      preco: 32.00,
      icone: Icons.lunch_dining,
    ),
    Produto(
      nome: 'Pão de queijo',
      preco: 8.00,
      icone: Icons.bakery_dining,
    ),
  ];

  String _formatarPreco(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido Flash'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              margin: EdgeInsets.zero,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu Caixa',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Novo pedido'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Histórico'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cardápio rápido',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _produtos.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final produto = _produtos[index];
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      child: Row(
                        children: [
                          Icon(produto.icone, size: 24),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              produto.nome,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _formatarPreco(produto.preco),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}