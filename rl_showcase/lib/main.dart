import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(RLApp());
}

class RLApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reinforcement Learning Showcase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RLHomePage(),
    );
  }
}

class RLHomePage extends StatefulWidget {
  @override
  _RLHomePageState createState() => _RLHomePageState();
}

class _RLHomePageState extends State<RLHomePage> {
  static const int gridSize = 3;
  final Random random = Random();
  List<List<double>> qTable;
  List<int> agentPosition;
  List<int> goalPosition;
  int episodes = 0;
  double epsilon = 0.5; // Epsilon for exploration
  double alpha = 0.5; // Learning rate
  double gamma = 0.9; // Discount factor

  _RLHomePageState()
      : qTable = List.generate(
            gridSize * gridSize, (_) => List.filled(4, 0.1)), // 4 actions
        agentPosition = [0, 0],
        goalPosition = [gridSize - 1, gridSize - 1];

  void resetEnvironment() {
    setState(() {
      agentPosition = [0, 0];
      episodes++;
      if (epsilon > 0.01) {
        epsilon *= 0.95; // Decay epsilon to encourage more exploitation
      }
    });
  }

  void moveAgent() {
    final int action = selectAction(agentPosition);
    setState(() {
      updateAgentPosition(action);
      updateQTable(agentPosition, action, null);
    });
  }

  int selectAction(List<int> position) {
    int index = position[0] * gridSize + position[1];
    if (random.nextDouble() < epsilon) {
      return random.nextInt(4); // Explore: select a random action
    } else {
      return _bestAction(index); // Exploit: select the best known action
    }
  }

  int _bestAction(int index) {
    return qTable[index].indexWhere(
        (value) => value == qTable[index].reduce(max)); // Best action
  }

  void updateAgentPosition(int action) {
    int newX = agentPosition[0];
    int newY = agentPosition[1];

    switch (action) {
      case 0: // up
        newX = agentPosition[0] > 0 ? agentPosition[0] - 1 : agentPosition[0];
        break;
      case 1: // right
        newY = agentPosition[1] < gridSize - 1
            ? agentPosition[1] + 1
            : agentPosition[1];
        break;
      case 2: // down
        newX = agentPosition[0] < gridSize - 1
            ? agentPosition[0] + 1
            : agentPosition[0];
        break;
      case 3: // left
        newY = agentPosition[1] > 0 ? agentPosition[1] - 1 : agentPosition[1];
        break;
    }

    if (newX == agentPosition[0] && newY == agentPosition[1]) {
      // Agent attempted to move into a wall, apply a penalty
      updateQTable(agentPosition, action, -100); // Apply a large penalty
    } else {
      agentPosition[0] = newX;
      agentPosition[1] = newY;
      updateQTable(
          agentPosition, action, null); // No penalty, regular reward update
    }

    print('Agent moved to: (${agentPosition[0]}, ${agentPosition[1]})');
  }

  void updateQTable(List<int> position, int action, double? customReward) {
    int index = position[0] * gridSize + position[1];
    int nextIndex = agentPosition[0] * gridSize + agentPosition[1];

    double oldQValue = qTable[index][action];
    double bestNextQValue = qTable[nextIndex].reduce(max);

    // Calculate reward
    double reward = customReward ??
        ((position[0] == goalPosition[0] && position[1] == goalPosition[1])
            ? 10000
            : 1.0 /
                ((goalPosition[0] - position[0]).abs() +
                    (goalPosition[1] - position[1]).abs() +
                    1));

    qTable[index][action] =
        oldQValue + alpha * (reward + gamma * bestNextQValue - oldQValue);

    print(
        'Q-value updated at ($index, action $action): ${qTable[index][action]}');

    if (reward == 10000) {
      print('Goal reached! Resetting environment...');
      resetEnvironment();
    }
  }

  void trainAgent() async {
    while (episodes < 50) {
      await Future.delayed(Duration(milliseconds: 50)); // Faster training
      moveAgent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RL Showcase"),
        ),
        body: Row(
          children: [
            // The Grid Environment
            Container(
              width: 800,
              height: 800,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridSize, childAspectRatio: 1),
                itemCount: gridSize * gridSize,
                itemBuilder: (context, index) {
                  int x = index ~/ gridSize;
                  int y = index % gridSize;
                  bool isAgent = agentPosition[0] == x && agentPosition[1] == y;
                  bool isGoal = goalPosition[0] == x && goalPosition[1] == y;
                  return Container(
                    margin: EdgeInsets.all(2),
                    color: isAgent
                        ? Colors.blue
                        : isGoal
                            ? Colors.green
                            : Colors.grey[200],
                    child: Center(
                      child: Text(
                        isAgent
                            ? 'A'
                            : isGoal
                                ? 'G'
                                : '',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            // The Q-Table Display
            Expanded(
              child: Container(
                height: 800,
                padding: EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Four actions (up, right, down, left)
                    childAspectRatio: 2, // Make cells wider
                  ),
                  itemCount: gridSize * gridSize * 4, // 4 actions per state
                  itemBuilder: (context, index) {
                    int stateIndex = index ~/ 4;
                    int actionIndex = index % 4;
                    double qValue = qTable[stateIndex][actionIndex];

                    return Container(
                      margin: EdgeInsets.all(2),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          qValue.toStringAsFixed(2), // Display the Q-value
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: trainAgent,
                child: Text('Train Agent (50 Episodes)'),
              ),
              Text('Episodes: $episodes'),
              Text('Epsilon: ${epsilon.toStringAsFixed(2)}'),
            ],
          ),
        ));
  }
}
