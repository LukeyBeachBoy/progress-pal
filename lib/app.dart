import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_moment/simple_moment.dart';
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
  // Variables
  String _habitName = 'No habit :(';
  String _counterNumber = '0';
  String _counterDateWord = 'days ago';

  // Functions
  Future<void> setHabit() async {
    // Grab stored habit and display it
    final _prefs = await SharedPreferences.getInstance(); // Get stored access

    DateTime lastRelapse = DateTime.parse(_prefs.getString('lastRelapse'));
    Moment nowMoment = new Moment.fromDate(DateTime.now());
    List<String> moments = nowMoment.from(lastRelapse).split(' ');
    String number = moments[0];
    String momentSubstring =
        moments.sublist(1).toString().replaceAll(new RegExp(r"[\[,\]\,]"), '');
    // Remove brackets and commas from string, also make 'a' = '1'
    setState(() {
      _habitName = _prefs.getString('habitName');
      if (!(momentSubstring.contains('few'))) {
        number = number.replaceAll(new RegExp(r"a"), '1');
      }
      _counterNumber = number; //
      _counterDateWord = momentSubstring; // Get rest of the string
    });
    print(_habitName);
  }

  void relapse() async {
    final _prefs = await SharedPreferences.getInstance(); // Get stored access
    if (_prefs.getString('habitName') != null &&
        _prefs.getString('lastRelapse') != null) {
      _prefs.setString('lastRelapse', DateTime.now().toIso8601String());
      setHabit();
    }
  }

  _navigateAndDisplayNewHabit(BuildContext context) async {
    final List<String> _ = await Navigator.push(
      // Navigates to the new page, then gets the new data upon returning home
      context,
      CupertinoPageRoute(
        builder: (context) => NewHabit(),
      ),
    );

    // Redraw the habit screen
    setState(() {
      setHabit();
    });
  }

  @override
  void initState() {
    super.initState();
    setHabit();
  }

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
                child: CupertinoButton(
                  onPressed: () {
                    _navigateAndDisplayNewHabit(context);
                  },
                  child: Icon(
                    CupertinoIcons.ellipsis,
                    color: CupertinoColors.extraLightBackgroundGray,
                    size: 45,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _habitName,
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
                      _counterNumber,
                      style: Styles.counterTextNumber,
                    ),
                    Text(
                      _counterDateWord,
                      style: Styles.counterTextString,
                    ),
                  ],
                ),
              ),
              Center(
                child: MediaQuery(
                  data: MediaQueryData(),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 1.85),
                    child: CupertinoButton(
                      onPressed: () {
                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return new CupertinoAlertDialog(
                                title: Text(
                                    'Are you sure you want to reset your progress?'),
                                actions: <Widget>[
                                  new CupertinoDialogAction(
                                    child: Text('Yes, I relapsed'),
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      setState(() {
                                        relapse();
                                      });
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  ),
                                  new CupertinoDialogAction(
                                    child: Text('No! Keep my progress'),
                                    isDestructiveAction: false,
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: CupertinoColors.activeOrange),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Relapse',
                              style: TextStyle(
                                  fontFamily: 'Fjalla',
                                  color: Colors.white,
                                  fontSize: 26),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              MediaQuery(
                data: MediaQueryData(),
                child: Positioned(
                  bottom: 0,
                  right: 0,
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
  DateTime _relapseDate;
  String _habitName;
  FocusNode _textFieldFocus = new FocusNode();
  final _habitNameController = TextEditingController();

  @override
  void initState() {
    _relapseDate = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _habitNameController.dispose();
    super.dispose();
  }

  Future<void> setHabit() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString('habitName', _habitName);
    _prefs.setString('lastRelapse', _relapseDate.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Choose Habit',
          style: Styles.counterTextString.copyWith(fontSize: 25),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          _textFieldFocus.unfocus();
        },
        child: Container(
          decoration: Styles.backgroundGradient,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
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
                              'Choose a Habit and a Start Date',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontFamily: 'SourceSans',
                                fontSize: 17,
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(fontFamily: 'SourceSans'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: CupertinoTextField(
                                controller: _habitNameController,
                                focusNode: _textFieldFocus,
                                autocorrect: true,
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                keyboardAppearance: Brightness.dark,
                                placeholder: 'Drinking alcohol',
                                textAlign: TextAlign.left,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontFamily: 'SourceSans',
                                    color: Colors.black87),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Last relapse date',
                                    style: TextStyle(fontFamily: 'SourceSans'),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 300,
                                    height: 125,
                                    child: CupertinoDatePicker(
                                      onDateTimeChanged: (date) {
                                        _relapseDate = date;
                                      },
                                      initialDateTime: DateTime.now(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            MediaQuery(
                              data: MediaQueryData(),
                              child: Container(
                                margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 4),
                                child: CupertinoButton(
                                  onPressed: _habitNameController.text == ''
                                      ? null
                                      : () {
                                          _habitName =
                                              _habitNameController.text;
                                          setHabit();
                                          print("$_relapseDate $_habitName");
                                          List<String> newHabit = [
                                            _habitName,
                                            _relapseDate.toIso8601String()
                                          ];
                                          Navigator.pop(context, newHabit);
                                        },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(CupertinoIcons.add_circled),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
