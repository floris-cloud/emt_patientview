import 'package:emt_patientview/src/models/protocol.dart';
import 'package:flutter/material.dart';
import '../../models/mds.dart';
import '../../models/patient.dart';

class MdsRows extends StatefulWidget {
  final Patient patient;
  final Protocol protocol;

  const MdsRows({
    super.key,
    required this.patient,
    required this.protocol,
  });

  @override
  _MdsRowsState createState() => _MdsRowsState();
}

class _MdsRowsState extends State<MdsRows> {
  late MDS selectedValues;

  @override
  void initState() {
    super.initState();
    if (widget.protocol.mds != null) {
      selectedValues = widget.protocol.mds!;
    } else {
      widget.protocol.mds = MDS(age: widget.patient.getAge(), id: widget.patient.id);
      selectedValues = widget.protocol.mds!;
    }
    selectedValues.mdsFromPatient(widget.patient, widget.protocol);
  }

  @override
  Widget build(BuildContext context) {
    List<MdsCategory> categories = MDS.getMDSCategory();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...categories.map((category) => _buildCategorySection(category)).toList(),
      ],
    );
  }

  Widget _buildCategorySection(MdsCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category.title),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: category.values.map((value) {
            return ChoiceChip(
              label: Text(value.name),
              showCheckmark: false,
              selected: selectedValues.mdsList.contains(value),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedValues.mdsList.removeWhere((mds) => mds.runtimeType == value.runtimeType);
                    selectedValues.mdsList.add(value);
                  } else {
                    selectedValues.mdsList.remove(value);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}