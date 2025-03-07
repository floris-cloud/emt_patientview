import 'package:flutter/material.dart';

import '../../models/mds.dart';

class MdsSelectionDialog extends StatefulWidget {
  // final MDS initialMds;
  // final Function(MDS) onMdsSaved;

  const MdsSelectionDialog({
    // required this.initialMds,
    // required this.onMdsSaved,
    super.key,
  });

  @override
  State<MdsSelectionDialog> createState() => _MdsSelectionDialogState();
}

class _MdsSelectionDialogState extends State<MdsSelectionDialog> {
  late Map<Type, Set<dynamic>> selectedValues;

  final categories = [
    _MdsCategory(
      title: 'Sex',
      values: MDSSex.values,

    ),
    _MdsCategory(
      title: 'Trauma',
      values: MDSTrauma.values,

    ),
    _MdsCategory(
      title: 'Infection',
      values: MDSInfection.values,
    )

    // Füge alle anderen Kategorien hier hinzu
  ];

  @override
  void initState() {
    super.initState();
    // selectedValues = {
    //   for (var category in categories)
    //     category.values.first.runtimeType: 
    //       Set.from(category.getter(widget.initialMds))
    // };
  }

  void _toggleSelection(dynamic value) {
    setState(() {
      final type = value.runtimeType;
      final values = selectedValues[type] ?? Set();
      if (values.contains(value)) {
        values.remove(value);
      } else {
        values.add(value);
      }
      selectedValues[type] = values;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("MDS Selection"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: categories.length,
          separatorBuilder: (context, _) => const Divider(height: 24),
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategorySection(category);
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _saveSelection,
          child: const Text("Save"),
        ),
      ],
    );
  }

  Widget _buildCategorySection(_MdsCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: category.values.length,
          itemBuilder: (context, index) {
            final value = category.values[index];
            return CheckboxListTile(
              title: Text(value.name),
              value: selectedValues[value.runtimeType]?.contains(value) ?? false,
              onChanged: (_) => _toggleSelection(value),
              dense: true,
              contentPadding: EdgeInsets.zero,
            );
          },
        ),
      ],
    );
  }

  void _saveSelection() {
    final newMds = MDS(id :"11", age: 0);
      // Füge alle anderen Kategorien hier hinzu
      

    // widget.onMdsSaved(newMds);
    Navigator.pop(context);
  }

  List<T> _getSelectedValues<T>() {
    return selectedValues[T]?.toList().cast<T>() ?? [];
  }
}

class _MdsCategory {
  final String title;
  final List<dynamic> values;

  _MdsCategory({
    required this.title,
    required this.values,
  });
}