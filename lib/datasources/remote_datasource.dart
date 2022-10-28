import 'package:posts_with_unit_test/core/services/network_service.dart';
import 'package:posts_with_unit_test/models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkService networkService;

  RemoteDataSourceImpl({required this.networkService});

  @override
  Future<List<PostModel>> getPosts() async {
    final response =
        await networkService.get('https://jsonplaceholder.typicode.com/posts');

    final result = response.data as List;

    final posts = result.map((postMap) => PostModel.fromMap(postMap)).toList();
    return posts;
  }
}
