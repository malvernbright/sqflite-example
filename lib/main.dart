import 'package:backdrop/backdrop.dart';
import 'package:database_app/forms/UserForm.dart';
import 'package:database_app/views/UsersList.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final splashDelay=5;
  // @override
  // void initState() {
  //   super.initState();
  //   _loadWidget();
  // }
  // _loadWidget() async {
  //   var _duration = Duration(seconds: splashDelay);
  //   return Timer(_duration, navigationPage);
  // }
  // void navigationPage() {
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)));
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BackdropScaffold(
        frontLayerBorderRadius: BorderRadius.circular(20.0),
        // headerHeight: 50.0,
        appBar: BackdropAppBar(
          title: Text("My Church"),
          actions: [BackdropToggleButton(icon: AnimatedIcons.list_view)],
        ),
        backLayer: UserForm(
          title: "Add User",
        ),
        frontLayer: MyHomePage(),
      ),
    );
  }
}



