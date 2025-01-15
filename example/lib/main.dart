import 'package:animated_background_view/animated_background_view.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light
        ),
        useMaterial3: true,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark
        ),
        useMaterial3: true,
        brightness: Brightness.dark
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _blur = false;
  BackgroundType _bgType = BackgroundType.squares;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Container(color: const Color(0xff020100)),
          AnimatedBackground(
            fps: 60,
            type: _bgType,
            blur: _blur,
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 8),
                  const Text('Blur'),
                  const SizedBox(width: 8),
                  Switch(
                    value: _blur,
                    onChanged: (newValue){
                      setState(() { _blur = newValue; });
                    }
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: (){ setState(() { _bgType = BackgroundType.glares; _blur = true; }); },
            icon: const Icon(Icons.repeat_one_on),
            label: const Text('Glares'),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: (){ setState(() { _bgType = BackgroundType.movingGlares; _blur = true; }); },
            icon: const Icon(Icons.looks_two_outlined),
            label: const Text('Moving Glares'),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: (){ setState(() { _bgType = BackgroundType.circles; }); _blur = false; },
            icon: const Icon(Icons.threed_rotation),
            label: const Text('Circles'),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: (){ setState(() { _bgType = BackgroundType.squares; }); _blur = false; },
            icon: const Icon(Icons.threed_rotation),
            label: const Text('Squares'),
          )
        ],
      ),
    );
  }
}
