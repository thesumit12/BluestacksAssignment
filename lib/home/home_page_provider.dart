
import 'package:bluestacks_assignment/model/recommended_response.dart';
import 'package:bluestacks_assignment/networking/api_provider.dart';
import 'package:bluestacks_assignment/networking/network_response.dart';
import 'package:bluestacks_assignment/repository/recommended_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  RecommendedRepository _repository;
  NetworkResponse<RecommendedResponse> response;
  String currentCursor;
  String userName = '';

  HomePageProvider() {
    _repository = RecommendedRepository(ApiProvider());
  }

  Future<void> fetchRecommendedTournaments() async {
    response = NetworkResponse.loading('');
    try{
      RecommendedResponse recommendedResponse;
       if(currentCursor == null) {
        recommendedResponse = await _repository.fetchRecommendedTournaments('10');
      }else {
        recommendedResponse = await _repository.loadMoreTournaments('10', currentCursor);
      }
       currentCursor = recommendedResponse.data.cursor;
      response = NetworkResponse.completed(recommendedResponse);
    }catch (e) {
      response = NetworkResponse.error(e.toString());
      print('Error ${e.toString()}');
    }
    notifyListeners();

  }

  Future<DocumentSnapshot> getUserProfile(String userId) async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await database.collection("USER").doc(userId).get();
    return snapshot;
  }

  void setUserName(String value) {
    userName = value;
  }

}