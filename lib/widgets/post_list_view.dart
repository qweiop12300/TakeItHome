import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/MyIcon.dart';
import 'package:take_it_home/widgets/widgetUtil.dart';

import '../common/Util.dart';
import '../generated/fonts.gen.dart';
import '../models/post.dart';
import 'my_notification.dart';

class PostListViewBuilder extends StatelessWidget {
  const PostListViewBuilder(
      {Key? key, required this.posts, required this.withShadow,required this.isComplete})
      : super(key: key);

  final List<Post> posts;
  final bool withShadow;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    const double height = 200;
    return isComplete?ListView.builder(
      itemExtent: height,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final post = posts[index];
        return _Post(post: post, withShadow: withShadow);
      },
    )
    :SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate((context, index){
            final post = posts[index];
            return _Post(post: post, withShadow: withShadow);
        },childCount:posts.length), itemExtent: height);
  }
}

class _Post extends StatelessWidget {
  const _Post({
    Key? key,
    required this.post,
    required this.withShadow,
  }) : super(key: key);

  final Post post;
  final bool withShadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/postInfo?id="+post.id.toString());
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            withShadow == false
                ? const BoxShadow(
              blurRadius: 10,
              color: Color(0x1a5282FF),
            )
                : BoxShadow(
              blurRadius: 5,
              color:
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
            )
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Util.getImageUrlList(post.image).length>0?ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:
              Image.network(Util.getImageUrlList(post.image)[0]),
            ):SizedBox(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    post.appAnimal==null?WidgetUtil.getUserWidget(post.user!):WidgetUtil.getUserAnimalWidget(post.user!, post.appAnimal!),
                    SizedBox(height: 5,),
                    Text(
                      post.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        fontFamily: FontFamily.avenir,
                        color: Color(0xFF376AED),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      post.content!,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(child: Icon(
                          post.isLike==null?
                          CupertinoIcons.hand_thumbsup
                              :CupertinoIcons.hand_thumbsup_fill,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyText2?.color,
                        ),onTap: (){
                          MyNotification(NotificationType.postLike,post: post).dispatch(context);
                        },),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          post.likeNumber!.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(
                          width: 16,
                        ),

                        Icon(
                          CupertinoIcons.bubble_middle_bottom,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyText2?.color,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          post.commentsNumber!.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(
                          width: 16,
                        ),

                        GestureDetector(child: Icon(
                          post.isCollection==null?
                          CupertinoIcons.bookmark
                              :CupertinoIcons.bookmark_fill,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyText2?.color,
                        ),
                          onTap: (){
                            MyNotification(NotificationType.postCollection,post: post).dispatch(context);
                          },),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          post.collectionNumber!.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(
                          width: 16,
                        ),

                        Icon(
                          CupertinoIcons.clock,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyText2?.color,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          post.createDate,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}