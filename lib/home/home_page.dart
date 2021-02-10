import 'package:bluestacks_assignment/home/home_page_provider.dart';
import 'package:bluestacks_assignment/home/recommended_view.dart';
import 'package:bluestacks_assignment/home/user_profile.dart';
import 'package:bluestacks_assignment/model/user.dart';
import 'package:bluestacks_assignment/navigation/app_navigator_factory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage(this.userId, this.factory);

  final String userId;
  final AppNavigatorFactory factory;

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomePageProvider _provider;
  Future<DocumentSnapshot> _future;

  @override
  void initState() {
    super.initState();
    _provider = HomePageProvider();
    _future = _provider.getUserProfile(widget.userId);
    _provider.fetchRecommendedTournaments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _future,
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                final User user = User.fromJson(widget.userId, snapshot.data.data());
                return Center(child: Text(user.userName));
              }
              return Container();
            }
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'user_id'.tr(args: ['${widget.userId}']),
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('logout').tr(),
              onTap: () async{
                await logout();
              },
            )
          ],
        ),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _provider,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfile(widget.userId, _future),
            Expanded(
              child: RecommendedView(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    widget.factory.get(context).navigateToLoginPage();
  }
}
