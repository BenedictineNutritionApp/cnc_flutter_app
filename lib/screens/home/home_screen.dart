import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/diet_summary_widget.dart';
import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WeeklySavedGoalsModel> weeklySavedGoalsModelList = [];
  var db2 = new WeeklySavedDBHelper();

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile').then((value) => rebuildAllChildren(context));
            },
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Theme.of(context).accentColor,
        children: [
          SpeedDialChild(
              child: Icon(Icons.food_bank),
              label: 'Log Food',
              onTap: () {
                showSearch(
                        context: context,
                        delegate: FoodSearch(DateTime.now().toString()))
                    .then((value) => rebuildAllChildren(context));
              }),

          // Navigator.pushNamed(context, '/inputActivity');
          SpeedDialChild(
              child: Icon(Icons.directions_run),
              label: 'Log Activity',
              onTap: () {
                Navigator.pushNamed(context, '/inputActivity');
              }),
          SpeedDialChild(
              child: Icon(Icons.thermostat_outlined),
              label: 'Log Symptoms',
              onTap: () {
                Navigator.pushNamed(context, '/inputSymptom');
              }),
          SpeedDialChild(
              child: Icon(Icons.question_answer),
              label: 'Log Questions',
              onTap: () {
                Navigator.pushNamed(context, '/questions');
              }),
          SpeedDialChild(
              child: Icon(MdiIcons.scale),
              label: 'Log Metrics',
              onTap: () {
                Navigator.pushNamed(context, '/inputMetric').then((value) => rebuildAllChildren(context));
              }),
          // SpeedDialChild(
          //     child: Icon(MdiIcons.abTesting),
          //     label: 'Test',
          //     onTap: () {
          //       Navigator.pushNamed(context, '/tests');
          //     }),
        ],
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ListView(
                children: [
                  DietSummaryWidget(),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          Text("Diet Summary",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),),
                          ExpansionTile(
                            title: Text('Daily Diet Summary'),
                            subtitle: Text('4 items totaling 1000 calories.'),
                            children: <Widget>[
                              Text('Food 1'),
                              Text('Food 2'),
                              Text('Food 3'),
                              Text('Food 4'),

                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/dietTracking').then((value) => rebuildAllChildren(context));
                                  },
                                  child: Text("Full Summary")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: ExpansionTile(
                      title: Text('Daily Activity Summary'),
                      subtitle: Text('2 activities totaling 125 mets.'),
                      children: <Widget>[
                        Text('Activity 1'),
                        Text('Activity 2'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/fitnessTracking');
                            },
                            child: Text("Full Summary")),
                      ],
                    ),
                  ),
                  Card(
                    child: ExpansionTile(
                      title: Text('Daily Weight Summary'),
                      subtitle: Text('No weight added today!'),
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/metricTracking');
                            },
                            child: Text("Full Summary")),
                      ],
                    ),
                  ),
                  Card(
                    child: ExpansionTile(
                      title: Text('Daily Symptom Summary'),
                      subtitle: Text('No symptoms added today!'),
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/symptomTracking');
                            },
                            child: Text("Full Summary")),
                      ],
                    ),
                  ),
                  Card(
                    child: ExpansionTile(
                      title: Text('Weekly Goals Set'),
                      subtitle: Text('Click to view your current selection!'),
                      children: <Widget>[
                        Container(
                            color: Theme.of(context).primaryColor,
                            child: Container(
                                color: Theme.of(context).primaryColor,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: weeklySavedGoalsModelList.length,
                                    itemBuilder: (context, index) {
                                      if (weeklySavedGoalsModelList[index]
                                          .type !=
                                          null) {
                                        return _buildListView(index);
                                      } else {
                                        return _buildEmpty();
                                      }
                                    }))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,60, 0, 0),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: WeeklyCalorieWidget(),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: MetricSummaryWidget(),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ActivitySummaryWidget(),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SymptomSummaryWidget(),
                  // ),
                  // Container(
                  //   height: 50,
                  // ),
                ],
              ));
        },
        future: getGoals(),
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(color: Colors.white // This is optional
        );
  }

  Widget _buildListView(int index) {
    int i = index + 1;
    return Container(
        padding: EdgeInsets.all(15.0),
        color: Theme.of(context).primaryColor,
        child: Text(i.toString() + ". " + weeklySavedGoalsModelList[index].goalDescription));
  }

  getGoals() async {
    weeklySavedGoalsModelList.clear();
    var response2 = await db2.getWeeklySavedGoals();
    var wGDecode2 = json.decode(response2.body);

    print(wGDecode2.length);
    for (int i = 0; i < wGDecode2.length; i++) {
      WeeklySavedGoalsModel weeklySavedGoalsModel = new WeeklySavedGoalsModel(
          wGDecode2[i]['id'],
          wGDecode2[i]['type'],
          wGDecode2[i]['goalDescription'],
          wGDecode2[i]['help_info'],
          wGDecode2[i]['user_id']);
      weeklySavedGoalsModelList.add(weeklySavedGoalsModel);
    }
  }
}
