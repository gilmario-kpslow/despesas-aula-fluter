import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {super.key});

  final void Function(String, double) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final tituloController = TextEditingController();

  final valorController = TextEditingController();

  _submitForm() {
    final title = tituloController.text;
    final value = double.tryParse(valorController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value);
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
            controller: tituloController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Valor R\$"),
            controller: valorController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitForm(),
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
