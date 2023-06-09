import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:board_widget/data/model/post/post.dart';
import './post_detail_viewmodel.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments as int;

    return FutureBuilder<Post?>(
      future: Provider.of<PostDetailViewModel>(context).getPostById(postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final post = snapshot.data;

          if (post == null) {
            // 해당 id에 해당하는 Post가 없을 경우 처리
            return Scaffold(
              appBar: AppBar(
                title: Text('글을 찾을 수 없습니다!'),
              ),
              body: Center(
                child: Text('해당 글을 찾을 수 없습니다.'),
              ),
            );
          }

          final viewModel = Provider.of<PostDetailViewModel>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${post.date.year}.${post.date.month}.${post.date.day} 일기',
              ),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.pushNamed(
                        context,
                        '/post/edit',
                        arguments: post,
                      );
                    } else if (value == 'delete') {
                      viewModel.showDeleteConfirmationDialog(context, post);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('수정'),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('삭제'),
                    ),
                  ],
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 16.0,
                      left: 16.0,
                      bottom: 4.0,
                      right: 16.0,
                    ),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8.0),
                        Text(
                          '${post.promise}',
                          style: TextStyle(fontSize: 28.0),
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60.0),
                          child: Text(
                            post.content,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // 수정 아이콘 클릭 시 처리
                          Navigator.pushNamed(
                            context,
                            '/post/edit',
                            arguments: post,
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.pencil,
                          size: 32,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // 삭제 아이콘 클릭 시 처리
                          viewModel.showDeleteConfirmationDialog(context, post);
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 6.0)
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('로딩 중...'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
