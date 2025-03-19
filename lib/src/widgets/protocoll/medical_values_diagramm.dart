import 'package:emt_patientview/src/models/protocol.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/patient.dart';
import '../../models/medical_values.dart';

class MedicalValuesDiagramm extends StatefulWidget{

  final Patient patient;
  final Protocol protocol;
  const MedicalValuesDiagramm({Key? key, required this.patient, required this.protocol}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    
    return _MedicalValuesDiagrammState();
  }
}

class _MedicalValuesDiagrammState extends State<MedicalValuesDiagramm>{
List<MedicalValues> data = [];
 //TODO Diagramm
   @override
  void initState() {
    super.initState();
    data  = widget.protocol.medicalValuesList;
  }
  @override
Widget build(BuildContext context) {
  if(data.isEmpty){
    
  //  MedicalValues d1 = MedicalValues(createdAt: DateTime.now().subtract(Duration(minutes: 10)), systolic: 120, diastolic: 80, oxygenSaturation: 98, temperature: 36.5);
  //   MedicalValues d2 = MedicalValues(createdAt: DateTime.now().subtract(Duration(minutes: 5)), systolic: 130, diastolic: 85, oxygenSaturation: 97, temperature: 36.6);
  //   MedicalValues d3 = MedicalValues(createdAt: DateTime.now(), systolic: 125, diastolic: 82, oxygenSaturation: 99, temperature: 36.7);
    // data.add(d1);
    // data.add(d2);
    // data.add(d3);
  }
        return
     LineChart(
      LineChartData(
        lineBarsData: _getLineBars(),
        titlesData: _getTitles(),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(show: true),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
               return touchedBarSpots.map((touchedSpot) {
              final paramName = _getParameterName(touchedSpot.barIndex); // Name des Parameters
              final value = touchedSpot.y.toInt(); // Wert
              final unit = _getParameterUnit(touchedSpot.barIndex); // Einheit (mmHg, %, °C)
              // print(touchedSpot.barIndex);
              return LineTooltipItem(
                '$paramName: $value $unit',
                const TextStyle(fontSize: 10.0),
                textAlign: TextAlign.center,
              );
            }).toList();
          },
        ),
      ),
    )
     );
  }

  // Hilfsmethoden
  String _getParameterName(int barIndex) {
    switch (barIndex) {
      case 0: return 'Sys NIBP';
      case 1: return 'Dia NIBP';
      case 2: return 'O2 Sättigung';
      case 3: return 'Temperatur';
      default: return '';
    }
  }

  String _getParameterUnit(int barIndex) {
    switch (barIndex) {
      case 0: 
      case 1: return 'mmHg';
      case 2: return '%';
      case 3: return '°C';
      default: return '';
    }
  }

  List<LineChartBarData> _getLineBars() {
    DateTime firstDateTime = data.first.createdAt;
    return [
      // Systolischer Blutdruck
      LineChartBarData(
    spots: data.where((v) => v.systolic != null).map((v) => FlSpot(v.createdAt.difference(firstDateTime).inMinutes.toDouble(), v.systolic!.toDouble())).toList(),
        color: Colors.red,
        barWidth: 2,
        isCurved: true,
         dotData: FlDotData(getDotPainter: (spot, xPercentage, bar, index) => FlDotCustomPainter(Colors.red, '∨'),),
      ),
      // Diastolischer Blutdruck
      LineChartBarData(
       spots: data.where((v) => v.diastolic != null).map((v) => FlSpot(v.createdAt.difference(firstDateTime).inMinutes.toDouble(), v.diastolic!.toDouble())).toList(),
        color: Colors.red,
        barWidth: 2,
        isCurved: true,
        dotData: FlDotData(getDotPainter: (spot, xPercentage, bar, index) => FlDotCustomPainter(Colors.red, '∧'),),
      ),
      LineChartBarData(
        spots: data.where((v) => v.oxygenSaturation != null).map((v) => FlSpot(v.createdAt.difference(firstDateTime).inMinutes.toDouble(), v.oxygenSaturation!.toDouble())).toList(),
        color: Colors.blue,
        barWidth: 2,
        isCurved: true,
      ),
      LineChartBarData(
        spots: data.where((v) => v.pulse != null).map((v) {
         return FlSpot(
          v.createdAt.difference(firstDateTime).inMinutes.toDouble(), 
          v.pulse!.toDouble(),
        );
        }).toList(),


        color: Colors.orange,
        barWidth: 2,
        isCurved: true,
      ),
      // Füge weitere Werte hinzu (z. B. oxygenSaturation, temperature)
    ];
  }

  FlTitlesData _getTitles() {
    return FlTitlesData(

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          // getTitlesWidget: (value, meta) {
          //   final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
          //   return Text('${date.hour}:${date.minute}');
          // },
        ),
        axisNameWidget: const Text('Zeit in Minuten'),
      ),
    );
  
  }

 
}
  
class FlDotCustomPainter extends FlDotPainter {
  final Color color;
  final String symbol;

  FlDotCustomPainter(this.color, this.symbol);

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: symbol,
        style: TextStyle(color: color, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offsetInCanvas - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  Size getSize(FlSpot spot) {
    return const Size(50, 50);
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is FlDotCustomPainter && b is FlDotCustomPainter) {
      return FlDotCustomPainter(
        Color.lerp(a.color, b.color, t)!,
        t < 0.5 ? a.symbol : b.symbol,
      );
    }
    throw UnimplementedError();
  }

  @override
  Color get mainColor => color;

  @override
  List<Object?> get props => [color, symbol];
}
