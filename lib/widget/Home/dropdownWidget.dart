import 'package:flutter/material.dart';
import 'package:task_flutter/helper/cash.dart';
import 'package:task_flutter/model/Employee/employee.dart';
import 'package:task_flutter/widget/Home/button.dart';

class MultiSelectDropdownScreen extends StatefulWidget {
  ValueChanged assignedTo;

  MultiSelectDropdownScreen({Key? key, required this.assignedTo})
      : super(key: key);

  @override
  _MultiSelectDropdownScreenState createState() =>
      _MultiSelectDropdownScreenState();
}

class _MultiSelectDropdownScreenState extends State<MultiSelectDropdownScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployees();
  }

  void getEmployees() async {
    _options = await loadEmployees();
  }

  List<Employee> _options = [];
  List<String> _selectedOptions = [];

  void _showMultiSelectDialog() async {
    final List<String>? selectedValues = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(_options, _selectedOptions);
      },
    );

    if (selectedValues != null) {
      setState(() {
        _selectedOptions = selectedValues;
        widget.assignedTo(_selectedOptions);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onPressed: _showMultiSelectDialog,
      width: MediaQuery.of(context).size.width * 0.5,
      text: 'Select Options',
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<Employee> options;
  final List<String> initiallySelected;

  const MultiSelectDialog(this.options, this.initiallySelected, {super.key});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String>? _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List.from(widget.initiallySelected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Employee'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.options.map((option) {
            return CheckboxListTile(
              value: _selectedOptions!.contains(option.id),
              title: Text(option.name),
              onChanged: (bool? selected) {
                setState(() {
                  if (selected!) {
                    _selectedOptions!.add(option.id);
                  } else {
                    _selectedOptions!.remove(option.id);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(_selectedOptions),
        ),
      ],
    );
  }
}
