import 'dart:io';
import 'dart:math';

import 'package:despesas/components/chart.dart';
import 'package:despesas/components/transaction_form.dart';
import 'package:despesas/components/transaction_list.dart';
import 'package:despesas/models/transacao.dart';
import 'package:flutter/cupertino.dart';
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

  Widget _getButton(Icon icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
          )
        : IconButton(
            onPressed: fn,
            icon: icon,
          );
  }

  @override
  Widget build(BuildContext context) {
    bool land = MediaQuery.of(context).orientation == Orientation.landscape;

    final titulo = Text(
      "Despesas Pessoais",
      style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor),
    );

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final List<Widget> actions = [
      if (land)
        _getButton(_showChart ? Icon(iconList) : Icon(chartList), () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getButton(const Icon(Icons.add), () {
        _openTransactionFormModal(context);
      }),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: titulo,
            trailing: Column(
              children: actions,
            )) as PreferredSizeWidget
        : AppBar(actions: actions, title: titulo);

    final avaliableHeigth = MediaQuery.of(context).size.height;
    -appBar.preferredSize.height - MediaQuery.of(context).padding.top;

    final body = SafeArea(
      child: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: body)
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      _openTransactionFormModal(context);
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
