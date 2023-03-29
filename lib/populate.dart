import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/messier_model.dart';

class PopulatePage extends StatefulWidget {
  const PopulatePage({super.key});

  @override
  State<PopulatePage> createState() => _PopulatePageState();
}

class _PopulatePageState extends State<PopulatePage> {

  @override
  initState()  {
    super.initState();
  }

  void buttonPressed() async {
    List messierobjects = [];

    Hive.deleteFromDisk();

    String messierresponse = await rootBundle.loadString('assets/files/messierdata.json');
    final messierdata = await json.decode(messierresponse);
    messierobjects = messierdata["messierdata"];
    Box messierBox = await Hive.openBox('messier');
    for (var messierobject in messierobjects) {
      int id = messierobject['id'];
      String messier = messierobject['messier'];
      String ngc = messierobject['ngc'];
      String ra = messierobject['ra'];
      String dec = messierobject['dec'];
      String sec = messierobject['sec'];
      String constellation = messierobject['constellation'];
      String magnitude = messierobject['magnitude'];
      String description = messierobject['description'];
      bool observed = messierobject['observed'];
      bool queued = messierobject['queued'];
      bool visible = messierobject['visible'];

      MessierModel mData = MessierModel(
                      id: id,
                      messier: messier,
                      ngc: ngc,
                      ra: ra,
                      dec: dec,
                      sec: sec,
                      constellation: constellation,
                      magnitude: magnitude,
                      description: description,
                      observed: observed,
                      queued: queued,
                      visible: visible,
                  );
      await messierBox.put(id, mData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 70,
          leading: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text(''),
              style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
          title: const Text('POPULATE'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              const Text('Press button to populate databaser'),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      buttonPressed();
                    }, 
                    child: const Text('Populate')
                  )
                )
              )
            ]
          )
        ),
      ),
    );
  }
}