import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:the_laptop_hub_3/app_screens/login.dart';
import 'addSuggestions.dart';
import 'laptop_info.dart';
import 'updateScreen.dart';

//import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget>_widgetOptions = <Widget>[
    Home(),
    UpdatesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: HexColor('#A09FFF'),
          title: Text(
            'SEARCH SUGGESTIONS',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.logout),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    print("successfully signed out");
                  } catch (e) {
                    return e.message;
                  }

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                }
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('suggestions').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              // width: MediaQuery.of(context).size.width/1.2,
              // height: MediaQuery.of(context).size.height/6,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: ListView(
               children: snapshot.data.docs.map((document) {
                  return  Container(
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6.0, bottom: 3.0, left: 4.0, right: 4.0),
                              child: ListTile(
                                tileColor: HexColor("#BBBFFF"),
                              onTap:(){

                              },
                                title: Text(
                                    "Laptop: ${document['laptop_name']}",
                                    style: TextStyle(
                                        fontSize: 20
                                    )
                                ),
                                  subtitle: Text(
                                      "User Type: ${document['user_type']}",
                                      style: TextStyle(
                                          fontSize: 15
                                      )
                                  ),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          )

                        ],  
                      )

                  );
                }).toList(),
              ),
            );
          }),


    bottomNavigationBar: BottomNavigationBar(
    type: BottomNavigationBarType.shifting,
    currentIndex: _currentIndex,
    items: [
    BottomNavigationBarItem(
    icon: Icon(Icons.laptop),
    title: Text("Suggestions"),
    backgroundColor: HexColor('#AAAFFF'),
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.update),
    title: Text("Updates"),
    backgroundColor: HexColor('#AABFFF')
    ),

    ],
    onTap: (index) {
    setState(() {
    _currentIndex = index;
    });
    },

    ),

    floatingActionButton: FloatingActionButton(
    backgroundColor: HexColor('#A08FFF'),
    child: Icon(Icons.add, size: 50.0),
    hoverElevation: 15.0,
    foregroundColor: Colors.white,

    onPressed: () {
    navigateToAddSuggestions(context);
    },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
    }

    void navigateToAddSuggestions(BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => AddSuggestions(),
    )
    );
    }
  }