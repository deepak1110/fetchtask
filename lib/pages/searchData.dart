import 'dart:async';

import 'package:fetchtask/pages/jsonBloc.dart';
import 'package:flutter/material.dart';
import 'Models/model.dart';

class Searchstuff extends SearchDelegate {
  // final Stream<JsonModel> data;
  Timer debounceTimer;

  int type;
  JsonBloc _fetchJsonbloc = JsonBloc();

  Searchstuff({this.type}) {
    onInit();
  }

  onInit() async {
    _fetchJsonbloc.fetchData(type: type);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String querys = '';
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      setState(() {
        querys = query;
      });
      return Container(
        height: 500.0,
        child: StreamBuilder(
          stream: _fetchJsonbloc.dataOut,
          builder: (context, AsyncSnapshot<JsonModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Data> newData = [];

            for (int i = 0; i < snapshot.data.children.length; i++) {
              if (snapshot.data.children[i].title
                  .toString()
                  .toLowerCase()
                  .contains(querys.trim().toLowerCase())) {
                newData.add(snapshot.data.children[i]);
              }
            }

            return ListView.builder(
              itemCount: newData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    newData[index].title,
                  ),
                  subtitle: Text(
                    newData[index].authorFullname,
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String querys = '';
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      setState(() {
        querys = query;
      });
      return Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: _fetchJsonbloc.dataOut,
          builder: (context, AsyncSnapshot<JsonModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Data> newData = [];

            for (int i = 0; i < snapshot.data.children.length; i++) {
              if (snapshot.data.children[i].title
                  .toString()
                  .toLowerCase()
                  .contains(querys.trim().toLowerCase())) {
                newData.add(snapshot.data.children[i]);
              }
            }
            return ListView.builder(
              itemCount: newData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    newData[index].title,
                  ),
                  subtitle: Text(
                    newData[index].authorFullname,
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}
