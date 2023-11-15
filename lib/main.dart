import 'dart:math';

import 'package:despesas/components/transaction_form.dart';
import 'package:despesas/components/transaction_list.dart';
import 'package:despesas/models/transacao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FinanceiroApp());
}

class FinanceiroApp extends StatelessWidget {
  const FinanceiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanceiroApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: const HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final List<Transacao> _transactions = [
    Transacao(
      id: 't1',
      titulo: 'Novo Tênis de Corrida',
      valor: 310.76,
      data: DateTime.now(),
    ),
    Transacao(
      id: 't2',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now(),
    ),
    // Transacao(
    //   id: 't2',
    //   titulo: 'Conta de Luz',
    //   valor: 211.30,
    //   data: DateTime.now(),
    // ),
    // Transacao(
    //   id: 't3',
    //   titulo: 'Conta de Luz',
    //   valor: 211.30,
    //   data: DateTime.now(),
    // ),
    // Transacao(
    //   id: 't4',
    //   titulo: 'Conta de Luz',
    //   valor: 211.30,
    //   data: DateTime.now(),
    // ),
    // Transacao(
    //   id: 't5',
    //   titulo: 'Conta de Luz',
    //   valor: 211.30,
    //   data: DateTime.now(),
    // ),
    // Transacao(
    //   id: 't6',
    //   titulo: 'Conta de Luz',
    //   valor: 211.30,
    //   data: DateTime.now(),
    // ),
    // Transacao(
    //   id: 't7',
    //   titulo: 'Conta de Luz',
    //   valor: 211.30,
    //   data: DateTime.now(),
    // ),
  ];

  _addTrasaction(String titulo, double valor) {
    final newTrasaction = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTrasaction);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTrasaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _openTransactionFormModal(context);
                },
                icon: const Icon(Icons.add))
          ],
          title: const Text(
            "Despesas Pessoais",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            child: Card(
              elevation: 5.0,
              color: Colors.blue,
              child: Text("Grafico"),
            ),
          ),
          TransactionList(_transactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openTransactionFormModal(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
