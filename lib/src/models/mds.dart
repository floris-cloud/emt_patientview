class MDS{
String id;
int age;
List<dynamic> mdsList = [];

MDS({
  required this.id,
  required this.age
});

Map<String, dynamic> toJson() {
  List<int> mds = [];
  mdsList.forEach((element) {
    mds.add(element.id);
  });
 return {
  'id': id,
  'age': age,
  'mds': mds,
};
}
}
enum MDSSex{
  male(name:"male", id:1),
  femaleNotPregnant(name: "female", id:2),
  femalePregnant(name: "female pregnant", id:3),;
const MDSSex({
    required this.name,
    required this.id
  });
  final String name;
  final int id;
}

enum MDSTrauma{
 majorHeadSpineInjury(name: "major head/spine injury", id:4),
 majorTorsoInjury(name: "major torso injury", id:5),
 majorExtremityInjury(name: "major extremity injury", id:6),
 moderateInjury(name: "moderate injury", id:7),
 minorInjury(name: "minor injury", id:8);

 const MDSTrauma({
    required this.name,
    required this.id
  });
  final String name;
  final int id;

}
enum MDSInfection{
 acuteRespiratoryInfection(name: "acute respiratory infection", id:9),
  acuteWateryDiarrhea(name: "acute watery diarrhea", id:10),
  acuteBloodyDiarrhea(name: "acute bloody diarrhea", id:11),
  acuteIaundiceSyndrome(name: "acute jaundice syndrome", id:12),
  suspectedMeasles(name: "suspected measles", id:13),
  suspectedMeningitis(name: "suspected meningitis", id:14),
  suspectedTetanus(name: "suspected tetanus", id:15),
  acuteFlaccidParalysis(name: "acute flaccid paralysis", id:16),
  acuteHaemorrhagicFever(name: "acute haemorrhagic fever", id:17),
  feverUnknownOrigin(name: "fever of unknown origin", id:18);
  
  const MDSInfection({
    required this.name,
    required this.id
  });
  final String name;
  final int id;
}
enum MDSAdditional{
 additional1(name: "additional1", id:19),
 additional2(name: "additional2", id:20),
 additional3(name: "additional3", id:21),
 additional4(name: "additional4", id:22);
  
  const MDSAdditional({
    required this.name,
    required this.id
  });
  final String name;
  final int id;
}
enum MDSEmergency{
  surgicalEmergencyNonTrauma(name: "surgical emergency", id:23),
  medicalEmergencyNonInfectious(name: "medical emergency", id:24);
 const MDSEmergency({
    required this.name,
    required this.id
  });
  final String name;
  final int id;
 }

enum MDSOtherKeydiseases{
  skinDisease(name: "skin disease", id:25),
  acuteMentalHealth(name: "acute mental health", id:26),
  obstetricComplication(name: "obstetric complication", id:27),
  severeAcuteMalnutrition(name: "severe acute malnutrition", id:28),
  otherDiagnosis(name: "other diagnosis", id:29);
 const MDSOtherKeydiseases({
    required this.name,
    required this.id
  });
  final String name;
  final int id;
 }
enum MDSProcedure{
  majorProcedure(name: "major procedure", id:30),
  limbAmputation(name: "limb amputation", id:31),
  minorSurgicalProcedure(name: "minor surgical procedure", id:32),
  normalVaginalDelivery(name: "normal vaginal delivery", id:33),
  caesareanSection(name: "caesarean section", id:34),
  obstetricsOther(name: "obstetrics other", id:35);
  const MDSProcedure({
      required this.name,
      required this.id
    });
    final String name;
    final int id;
}
enum MDSOutcome{
  dischargeWithoutMedicalFollowUp(name: "discharge without medical follow-up", id:36),
  dischargeWithMedicalFollowUp(name: "discharge with medical follow-up", id:37),
  dischargeAgainstMedicalAdvice(name: "discharge against medical advice", id:38),
  referral(name: "referral", id:39),
  admission(name: "admission", id:40),
  deadOnArrival(name: "dead on arrival", id:41),
  deathWithinFacility(name: "death within facility", id:42),
  requiringLongTermRehabilitation(name: "requiring long-term rehabilitation", id:43);
  const MDSOutcome({
      required this.name,
      required this.id
    });
    final String name;
    final int id;
}
enum MDSRelation{
  directlyRelatedToEvent(name: "directly related to event", id:44),
  indirectlyRelatedToEvent(name: "indirectly related to event", id:45),
  notRelatedToEvent(name: "not related to event", id:46);
  const MDSRelation({
      required this.name,
      required this.id
    });
    final String name;
    final int id;
}

enum MDSProtection{
  vulnerableChild(name: "vulnerable child", id:47),
  vulnerableAdult(name: "vulnerable adult", id:48),
  sexualGenderBasedViolence(name: "sexual/gender-based violence", id:49),
  violenceNonSGBV(name: "violence non-SGBV", id:50);
  const MDSProtection({
      required this.name,
      required this.id
    });
    final String name;
    final int id;
}