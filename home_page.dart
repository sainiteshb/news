import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaceiva/constants/ui_widgets.dart';

import 'package:spaceiva/controllers/news.dart';
import 'apod_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newslist;
  bool _loading;

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getNews();
    _loading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: Color(mainColor),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApodPage(),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://images.pexels.com/photos/73873/star-clusters-rosette-nebula-star-galaxies-73873.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black26,
                        ),
                        child: contentText("Astronomy Picture of the Day", 20,
                            FontWeight.w600, Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 18.0, left: 15, right: 15.0),
                child: Column(
                  children: <Widget>[
                    contentText("Latest news & updates on Space", 20,
                        FontWeight.w600, null),
                    _loading
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      shimmerWidget(200.0,
                                          MediaQuery.of(context).size.width),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      shimmerLine(
                                          MediaQuery.of(context).size.width),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      shimmerLine(
                                          MediaQuery.of(context).size.width *
                                              0.5)
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      shimmerWidget(200.0,
                                          MediaQuery.of(context).size.width),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      shimmerLine(
                                          MediaQuery.of(context).size.width),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      shimmerLine(
                                          MediaQuery.of(context).size.width *
                                              0.5)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 16),
                            child: ListView.builder(
                                itemCount: newslist.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return NewsTile(
                                    imgUrl: newslist[index].urlToImage ?? "",
                                    title: newslist[index].title ?? "",
                                    desc: newslist[index].description ?? "",
                                    content: newslist[index].content ?? "",
                                    posturl: newslist[index].articleUrl ?? "",
                                  );
                                }),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
