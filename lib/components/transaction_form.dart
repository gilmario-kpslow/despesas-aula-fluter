import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {super.key});

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();

  late DateTime _selectedDate;

  _submitForm() {
    final title = _tituloController.text;
    final value = double.tryParse(_valorController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: const InputDecoration(labelText: "Titulo"),
            controller: _tituloController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Valor R\$"),
            controller: _valorController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitForm(),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                // ignore: unnecessary_null_comparison
                Text(_selectedDate == null
                    ? "Nenhuma data selecionada!"
                    : DateFormat('dd/MM/y').format(_selectedDate)),
                ElevatedButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      "Selecionar Data",
                      style: Theme.of(context).textTheme.titleSmall,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(color: Colors.purple),
                )),
          )
        ]),
      ),
    );
  }
}
