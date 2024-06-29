part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;

  PostLoaded({
    required this.posts,
  });
}

class PostLoadingError extends PostState {
  final String error;

  PostLoadingError({
    required this.error,
  });
}
