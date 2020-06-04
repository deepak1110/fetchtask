import 'package:fetchtask/constants/constants.dart';
import 'package:fetchtask/pages/serviceManager/serviceManager.dart';
import 'package:fetchtask/store/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/model.dart';
import 'jsonBloc.dart';

class JsonScreen extends StatefulWidget {
  final int type;
  JsonScreen({
    this.type,
  });
  @override
  _JsonScreenState createState() => _JsonScreenState();
}

class _JsonScreenState extends State<JsonScreen> {
  JsonBloc _fetchJsonbloc = JsonBloc();

  fetchData() async {
    _fetchJsonbloc.fetchData(type: widget.type);
  }

  @override
  void dispose() {
    _fetchJsonbloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Widget bodyData() {
    return StreamBuilder(
      stream: _fetchJsonbloc.dataOut,
      builder: (BuildContext context, AsyncSnapshot<JsonModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.children.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(snapshot.data.children[index].title.toString()),
              subtitle: Text(
                snapshot.data.children[index].authorFullname.toString(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(),
    );
  }
}
