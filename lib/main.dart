import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:core';

import 'models/messier_model.dart';
import 'populate.dart';
import 'details.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(MessierModelAdapter());

  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Messier(),
    );
  }
}
 
// This is the widget that will be shown
// as the homepage of your application.
class Messier extends StatefulWidget {
  const Messier({Key? key}) : super(key: key);
 
  @override
  State<Messier> createState() => _MessierState();
}
 
class _MessierState extends State<Messier> {
  final fieldText = TextEditingController();
  String searchtext = "";
  List messierList = [];

  Future searchDatabase() async {
    RegExp nregexp = RegExp(r'^\d+$');
    RegExp mregexp = RegExp(r'^[mM]\d+');
    RegExp cregexp = RegExp(r'^[A-Za-z][A-Za-z]');
    Box messierBox = await Hive.openBox('messier');
    messierList.clear();
    for (var messierkey in messierBox.keys) {
      MessierModel messiermodel = await messierBox.get(messierkey);
      if(nregexp.hasMatch(searchtext)) {
        String ngc = messiermodel.ngc!;
        if(ngc.contains(searchtext) == true) {
          messierList.add(messiermodel);          
        }
      } else if(mregexp.hasMatch(searchtext)) {
        String messier = messiermodel.messier!;
        messier = messier.toLowerCase();
        if(messier.contains(searchtext.toLowerCase()) == true) {
          messierList.add(messiermodel);          
        }
      } else if(cregexp.hasMatch(searchtext)) {
        String constellation = messiermodel.constellation!;
        constellation = constellation.toLowerCase();
        if(constellation.contains(searchtext.toLowerCase()) == true) {
          messierList.add(messiermodel);          
        }
      } else {
         messierList.add(messiermodel);  
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
      future: Future.wait([
        searchDatabase(),
      ]),
      builder:(context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return MaterialApp (
            theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
            darkTheme: ThemeData(brightness: Brightness.dark),
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopulatePage(),
                      ),
                    );     
                  },
                ),
                title: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextField(
                      controller: fieldText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),  
                          onPressed: () {
                            fieldText.clear();
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none
                      ),
                      onChanged: (text) {
                        searchtext = text;
                        searchDatabase();
                      },
                    ),
                  ),
                ),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 197, 221, 255),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messierList.length,
                        itemBuilder: (context, index) {
                          String messiernumber = messierList[index].messier;
                          String ngcnumber = messierList[index].ngc;
                          String desc = messierList[index].description;
                          String constellation = messierList[index].constellation;
                          String mtitle = "$messiernumber    NGC $ngcnumber";
                          String mdesc = "Constellation: $constellation   Type: $desc";
                          bool observed = messierList[index].observed;
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            elevation: 0,
                            color: Colors.blue,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(top: 5.0,bottom: 15.0),
                                child: Text(mtitle, style:
                                  observed == true ? const TextStyle(color: Color.fromARGB(255, 3, 50, 4), fontSize: 16):  const TextStyle(color: Colors.white, fontSize: 16),),
                              ),
                              subtitle: Padding (
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Text(mdesc,style: const TextStyle(color: Colors.white, fontSize: 16),),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPage(messierList[index].id),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ]
                )
              ) 
            )
          );
        }
      }
    );
  }
}