import 'package:bloc_with_api/bloc/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<PostBloc>().add(FetchPostsEvent());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final postData = state.posts[index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(postData.title.toString()),
                      subtitle: Text(
                        postData.body.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                itemCount: state.posts.length,
              ),
            );
          } else if (state is PostLoadingError) {
            return Text(state.error);
          }
          return const Center(
            child: Text('No Data'),
          );
        },
      ),
    );
  }
}
