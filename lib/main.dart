import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
  List<Offset> points = <Offset>[];

  Widget sketchArea() {
    return Container(
      margin: EdgeInsets.all(4),
      alignment: Alignment.topLeft,
      color: Colors.white,
      child: CustomPaint(
        painter: Sketcher(points),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sketcher'),
      ),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox? box = context.findRenderObject() as RenderBox?;
            Offset point = box!.globalToLocal(details.globalPosition);
            point = point.translate(0.0, -AppBar().preferredSize.height);

            points = List.from(points)..add(point);
          });
        },
        onPanEnd: (DragEndDetails details) {
          // points.clear();
          // print('end');
          // points.add(null);
        },
        child: sketchArea(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'clear Screen',
        backgroundColor: Colors.red,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            points.clear();
          });
        },
      ),
    );
  }
}

class Sketcher extends CustomPainter {
  final List<Offset> points;
  Sketcher(this.points);
  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    // ignore: todo
    // TODO: implement shouldRepaint
    // print('the points $points');
    // print('the Delegatepoints ${oldDelegate.points}');
    return oldDelegate.points != points;
    // throw UnimplementedError();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // ignore: todo
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0;

    for (var i = 0; i < points.length; i++) {
      canvas.drawLine(points[i], points[i], paint);
      // canvas.drawCircle(points[i], 50, paint);
    }
  }
}
