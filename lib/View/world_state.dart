import 'package:flutter/material.dart';
import 'package:flutter_covid_19/Services/APIContent.dart';
import 'package:flutter_covid_19/Services/ApiService.dart';
import 'package:flutter_covid_19/View/Countries_Tracking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color.fromARGB(255, 17, 80, 131),
    Colors.green.shade600,
    Colors.red.shade400,
  ];

  @override
  Widget build(BuildContext context) {
    MyService mService = MyService();
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
              future: mService.getCovidData(),
              builder: (context, AsyncSnapshot<CovidDataFetch> snapshot) {
                if (!snapshot.hasData) {
                  return SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,
                  );
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        PieChart(
                          chartRadius: MediaQuery.of(context).size.width / 2.5,
                          centerText: 'Stats',
                          //formatChartValues: ,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          dataMap: {
                            "Total": snapshot.data!.cases!.toDouble(),
                            "Recovered": snapshot.data!.recovered!.toDouble(),
                            "Deaths": snapshot.data!.deaths!.toDouble(),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: Duration(
                            milliseconds: 1200,
                          ),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                  offset: Offset(20.0, 30.0),
                                )
                              ],
                            ),
                            child: Card(
                              elevation: 10,
                              color: Colors.grey,
                              child: Column(children: [
                                ReusableRow(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                                ReusableRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                ReusableRow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                ReusableRow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                ReusableRow(
                                    title: 'Today Cases',
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                ReusableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                              ]),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return TrackingScreen();
                              },
                            ));
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black.withOpacity(.5),
                                  offset: Offset(0, 0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 18, left: 10, right: 10),
      child: Container(
        color: Colors.grey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                Text(value,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // Divider(),
          ],
        ),
      ),
    );
  }
}
