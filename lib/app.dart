import 'package:flutter/cupertino.dart';
import 'styles.dart';

class ProgressApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomePage(),
      theme: CupertinoThemeData(
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(brightness: Brightness.dark)),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 15, 32, 39),
              Color.fromARGB(255, 32, 58, 67),
              Color.fromARGB(255, 44, 83, 100),
            ],
            radius: 1.2
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.ellipsis,
                    color: CupertinoColors.extraLightBackgroundGray,
                    size: 45,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '6',
                      style: Styles.counterTextNumber,
                    ),
                    Text(
                      'days',
                      style: Styles.counterTextString,
                    ),
                  ],
                ),
              ),
              MediaQuery(
                data: MediaQueryData(),
                child: Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'images/chart.png',
                    width: MediaQuery.of(context).size.width / 2.5,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
