import 'package:bluestacks_assignment/home/home_page_provider.dart';
import 'package:bluestacks_assignment/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.userId, this.snapshot);
  final String userId;
  final Future<DocumentSnapshot> snapshot;
  @override
  State<StatefulWidget> createState() => UserProfileState();

}

class UserProfileState extends State<UserProfile> {
  HomePageProvider _provider;


  @override
  void initState() {
    _provider = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
      child: FutureBuilder(
        future: widget.snapshot,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            final User user = User.fromJson(widget.userId, snapshot.data.data());
            _provider.setUserName(user.userName);
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                      radius: 48.0,
                    ),
                    Container(
                      height: 96.0,
                      margin: const EdgeInsets.only(left: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(user.displayName,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold)),
                          Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                color: Colors.blueAccent,
                                style: BorderStyle.solid,
                                width: 2.0,
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(12.0, 12.0, 32.0, 12.0),
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black54),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${user.rating}  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                            fontSize: 20)),
                                    TextSpan(text: 'elo_rating'.tr())
                                  ]),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 32.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            height: 90.0,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [Colors.yellow[800], Colors.yellow[500]]),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24.0),
                                    bottomLeft: Radius.circular(24.0))),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.tournamentPlayed,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'tournaments_played',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                                ).tr()
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                            height: 90.0,
                            margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [Colors.deepPurpleAccent, Colors.purpleAccent]),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.tournamentWon,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'tournaments_won',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                                ).tr()
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                            height: 90.0,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [Colors.deepOrange, Colors.orangeAccent]),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24.0),
                                    bottomRight: Radius.circular(24.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${user.winningPercent}%',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'winning_percentage',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                                ).tr()
                              ],
                            ),
                          ))
                    ],
                  ),
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
