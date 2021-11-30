import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/pages/home.dart';
import 'package:mobile_final/pages/library.dart';
import 'package:mobile_final/pages/search.dart';









class NavigationPage extends StatefulWidget {
  NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}


class _NavigationPageState extends State<NavigationPage> {



  String id =Authentication().getUserId();
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();

  final _inputController = TextEditingController();
  late  AsyncSnapshot artistStuff;


  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }


  int _currentIndex = 0;
  final SearchPage _searchPage = new SearchPage();
  final HomePage _homePage = new HomePage();
  final LibraryPage _libraryPage = new LibraryPage();



  @override
  Widget build(BuildContext context){
    List<Widget> _pages = <Widget>[
      _homePage,
      _libraryPage,
      _searchPage,

    ];
    return Scaffold(// new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label:'Search'
          )
        ],
      ),

      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Home Page"),
      ),
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Authentication().signOut(context);
        },
        tooltip: 'Log Out',
        child: const Icon(Icons.logout),
      ),
    );

  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



}

