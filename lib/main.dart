import 'package:fetchtask/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db/databaseProvider.dart';
import 'pages/searchData.dart';
import 'store/commons.dart';

import 'pages/Jsonscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initilizeLocalDB();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) {
            return Commons();
          }),
        ),
      ],
      child: MyApp(),
    ),
  );
}

initilizeLocalDB() async {
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  await databaseHelper.initDb();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adsandurl',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    _nestedTabController = new TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  onPressSearch() {
    showSearch(
      context: context,
      delegate: Searchstuff(
        type: _nestedTabController.index == 0
            ? Constants.hotPageType
            : Constants.newPagetype,
        // data: common.getNewData(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads and url'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: onPressSearch),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: Color(0xffc03e00),
              controller: _nestedTabController,
              labelColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  text: "hot json",
                ),
                Tab(text: "new json"),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _nestedTabController,
                  children: <Widget>[
                    JsonScreen(
                      type: Constants.hotPageType,
                    ),
                    JsonScreen(
                      type: Constants.newPagetype,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
