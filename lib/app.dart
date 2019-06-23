import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        decoration: Styles.backgroundGradient,
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
                        CupertinoPageRoute(builder: (context) => NewHabit()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'My Habit',
                      style: Styles.counterTextString,
                    ),
                  ),
                ],
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

class NewHabit extends StatefulWidget {
  @override
  _NewHabitState createState() => _NewHabitState();
}

class _NewHabitState extends State<NewHabit> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Choose Habit',
          style: Styles.counterTextString.copyWith(fontSize: 25),
        ),
      ),
      child: Container(
        decoration: Styles.backgroundGradient,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
            color: Colors.grey[800],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Choose a new habit you want to break'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSans',
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              wordSpacing: 2,
                            ),
                          ),
                          Divider(color: Colors.grey[700],),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                            child: CupertinoTextField(
                              autocorrect: true,
                              keyboardAppearance: Brightness.dark,
                              textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
