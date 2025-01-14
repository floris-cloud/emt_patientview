import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/patient.dart';
import '../../repository/patient_repository.dart';

abstract class PatientListEvent {}

class LoadPatients extends PatientListEvent {}

class AddPatient extends PatientListEvent {
  final Patient patient;

  AddPatient(this.patient);
}

abstract class PatientListState {}

class PatientListInitial extends PatientListState {}

class PatientListLoading extends PatientListState {}

class PatientListLoaded extends PatientListState {
  final List<Patient> patients;

  PatientListLoaded(this.patients);
}

class PatientListError extends PatientListState {
  final String message;

  PatientListError(this.message);
}

class PatientListBloc extends Bloc<PatientListEvent, PatientListState> {


  PatientListBloc() 
  : super(PatientListInitial());

  Stream<PatientListState> mapEventToState(PatientListEvent event) async* {
    if (event is LoadPatients) {
      yield PatientListLoading();
      try {
        final patients = await PatientStorage.loadPatients();
        yield PatientListLoaded(patients);
      } catch (e) {
        yield PatientListError(e.toString());
      }
    } else if (event is AddPatient) {
      try {
        await PatientStorage.savePatient(event.patient);
        final patients = await PatientStorage.loadPatients();
        yield PatientListLoaded(patients);
      } catch (e) {
        yield PatientListError(e.toString());
      }
    }
  }
}