import 'dart:math';

import 'package:despesas/components/chart.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          primarySwatch: Colors.blue,
          fontFamily: 'Quicksand',
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blueAccent,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          buttonTheme: const ButtonThemeData(buttonColor: Colors.amber),
          useMaterial3: true,
          textTheme: ThemeData.light().textTheme.copyWith()),
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
      data: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transacao(
      id: 't2',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transacao(
      id: 't2',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transacao(
      id: 't3',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transacao(
      id: 't4',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transacao(
      id: 't5',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transacao(
      id: 't6',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transacao(
      id: 't7',
      titulo: 'Conta de Luz',
      valor: 211.30,
      data: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  List<Transacao> get _recent {
    return _transactions
        .where((element) => element.data
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  _addTrasaction(String titulo, double valor, DateTime data) {
    final newTrasaction = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: data,
    );

    setState(() {
      _transactions.add(newTrasaction);
    });

    Navigator.of(context).pop();
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
        title: const Text("Despesas Pessoais"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(_recent),
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
