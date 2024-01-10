import 'package:despesas/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transacoes, this.delete, {super.key});

  final List<Transacao> transacoes;
  final Function(String id) delete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: transacoes.isEmpty
          ? Column(children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Nenhuma transação",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              )
            ])
          : ListView.builder(
              itemCount: transacoes.length,
              itemBuilder: (context, index) {
                final tr = transacoes[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 28,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            'R\$ ${tr.valor}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.titulo,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.data),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        delete(tr.id);
                      },
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                );
              }),
    );
  }
}
