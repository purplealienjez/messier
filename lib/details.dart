import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/messier_model.dart';
import 'map.dart';


class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage(this.id, {super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  MessierModel messiermodel = MessierModel();

  @override
  initState()  {
    super.initState();
  }

  Future readDatabase() async {
    Box messierBox = await Hive.openBox('messier'); 
    messiermodel = await messierBox.get(widget.id);
  }

  Future writeDatabase(int id, bool? observed, bool? queued) async {
    Box messierBox = await Hive.openBox('messier');
    messiermodel = await messierBox.get(id);
    messiermodel.observed = observed;
    messiermodel.queued = queued;
    await messierBox.put(id, messiermodel);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
      future: Future.wait([
        readDatabase(),
      ]),
      builder:(context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          int id = messiermodel.id!;
          String messiernumber = messiermodel.messier!;
          String ngc = messiermodel.ngc!;
          String ra = messiermodel.ra!;
          String dec = messiermodel.dec!;
          String sec = messiermodel.sec!;
          String constellation = messiermodel.constellation!;
          String magnitude = messiermodel.magnitude!;
          String description = messiermodel.description!;
          bool? observed = messiermodel.observed!;
          bool? queued = messiermodel.queued!;
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
                title: const Text(''),
              ),
              body: Column(
                children: [
                  const SizedBox(height: 30),
                  Table(
                    children: [
                        TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("Map:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: IconButton(
                              icon: const Icon(Icons.map),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapPage(id)));
                              },
                            )
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("Messier:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: Text(messiernumber, style: const TextStyle(fontSize: 20),),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("NGC:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: Text(ngc, style: const TextStyle(fontSize: 20),),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("Coordinates:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: Text("$ra  $dec  $sec", style: const TextStyle(fontSize: 20),),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("Constellation:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: Text(constellation, style: const TextStyle(fontSize: 20),),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("Magnitude:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: Text(magnitude, style: const TextStyle(fontSize: 20),),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("Type:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: Text(description, style: const TextStyle(fontSize: 20),),
                          
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("Observed:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          
                          ),
                          Checkbox(
                            tristate: false,
                            value: observed, 
                            onChanged: (bool? value) {
                              setState(() {
                                observed = value;
                                writeDatabase(id, observed, queued);
                              });
                             },),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 20.0),
                            child: const Text("Queued:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Checkbox(
                            tristate: false,
                            value: queued, 
                            onChanged: (bool? value) {
                              setState(() {
                                queued = value;
                                writeDatabase(id, observed, queued);
                              });
                             },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            )
          );
        }
      }
    );
  }
}