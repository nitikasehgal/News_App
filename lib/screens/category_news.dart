import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/news_model.dart';

import 'home_screen.dart';
import 'news_screen.dart';

class CategoryNews extends StatefulWidget {
  final String type;
  CategoryNews(this.type);
  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    getCategoryNews();
  }

  void getCategoryNews() async {
    CategoryNewsClass newsclass = CategoryNewsClass();
    await newsclass.getCategorydata(widget.type);
    newslist = newsclass.news;
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
              widget.type,
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontSize: 22),
            )
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.skip_previous_outlined),
            ),
          )
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
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
