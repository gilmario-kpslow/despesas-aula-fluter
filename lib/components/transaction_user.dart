// import 'dart:math';

// import 'package:despesas/components/transaction_form.dart';
// import 'package:despesas/components/transaction_list.dart';
// import 'package:despesas/models/transacao.dart';
// import 'package:flutter/material.dart';

// class TransactionUser extends StatefulWidget {
//   const TransactionUser({super.key});

//   @override
//   State<TransactionUser> createState() => _TransactionUserState();
// }

// class _TransactionUserState extends State<TransactionUser> {
//   final List<Transacao> _transactions = [
//     Transacao(
//       id: 't1',
//       titulo: 'Novo Tênis de Corrida',
//       valor: 310.76,
//       data: DateTime.now(),
//     ),
//     Transacao(
//       id: 't2',
//       titulo: 'Conta de Luz',
//       valor: 211.30,
//       data: DateTime.now(),
//     ),
//     // Transacao(
//     //   id: 't2',
//     //   titulo: 'Conta de Luz',
//     //   valor: 211.30,
//     //   data: DateTime.now(),
//     // ),
//     // Transacao(
//     //   id: 't3',
//     //   titulo: 'Conta de Luz',
//     //   valor: 211.30,
//     //   data: DateTime.now(),
//     // ),
//     // Transacao(
//     //   id: 't4',
//     //   titulo: 'Conta de Luz',
//     //   valor: 211.30,
//     //   data: DateTime.now(),
//     // ),
//     // Transacao(
//     //   id: 't5',
//     //   titulo: 'Conta de Luz',
//     //   valor: 211.30,
//     //   data: DateTime.now(),
//     // ),
//     // Transacao(
//     //   id: 't6',
//     //   titulo: 'Conta de Luz',
//     //   valor: 211.30,
//     //   data: DateTime.now(),
//     // ),
//     // Transacao(
//     //   id: 't7',
//     //   titulo: 'Conta de Luz',
//     //   valor: 211.30,
//     //   data: DateTime.now(),
//     // ),
//   ];

//   _addTrasaction(String titulo, double valor) {
//     final newTrasaction = Transacao(
//       id: Random().nextDouble().toString(),
//       titulo: titulo,
//       valor: valor,
//       data: DateTime.now(),
//     );

//     setState(() {
//       _transactions.add(newTrasaction);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TransactionForm(_addTrasaction),
//         TransactionList(_transactions),
//       ],
//     );
//   }
// }
