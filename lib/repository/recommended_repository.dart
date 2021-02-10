import 'package:bluestacks_assignment/model/recommended_response.dart';
import 'package:bluestacks_assignment/networking/api_provider.dart';

class RecommendedRepository {
  RecommendedRepository(this._apiProvider);

  final ApiProvider _apiProvider;

  Future<RecommendedResponse> fetchRecommendedTournaments(String limit) async {
    final response = await _apiProvider.get("?limit=$limit&status=all");
    return RecommendedResponse.fromJson(response);
  }

  Future<RecommendedResponse> loadMoreTournaments(String limit, String cursor) async {
    final response = await _apiProvider.get("?limit=$limit&status=all&cursor=$cursor");
    return RecommendedResponse.fromJson(response);
  }
}