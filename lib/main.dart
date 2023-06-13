import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  List<String> food = [
    'Taco Bell',
    'Chesters chicken',
    'Subway',
    'Mcdonalds',
    'Zaxbys',
    'KFC',
    'Burger King',
    'Arbys',
    'McAllisters',
    'Popeyes',
    'Pizza',
    'Eat at Home',
    'Chinese',
    'LaHuerta',
    'BBQ'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('FLutter'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Dice Game'),
                Tab(text: 'Food Choice'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SexDiceGameScreen(),
              MainScreen(food: food),
            ],
          ),
        ),
      ),
    );
  }
}

class SexDiceGameScreen extends StatefulWidget {
  @override
  _SexDiceGameScreenState createState() => _SexDiceGameScreenState();
}

class _SexDiceGameScreenState extends State<SexDiceGameScreen> {
  String _resultText = 'Press the roll button to start the game!';
  TextEditingController _playersController = TextEditingController();
  TextEditingController _namesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _resultText,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _playersController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter number of players',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _namesController,
              decoration: InputDecoration(
                hintText: 'Enter player names separated by commas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Roll the dice!'),
              onPressed: _onRollButtonPressed,
            ),
          ],
        ),
      ),
    );
  }

  void _onRollButtonPressed() {
    int numPlayers = int.tryParse(_playersController.text) ?? 0;
    List<String> players = _namesController.text.split(',').map((name) => name.trim()).toList();
    players = players.take(numPlayers).toList();
    if (players.length < 2) {
      setState(() {
        _resultText = 'Error: need at least 2 players';
      });
      return;
    }

    String bodyPart = BodyParts[Random().nextInt(BodyParts.length)];
    String act = Acts[Random().nextInt(Acts.length)];
    players.shuffle();
    String result = '${players[0]} $act ${players[1]} on the $bodyPart';
    setState(() {
      _resultText = result;
    });
  }
}

class MainScreen extends StatefulWidget {
  final List<String> food;

  MainScreen({required this.food});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedFood = '';
  bool isButtonDisabled = false;

  void buttonClick() {
    setState(() {
      isButtonDisabled = true;
      selectedFood = widget.food[Random().nextInt(widget.food.length)];
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isButtonDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: isButtonDisabled ? null : buttonClick,
            child: Text(
              'Where do you want to eat?',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(height: 30.0),
          Text(
            selectedFood,
            style: TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}

const List<String> BodyParts = ['lips', 'genitals', 'thigh', 'neck', 'chest', 'foot'];
const List<String> Acts = ['suck', 'lick', 'nibble', 'caress', 'kiss', 'massage'];
