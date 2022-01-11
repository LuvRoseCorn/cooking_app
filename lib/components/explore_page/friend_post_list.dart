import 'package:flutter/material.dart';
import 'package:fooderlich/components/explore_page/widgets/friend_post.dart';
import 'package:fooderlich/models/post.dart';

class FriendPostList extends StatelessWidget {
  final List<Post> friendPostList;
  const FriendPostList({Key? key, required this.friendPostList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mọi người 👩‍🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: friendPostList.length,
            itemBuilder: (context, index) {
              final post = friendPostList[index];
              return FriendPost(post: post);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
