import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:the_laptop_hub_3/app_screens/login.dart';
import 'package:the_laptop_hub_3/information.dart';
import 'addSuggestions.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class UpdatesScreen extends StatefulWidget {
  @override
  _UpdatesScreenState createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  var _currentIndex = 0;
  List tabs = [Container(child: Home()), Container(child: UpdatesScreen())];
  var updatesList = List<Information>();
  List<Information> _updates = List<Information>();
  initState() {
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    String url =
        'https://newsapi.org/v2/everything?domains=techcrunch.com&language=en&sortBy=publishedAt&apiKey=b8010d33c3224b96b552b75eb026e1ca';
    Response response = await http.get(url);
    //var responseBody = response.body;
    //Map list = json.decode(responseBody);
    if (response.statusCode == 200) {
      var information = json.decode(response.body);
      //print(information["articles"]);

      for (var info in information["articles"]) {
        updatesList.add(Information.fromJson(info));
      }
    }
    return updatesList;
  }

  @override
  Widget build(BuildContext context) {
    fetchData().then((value) {
      setState(() {
        _updates.addAll(value);
      });
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#A09FFF'),
        title: Text(
          "UPDATES SCREEN",
          style: TextStyle(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
              })
        ],
      ),
      body: _updates.isEmpty || _updates == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _updates.length,
              itemBuilder: (context, int index) {
                return  Container(
                  decoration: BoxDecoration(color: HexColor('#FFFFFF')),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 5.0, bottom: 2.5),
                    child: Card(
                      color: HexColor('#AAAAFF'),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 3.0),
                          child: Column(
                            children: [
                              Container(
                                color: HexColor('#D0FFFF'),
                                child: ListTile(
                                  title: Text('TITLE: ${_updates[index].title}',
                                      style: TextStyle(fontSize: 20)),
                                  subtitle: Text(
                                      'DESCRIPTION: ${_updates[index].description}'),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('images/laptopimage_1.jpg'),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white70,
          curve: Curves.easeInOut,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.laptop),
                title: Text("SUGGESTIONS"),
                activeColor: Colors.black,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: Icon(Icons.update),
                title: Text("UPDATES"),
                activeColor: Colors.black,
                inactiveColor: Colors.grey),
          ]),

      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('#A08FFF'),
        child: Icon(Icons.add, size: 50.0),
        hoverElevation: 15.0,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        onPressed: () {
          navigateToAddSuggestions(context);
        },
      ),
    );
  }

  void navigateToAddSuggestions(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddSuggestions(),
        ));
  }
}
