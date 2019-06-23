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
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 20, 30, 48),
              Color.fromARGB(255, 36, 59, 85),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => newHabit()),
                      );
                    },
                    child: Icon(
                      CupertinoIcons.ellipsis,
                      color: CupertinoColors.extraLightBackgroundGray,
                      size: 45,
                    ),
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

class newHabit extends StatefulWidget {
  @override
  _newHabitState createState() => _newHabitState();
}

class _newHabitState extends State<newHabit> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text('New habit'),
      ),
    );
  }
}
