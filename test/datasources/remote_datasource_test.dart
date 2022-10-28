import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_with_unit_test/core/services/network_service.dart';
import 'package:posts_with_unit_test/datasources/remote_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:posts_with_unit_test/models/post_model.dart';

import 'remote_datasource_test.mocks.dart';

@GenerateMocks([NetworkService])
void main() {
  late final RemoteDataSourceImpl remoteDataSource;
  late final NetworkService mockNetworkService;

  setUp(() {
    mockNetworkService = MockNetworkService();
    remoteDataSource = RemoteDataSourceImpl(networkService: mockNetworkService);
  });

  test("GetPosts should return posts without any exception", () async {
    ///AAA
    ///Arrange
    final posts = List.generate(
        5,
        (index) => PostModel(
            userId: index,
            id: index,
            title: 'title $index',
            body: 'body $index'));

    final postsMap = posts.map((post) => post.toMap()).toList();

    when(mockNetworkService.get('https://jsonplaceholder.typicode.com/posts')).thenAnswer(
      (_) => Future.value(Response(
        requestOptions: RequestOptions(path: 'https://jsonplaceholder.typicode.com/posts'),
        data: postsMap,
        statusCode: 200,
      )),
    );

    ///Act
    final result = await remoteDataSource.getPosts();

    ///assert
    expect(result, posts);
  });
}
