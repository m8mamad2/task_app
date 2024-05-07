
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';



class LineChartSampleDesktop extends StatefulWidget {
  final List<Map<String,dynamic>> values;
  const LineChartSampleDesktop({super.key, required this.values});

  @override
  State<LineChartSampleDesktop> createState() => _LineChartSampleDesktopState();
}
class _LineChartSampleDesktopState extends State<LineChartSampleDesktop> {
  List<Color> gradientColors = [
    kThiredColor,
    kThiredColor.withOpacity(0.5),
  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: AspectRatio(
        aspectRatio: 2.3,
        child: LineChart(mainData(widget.values),),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('SAT', style: style);
        break;
      case 1:
        text = const Text('SUN', style: style);
        break;
      case 2:
        text = const Text('MON', style: style);
        break;
      case 3:
        text = const Text('TUE', style: style);
        break;
      case 4:
        text = const Text('WED', style: style);
        break;
      case 5:
        text = const Text('THU', style: style);
        break;
      case 6:
        text = const Text('FRI', style: style);
        break;
      default:
        text = const Text('FRI', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 6:
        text = '6H';
        break;
      case 12:
        text = '12H';
        break;
      case 18:
        text = '18H';
        break;
      case 24:
        text = '24H';
        break;
      case 30:
        text = '30H';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<Map<String,dynamic>> values) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.white),
      ),
      minX: 1,
      maxX: 7,
      minY: 0,
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          // spots: const [
          //   FlSpot(1, 30),
          //   FlSpot(2, 13),
          //   FlSpot(3, 24),
          //   FlSpot(4, 6),
          //   FlSpot(5, 12),
          //   FlSpot(6, 0),
          //   FlSpot(7, 7),
          // ],
          spots: List.generate(7, (index) {
            if(values.isNotEmpty){
              final data = int.parse(values[index].values.toString().split(':')[0].substring(1)).toDouble();
              return FlSpot(index.toDouble() + 1 , data);
            }
            else {
              return FlSpot(0,0);
            }
          }),
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors, ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData( show: false, ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(), ),
          ),
        ),
      ],
    );
  }

}


