import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {required this.label,
      required this.valor,
      required this.percentual,
      super.key});

  final String label;
  final double valor;
  final double percentual;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, contraints) {
      return Column(
        children: [
          SizedBox(
              height: contraints.maxHeight * 0.15,
              child: FittedBox(child: Text(valor.toStringAsFixed(2)))),
          SizedBox(
            height: contraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: contraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentual,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: contraints.maxHeight * 0.05,
          ),
          Container(
              height: contraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
