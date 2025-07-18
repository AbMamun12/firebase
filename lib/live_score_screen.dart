import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/cricket_score.dart';
import 'package:flutter/material.dart';

class LiveScoreScreen extends StatefulWidget {
  const LiveScoreScreen({super.key});

  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  final List<CricketScore> _cricketScoreList = [];

  void _extractData(QuerySnapshot<Map<String, dynamic>>? snapshot) {
    _cricketScoreList.clear();

    for (DocumentSnapshot doc in snapshot?.docs ?? []) {
      _cricketScoreList.add(
        CricketScore.fromJson(doc.id, doc.data() as Map<String, dynamic>),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Scores')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cricket').snapshots(),
        builder:
            (
              context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.hasData) {
                _extractData(snapshot.data);
                return ListView.builder(
                  itemCount: _cricketScoreList.length,
                  itemBuilder: (context, index) {
                    CricketScore cricketScore = _cricketScoreList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _indicatorColor(
                          cricketScore.isMatchRunning,
                        ),
                        radius: 8,
                      ),
                      title: Text(cricketScore.matchId),
                      subtitle: Text(
                        'Team 1:${cricketScore.teamOneName}\n Team 2: ${cricketScore.teamTwoName}\nWinner: ${cricketScore.winnerTeam == '' ? 'Pending' : cricketScore.winnerTeam}',
                      ),
                      trailing: Text(
                        '${cricketScore.teamOneScore}/${cricketScore.teamTwoScore}',
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CricketScore cricketScore = CricketScore(
            matchId: 'IndvsAUS',
            teamOneName: 'India',
            teamTwoName: 'Australia',
            teamOneScore: 200,
            teamTwoScore: 220,
            isMatchRunning: true,
            winnerTeam: '',
          );
          // Update
          FirebaseFirestore.instance
              .collection('cricket')
              .doc(cricketScore.matchId)
              .update(cricketScore.toJson());

      // Add
/*       FirebaseFirestore.instance
           .collection('cricket')
           .doc(cricketScore.matchId)
         .update(cricketScore.toJson());*/
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _indicatorColor(bool isMatchRunning) {
    return isMatchRunning ? Colors.green : Colors.grey;
  }
}
