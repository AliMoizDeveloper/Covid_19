import 'package:flutter/material.dart';
import 'package:flutter_covid_19/View/world_state.dart';

class DetailedScreen extends StatefulWidget {
  String? Name;
  String? flag;
  int? cases;
  int? activeCases;
  int? deaths;
  int? recovered;

  DetailedScreen(
      {required this.Name,
      required this.cases,
      required this.activeCases,
      required this.deaths,
      required this.recovered,
      required this.flag});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          title: Text('Detailed', style: TextStyle(color: Colors.white))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(widget.flag.toString()),
            height: 100,
            width: 100,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(widget.Name.toString(),
                style: TextStyle(color: Colors.white)),
          ),
          ReusableRow(
            title: 'Total Cases',
            value: widget.cases.toString(),
          ),
          ReusableRow(
              title: 'Active Cases', value: widget.activeCases.toString()),
          ReusableRow(title: 'Recovered', value: widget.recovered.toString()),
          ReusableRow(title: 'Deaths', value: widget.deaths.toString()),
        ],
      ),
    );
  }
}
