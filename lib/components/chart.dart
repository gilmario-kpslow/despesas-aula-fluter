import 'package:despesas/components/chart_bar.dart';
import 'package:despesas/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.transacoes, {super.key});

  final List<Transacao> transacoes;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      DateFormat.E().format(weekDay)[0];

      double total = 0.0;
      for (var i = 0; i < transacoes.length; i++) {
        bool sameDay = transacoes[i].data.day == weekDay.day;
        bool sameMonth = transacoes[i].data.month == weekDay.month;
        bool sameYear = transacoes[i].data.year == weekDay.year;

        if (sameYear && sameDay && sameMonth) {
          total += transacoes[i].valor;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': total,
      };
    }).reversed.toList();
  }

  double get _totalSemana {
    return groupedTransactions.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: (tr['day'] as String),
                  valor: (tr['value'] as double),
                  percentual: _totalSemana == 0
                      ? 0
                      : (tr['value'] as double) / _totalSemana),
            );
          }).toList(),
        ),
      ),
    );
  }
}
