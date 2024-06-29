import 'package:bloc/bloc.dart';
import 'package:bloc_with_api/api/post_api.dart';
import 'package:bloc_with_api/data/post_model.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await PostApi.getPostApi();
        emit(PostLoaded(posts: posts));
      } catch (e) {
        emit(
          PostLoadingError(error: e.toString()),
        );
      }
    });
  }
}
