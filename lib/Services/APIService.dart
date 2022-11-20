import 'dart:convert';

import 'package:flutter_covid_19/Services/APIContent.dart';
import 'package:flutter_covid_19/Services/APICountries.dart';
import 'package:http/http.dart' as http;

class MyService {
  Future<CovidDataFetch> getCovidData() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return CovidDataFetch.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getCovidCountry() async {
    final responses =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if (responses.statusCode == 200) {
      var datas = jsonDecode(responses.body);
      return datas;
    } else {
      throw Exception('Error1');
    }
  }
}
