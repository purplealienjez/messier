import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MapPage extends StatefulWidget {
  final int id;

  const MapPage(this.id, {super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final PhotoViewController _controller = PhotoViewController();
  double initialscaler = 1.7;
  double scaler = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      // Check Orientation and change initial scale
      _controller.scale = 0.28;
    });
  }

  void _incrementScaler() {
    scaler = _controller.scale!;
     if(scaler < 2.0) {
        _controller.scale = scaler + 0.4;
        _controller.updateMultiple();
    }
  }

  void _decrementScaler() {
    scaler = _controller.scale!;
    if(scaler > 1.0) {
      // Text Orientation here and change test value
      _controller.scale = scaler - 0.4;
      _controller.updateMultiple();
    }
  }

  @override
  Widget build(BuildContext context) {
    String imagepath = "assets/images/M${widget.id.toString()}_Finder_Chart.png";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
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
          title: const Text('Map'),
        ),
        body: 
        PhotoView(
          controller: _controller,
          minScale: PhotoViewComputedScale.contained * initialscaler,  
          // basePosition: const Alignment(0, 0),
          imageProvider: AssetImage(imagepath),
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: _incrementScaler,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: _decrementScaler,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove), 
            ),
            const SizedBox(
              height: 40,
            ),
          ]
        ) 
      )
    );
  }
}