import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> prefList;
  final List<String> lista;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.prefList, this.lista,
      {required this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(widget.lista),
    );
  }

  _buildChoiceList(List<String> lista) {
    List<Widget> choices = [];

    widget.prefList.forEach((element) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(element),
          selected: lista.contains(element),
          onSelected: (selected) {
            setState(() {
              lista.contains(element)
                  ? lista.remove(element)
                  : lista.add(element);
              widget.onSelectionChanged(lista);
            });
          },
        ),
      ));
    });
    return choices;
  }
}
