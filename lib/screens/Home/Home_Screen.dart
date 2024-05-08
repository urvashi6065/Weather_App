import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/screens/Home/weather_model.dart';
import 'package:weather/screens/setting_screen/theme_provider.dart';

import '../../Api/ApiRepoClass.dart';
import '../search_screen/Search.dart';
import '../setting_screen/Setting_Scrren.dart';

class HomeScreen extends StatefulWidget {
  final String? searchController;

  const HomeScreen({Key? key, required this.searchController})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel? object;
  bool isLoading = false;

  @override
  initState() {
    isLoading = true;
    // TODO: implement initState
    ApiRepo().loadApiData(widget.searchController).then((value) {
      setState(() {
        object = value;
        isLoading = false;
      });
      SearchModel model = SearchModel(
          image: object!.current.condition.icon,
          cityName: object!.location.name,
          temp: object!.current.tempC,
          tz_id: object!.location.tzId);

      bool flag = false;
      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].cityName == object!.location.name) {
          setState(() {
            flag = false;
          });
        }
      }
      if (flag == false) {
        setState(() {
          searchList.add(model);
        });
      }
    });
    // getSharedFunction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: (providerVar.getTheme == true)
          ? Colors.transparent
          : Color(0xff5084E9),
      appBar: AppBar(
        backgroundColor: (providerVar.getTheme == true)
            ? Colors.transparent
            : Color(0xff5084E9),
        automaticallyImplyLeading: false,
        title: (isLoading == true)
            ? Container()
            : Row(
                children: [
                  (object == null)
                      ? Container()
                      : Icon(
                          CupertinoIcons.location_solid,
                          color: Colors.white,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    (object == null) ? '' : object!.location.name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
        actions: [
          (isLoading == true)
              ? Container()
              : Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                          // SharedPreferences sharedPreferencesVar=await SharedPreferences.getInstance();
                          //
                          // String cityName=object!.location.name;
                          // searchList2.add(cityName);
                          // sharedPreferencesVar.setStringList('name',searchList2);
                          // print(sharedPreferencesVar.getStringList('name'));
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                        },
                        icon: Icon(
                          CupertinoIcons.settings_solid,
                          color: Colors.white,
                        ))
                  ],
                ),
        ],
      ),
      body: (isLoading == true)
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Center(
                  child: (object == null)
                      ? Center(
                          child: Column(
                          children: [
                            Image(
                                image: AssetImage('assets/Image/notfound.png')),
                            Text(
                              "No City Found!! Please Try again.",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            )
                          ],
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image(image: AssetImage('assets/Image/img_14.png')),
                            Text(
                              object!.current.lastUpdated,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              object!.current.condition.text,
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                    "http:" + object!.current.condition.icon),
                                Text(
                                  object!.current.tempC.toString() + "°C",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 55),
                                ),
                              ],
                            ),
                            Text(
                              object!.current.feelslikeC.toString() +
                                  "°/" +
                                  object!.current.feelslikeF.toString() +
                                  "° " +
                                  "feelslike_c/feelslike_f",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 20,
                              width: 235,
                              // color: Colors.red,
                              child: ListView.builder(
                                  itemCount:
                                      object!.forecast.forecastday.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "sunrise " +
                                              object!
                                                  .forecast
                                                  .forecastday[index]
                                                  .astro
                                                  .sunrise +
                                              " / " +
                                              "sunset " +
                                              object!
                                                  .forecast
                                                  .forecastday[index]
                                                  .astro
                                                  .sunset,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 430,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListView.builder(
                                  itemCount:
                                      object!.forecast.forecastday.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: double.infinity,
                                      height: 430,
                                      // color: Colors.red,
                                      child: ListView.builder(
                                          itemCount: object!.forecast
                                              .forecastday[index].hour.length,
                                          itemBuilder: (context, index1) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        object!
                                                            .forecast
                                                            .forecastday[index]
                                                            .hour[index1]
                                                            .time,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Image.network("http:" +
                                                          object!
                                                              .forecast
                                                              .forecastday[
                                                                  index]
                                                              .hour[index1]
                                                              .condition
                                                              .icon),
                                                      Text(
                                                        object!
                                                                .forecast
                                                                .forecastday[
                                                                    index]
                                                                .hour[index1]
                                                                .tempC
                                                                .toString() +
                                                            " °C",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          }),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Con tainer(
                            //   height: 500,
                            //   width: double.infinity,
                            //   decoration: BoxDecoration(
                            //     color: Colors.indigo,
                            //   ),
                            // ),
                          ],
                        ),
                ),
              ),
            ),
    );
  }
}
