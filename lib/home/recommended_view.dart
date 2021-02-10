import 'package:bluestacks_assignment/home/home_page_provider.dart';
import 'package:bluestacks_assignment/model/tournament.dart';
import 'package:bluestacks_assignment/networking/network_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendedView extends StatelessWidget {
  final List<Tournament> _tournamentList = List();
  @override
  Widget build(BuildContext context) {
    final HomePageProvider _provider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'recommended_title',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ).tr(),
          SizedBox(height: 16),
          getRecommendedWidget(_provider)
        ],
      ),
    );
  }

  Widget getRecommendedWidget(HomePageProvider provider) {
    if (provider.response.status == Status.LOADING) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (provider.response.status == Status.ERROR) {
      return Center(
        child: Text(provider.response.message,
            style: TextStyle(fontSize: 16.0, color: Colors.redAccent)),
      );
    } else {
      _tournamentList.addAll(provider.response.data.data.tournaments);
      return Expanded(
          child: RecommendedGamesList(
              tournamentList: _tournamentList));
    }
  }
}

class RecommendedGamesList extends StatelessWidget {
  RecommendedGamesList({this.tournamentList});

  final List<Tournament> tournamentList;

  @override
  Widget build(BuildContext context) {
    final HomePageProvider _provider = Provider.of(context);
    return Container(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (_provider.response.status != Status.LOADING &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _provider.fetchRecommendedTournaments();
          }
          return true;
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Image.network(
                      tournamentList[index].coverUrl,
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      tournamentList[index].tournamentName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      tournamentList[index].gameName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 16)
                ],
              ),
            );
          },
          itemCount: tournamentList.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
        ),
      ),
    );
  }
}
