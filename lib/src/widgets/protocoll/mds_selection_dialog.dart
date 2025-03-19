import 'package:emt_patientview/src/models/protocol.dart';
import 'package:flutter/material.dart';
import '../../models/mds.dart';
import '../../models/patient.dart';

class MdsSelectionDialog extends StatefulWidget {
  final Protocol protocol;
  final Patient patient;
  const MdsSelectionDialog({
    super.key,
    required this.protocol, required this.patient
  });

  @override
  State<MdsSelectionDialog> createState() => _MdsSelectionDialogState();
}

class _MdsSelectionDialogState extends State<MdsSelectionDialog> {
  late MDS selectedValues;

  @override
  void initState() {
    super.initState();
    if (widget.protocol.mds != null) {
      selectedValues = widget.protocol.mds!;
    } else {
      widget.protocol.mds =
          MDS(age: widget.patient.getAge(), id: widget.patient.id);
      selectedValues = widget.protocol.mds!;
    }
      selectedValues.mdsFromPatient(widget.patient, widget.protocol);
  }

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
    ),
    _MdsCategory(
      title: 'Additional',
      values: MDSAdditional.values,
    ),
    _MdsCategory(
      title: 'Other Keydiseases',
      values: MDSOtherKeydiseases.values,
    ),
    _MdsCategory(
      title: 'Procedure',
      values: MDSProcedure.values,
    ),
    _MdsCategory(
      title: 'Outcome',
      values: MDSOutcome.values,
    ),
    _MdsCategory(
      title: 'Relation',
      values: MDSRelation.values,
    ),
    _MdsCategory(
      title: 'Protection',
      values: MDSProtection.values,
    ),
  ];

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
            return _buildCategorySection(category, index);
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

  Widget _buildCategorySection(_MdsCategory category, int index) {
    final type = category.values.first.runtimeType;
    final selectedInCategory =
        selectedValues.mdsList.where((item) => item.runtimeType == type).toList();

    return ExpansionTile(
      initiallyExpanded: selectedInCategory.isEmpty,
      title: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: category.title),
            if (selectedInCategory.isNotEmpty)
              TextSpan(
                text: ' (${selectedInCategory.map((e) => e.name).join(', ')})',
                style: const TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: category.values.length,
          itemBuilder: (context, valueIndex) {
            final value = category.values[valueIndex];
            return CheckboxListTile(
              title: Text(value.name),
              value: selectedValues.mdsList.contains(value),
              onChanged: (_) {
                setState(() {
                  if (selectedValues.mdsList.contains(value)) {
                    selectedValues.mdsList.remove(value);
                    selectedInCategory.remove(value);
                  } else {
                    selectedValues.mdsList.add(value);
                    selectedInCategory.add(value);
                  }
                });
              },
              //dense: true,
            );
          },
        ),
      ],
    );
  }

  void _saveSelection() {
    widget.patient.protocls!.last.mds = selectedValues;
    Navigator.pop(context);
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