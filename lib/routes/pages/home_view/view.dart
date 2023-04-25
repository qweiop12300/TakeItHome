
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/generated/fonts.gen.dart';
import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/like.dart';
import 'package:take_it_home/models/topic.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/widgets/my_notification.dart';
import 'package:take_it_home/widgets/post_list_view.dart';
import '../../../models/post.dart';
import 'logic.dart';

class HomeViewPage extends StatefulWidget {

  const HomeViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeViewPage>{
  final logic = Get.put(HomeViewLogic());
  final state = Get.find<HomeViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          systemNavigationBarColor: themeData.colorScheme.background,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: themeData.colorScheme.background),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.bottom, // Shows Status bar and hides Navigation bar
        SystemUiOverlay.top, // Shows Status bar and hides Navigation bar
      ],
    );
    return 
      NotificationListener<MyNotification>(
          onNotification: (myNotification){
            switch(myNotification.type){
              case NotificationType.postLike:
                Post post = myNotification.post!;
                logic.add(API.like, post.id!).then((value) => {
                  if(value?.code==200){
                    post..isLike=Like()..likeNumber = post.likeNumber!+1
                  }else{
                    post..isLike=null..likeNumber = post.likeNumber!-1
                  }, logic.update()
                });
                break;
              case NotificationType.postCollection:
                Post post = myNotification.post!;
                logic.add(API.collection, post.id!).then((value) => {
                  if(value?.code==200){
                    post..isCollection=Like()..collectionNumber = post.collectionNumber!+1
                  }else{
                    post..isCollection=null..collectionNumber = post.collectionNumber!-1
                  }, logic.update()
                });
                break;
            }
            return true;
          },
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hi, ${Global.isLogin()?Global.profile.value.userLogin!.sysUser!.nickName:""}',
                            style: themeData.textTheme.subtitle1,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed("/search");
                                },
                                child: Icon(Icons.search,size: 32,),
                              ),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){},
                                child: Icon(Icons.notifications_none,size: 32,),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 0, 16),
                      child: Text(
                        '宠物',
                        style: themeData.textTheme.headline4,
                      ),
                    ),
                    const _AnimalList(),
                    const SizedBox(
                      height: 16,
                    ),
                    const _TopicList(),
                    const _PostList(),
                    const SizedBox(
                      height: 85,
                    ),
                  ],
                ),
              ),
            ),
          ));
  }


  Future<void> _onRefresh() async {
    Future.wait([
      logic.getAnimalList(),
      // logic.getHeadList(),
      logic.getPostTypeList(),
      logic.getPostList(),
      logic.getTopicList()
    ]).then((value) => {
      state.isLoading=false,
      logic.update()
    });
  }

  @override
  void initState() {
    _onRefresh();
  }
}


class _TopicList extends StatelessWidget {
  const _TopicList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewLogic>(builder: (logic){
      return
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 32,right: 16),
            child: Text(
              '话题',
              style: Theme.of(context).textTheme.headline5,
            )),
            CarouselSlider.builder(
              itemCount: logic.state.topicList.length,
              itemBuilder: (context, index, realIndex) {
                return _Topic(
                  topic: logic.state.topicList[realIndex],
                  left: realIndex == 0 ? 32 : 8,
                  right: realIndex == logic.state.topicList.length - 1 ? 32 : 8,
                );
              },
              options: CarouselOptions(
                  aspectRatio: 1.6,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  scrollPhysics: const BouncingScrollPhysics(),
                  disableCenter: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
            )
          ],
        )
        ;
    });
  }
}

class _Topic extends StatelessWidget {
  const _Topic(
      {Key? key,
        required this.right,
        required this.left,
        required this.topic})
      : super(key: key);

  final double right;
  final double left;
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: GestureDetector(
        child: Stack(
          children: [
            Positioned.fill(
              top: 100,
              right: 65,
              bottom: 24,
              left: 65,
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 20, color: Color(0xaa0D253C)),
                ]),
              ),
            ),
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.network(Util.getStartImageUrl(topic.image!)),
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Color(0xff0D253C),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 32,
              bottom: 48,
              child: Text(
                topic.title!,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.apply(color: Colors.white),
              ),
            )
          ],
        ),
        onTap: (){
          Get.toNamed("/topic?id="+topic.id.toString());
        },
      ),
    );
  }
}

class _AnimalList extends StatelessWidget {
  const _AnimalList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: GetBuilder<HomeViewLogic>(builder: (logic){
        return logic.state.isLoading?Loading()
            :ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
          itemCount: logic.state.animalList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final Animal animal = logic.state.animalList[index];
            return _Animal(
              animal: animal,
              onTap: () {
                Get.toNamed("/animalInfo?id="+animal.id!.toString());
              },
            );
          },
        );
      },),
    );
  }
}

class _Animal extends StatelessWidget {
  const _Animal({
    Key? key,
    required this.animal,
    required this.onTap,
  }) : super(key: key);

  final Animal animal;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(4, 2, 4, 0),
        child: Column(
          children: [
            Stack(
              children: [
                _profileImageViewed()
                // Positioned(
                //   right: 0,
                //   bottom: 0,
                //   child: Image.asset(
                //     'assets/img/icons/${story.iconFileName}',
                //     width: 24,
                //     height: 24,
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              animal.name!,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }

  Widget _profileImageNormal() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xFF376AED),
            Color(0xFF49B0E2),
            Color(0xFF9CECFB),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: _profileImage(),
      ),
    );
  }

  Widget _profileImageViewed() {
    return SizedBox(
      width: 66,
      height: 66,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 2,
        color: const Color(0xFF7B8BB2),
        dashPattern: const [8, 3],
        radius: const Radius.circular(24),
        child: Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(4),
          child: _profileImage(),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Image.network(Util.getStartImageUrl(animal.icon!)),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '紧急',
                style: Theme.of(context).textTheme.headline5,
              ),
              TextButton(
                onPressed: () {Get.toNamed("list");},
                child: const Text(
                  '更多',
                  style: TextStyle(color: Color(0xFF376AED)),
                ),
              )
            ],
          ),
        ),
        GetBuilder<HomeViewLogic>(builder: (logic){
          return PostListViewBuilder(
            posts: logic.state.postList,
            withShadow: false,
            isComplete: true,
          );
        })
      ],
    );
  }
}
