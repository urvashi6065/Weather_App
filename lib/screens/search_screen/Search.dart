import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/screens/Home/weather_model.dart';
import 'package:weather/screens/setting_screen/theme_provider.dart';

import '../Home/Home_Screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  // getSharedFunction() async {
  //   SharedPreferences sharedPreferencesVar=await SharedPreferences.getInstance();
  //     searchList2=sharedPreferencesVar.getStringList('name')!;
  // }
  @override
  void initState() {
    // TODO: implement initState
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
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            onFieldSubmitted: (value) {
              searchController.text = value;
              print(searchController.text);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        searchController: searchController.text,
                      )));
            },
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(
                  fontSize: 15,
                  color: (providerVar.getTheme == true
                      ? Colors.black38
                      : Colors.black38)),
            ),
          ),
        ),
      ),
      // body: ListView.builder(
      //     itemCount: searchList2.length,
      //     itemBuilder: (context,index){
      //   return Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Container(
      //       height: 100,
      //       width: double.infinity,
      //       color: Colors.red,
      //       child: Center(child: Text(searchList2[index])),
      //     ),
      //   );
      // }),
      body: ListView.builder(
          itemCount: searchList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                              searchController: searchList[index].cityName)),
                      (route) => false);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => HomeScreen(
                  //         searchController: searchList[index].cityName)));
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                                image: NetworkImage(
                                    "https:" + searchList[index].image!)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  searchList[index].cityName!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  searchList[index].tz_id!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          searchList[index].temp.toString() + " °C",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
