import 'package:flutter/material.dart';
import '../widgets/patientCard_widget.dart';
import '../models/patient.dart';
import '../repository/patient_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllPatScreen extends StatefulWidget {
  const AllPatScreen({super.key});

  @override
  State<AllPatScreen> createState() => _AllPatScreenState();
}

class _AllPatScreenState extends State<AllPatScreen> {
  TextEditingController editingController = TextEditingController();
  List<Patient> allPatients = [];
  List<Patient> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  void _loadPatients() async {
    final patients = await PatientStorage.loadPatients();
    setState(() {
      allPatients = patients;
      filteredPatients = patients;
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredPatients = allPatients;
      });
    } else {
      setState(() {
        filteredPatients = allPatients
            .where((patient) => patient.surName.toLowerCase().contains(query.toLowerCase())||
          patient.preName.toLowerCase().contains(query.toLowerCase()),)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.allPatientsTitle),
      ),
      body: allPatients.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: filterSearchResults,
                    controller: editingController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.search,
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      return PatientCard(patient: filteredPatients[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}