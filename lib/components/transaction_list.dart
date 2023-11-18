import 'package:despesas/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transacoes, {super.key});

  final List<Transacao> transacoes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
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
                  child: Row(children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'R\$ ${tr.valor.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.titulo,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('d MMM y').format(tr.data),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ]),
                );
              }),
    );
  }
}
