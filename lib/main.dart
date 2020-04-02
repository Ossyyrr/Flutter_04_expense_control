import 'package:flutter/material.dart';
import 'package:flutterexpensecontrol/graph_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _controller;
  int currentPage = 4;
  @override
  void initState() {
    super.initState();
    _controller =
        PageController(initialPage: currentPage, viewportFraction: 0.3);
  }

  Widget _bottomAction(IconData icon) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.history),
            _bottomAction(FontAwesomeIcons.chartPie),
            SizedBox(width: 48.0),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(Icons.settings),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: null),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          _expenses(),
          _graph(),
          _list(),
        ],
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    var _alignment;
    final selected = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.blueGrey);
    final unselected = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20.0,
        color: Colors.blueGrey.withOpacity(0.4));

    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }
    return Align(
      alignment: _alignment,
      child: Text(name, style: position == currentPage ? selected : unselected),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(50.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text('\$2361,41',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            )),
        Text('Total expenses',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 250.0,
      child: GraphWidget(),
    );
  }

  Widget _item(IconData icon, String name, int percent, double value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        color: Colors.white,
        child: ListTile(
            leading: Icon(icon),
            title: Text(name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            subtitle: Text("$percent% of expenses",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueGrey,
                )),
            trailing: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("\$$value",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      )),
                ))),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      //necesita saber el espacio que tiene para ser escrolleable

      child: Container(
        color: Colors.blueGrey.withOpacity(0.1),
        child: ListView(
          children: <Widget>[
            _item(FontAwesomeIcons.shoppingCart, "Shopping", 14, 45.12),
            _item(Icons.local_drink, "drink", 17, 145.12),
            _item(Icons.fastfood, "fastfood", 11, 14.82),
            _item(FontAwesomeIcons.cat, "cat", 42, 415.12),
            _item(FontAwesomeIcons.cookie, "sweets", 7, 15.12),
            _item(Icons.card_giftcard, "presents", 25, 141.82),
          ],
        ),
      ),
    );
  }
}
