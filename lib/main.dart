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
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

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
  final List<Transacao> _transactions = [];
  bool _showChart = false;

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

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool land = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      actions: [
        if (land)
          IconButton(
              onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
              },
              icon: _showChart
                  ? const Icon(Icons.list)
                  : const Icon(Icons.show_chart)),
        IconButton(
            onPressed: () {
              _openTransactionFormModal(context);
            },
            icon: const Icon(Icons.add)),
      ],
      title: Text(
        "Despesas Pessoais",
        style:
            TextStyle(fontSize: (20 * MediaQuery.of(context).textScaleFactor)),
      ),
    );

    final avaliableHeigth = MediaQuery.of(context).size.height;
    -appBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // if (land)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const Text("Exibir Gráfico"),
          //       Switch(
          //           value: _showChart,
          //           onChanged: (v) {
          //             setState(() {
          //               _showChart = v;
          //             });
          //           }),
          //     ],
          //   ),
          if (_showChart || !land)
            SizedBox(
                height: land ? avaliableHeigth * 0.7 : avaliableHeigth * 0.3,
                child: Chart(_recent)),
          if (!_showChart || !land)
            SizedBox(
                height: avaliableHeigth * 0.7,
                child: TransactionList(_transactions, _deleteTransaction)),
        ]),
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
