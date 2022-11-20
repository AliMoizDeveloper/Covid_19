import 'package:flutter/material.dart';
import 'package:flutter_covid_19/Services/APIContent.dart';
import 'package:flutter_covid_19/Services/APICountries.dart';
import 'package:flutter_covid_19/Services/ApiService.dart';
import 'package:flutter_covid_19/View/DetailedScreen.dart';
//import 'package:flutter_covid_19/Services/Covid_countrydata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  static Color Tcolor = Colors.white;
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MyService myService = MyService();
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          'Tracking Countries',
          style: TextStyle(color: Tcolor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              maxLength: 10,
              keyboardType: TextInputType.name,
              controller: _searchController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Search Cases Country wise',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: myService.getCovidCountry(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.grey.shade100,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    height: 10,
                                    width: 20,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (_searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return DetailedScreen(
                                        Name: snapshot.data![index]['country'],
                                        cases: snapshot.data![index]['cases'],
                                        activeCases: snapshot.data![index]
                                            ['active'],
                                        deaths: snapshot.data![index]['deaths'],
                                        recovered: snapshot.data![index]
                                            ['recovered'],
                                        flag: snapshot.data![index]
                                            ['countryInfo']['flag']);
                                  },
                                ));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                  ),
                                ),
                                title: Text(snapshot.data![index]['country'],
                                    style: TextStyle(color: Tcolor)),
                                subtitle: Text(
                                    'Total Cases : ${snapshot.data![index]['cases'].toString()}',
                                    style: TextStyle(color: Tcolor)),
                              ),
                            ),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return DetailedScreen(
                                        Name: snapshot.data![index]['country'],
                                        cases: snapshot.data![index]['cases'],
                                        activeCases: snapshot.data![index]
                                            ['active'],
                                        deaths: snapshot.data![index]['deaths'],
                                        recovered: snapshot.data![index]
                                            ['recovered'],
                                        flag: snapshot.data![index]
                                            ['countryInfo']['flag']);
                                  },
                                ));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                  ),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    'Total Cases : ${snapshot.data![index]['cases'].toString()}'),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
