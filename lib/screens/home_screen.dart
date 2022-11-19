import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/category_model.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/screens/category_news.dart';
import 'package:news_app/screens/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> category = [];
  // List<NewsModel> news = [];
  bool _loading = true;
  var newslist;
  @override
  void initState() {
    category = getCategories();
    getNews();

    super.initState();
  }

  getNews() async {
    News news = News();
    await news.getdata();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Daily",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              Text(
                "News",
                style: TextStyle(color: Colors.blue, fontSize: 22),
              )
            ],
          )),
      body: _loading
          ? Container(
              alignment: Alignment.center, child: CircularProgressIndicator())
          : SingleChildScrollView(
              // physics: ClampingScrollPhysics(),
              child: Container(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 70,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(category[index].image!,
                            category[index].CategoryName!);
                      },
                      itemCount: category.length,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (content, index) {
                        return NewsTile(
                            newslist[index].imgUrl!,
                            newslist[index].title!,
                            newslist[index].desc!,
                            newslist[index].Url);
                      },
                      itemCount: newslist.length,
                    ),
                  )
                ],
              )),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String img;
  String categoryName;
  CategoryTile(this.img, this.categoryName);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryNews(categoryName.toLowerCase());
        }));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              width: 120,
              height: 60,
              fit: BoxFit.cover,
              imageUrl: img,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              categoryName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  String img;
  String title;
  String desc;
  String url;
  NewsTile(this.img, this.title, this.desc, this.url);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NewsScreen(url);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 18),
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(img)),
          SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 19,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            desc,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ]),
      ),
    );
  }
}
