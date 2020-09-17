import 'dart:math';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/NewsBloc.dart';
import 'package:newsapp/my_flutter_app_icons.dart';
import 'package:newsapp/news.dart';
import 'package:newsapp/responsive.dart';

import 'TabWidgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  NewsBloc newsBloc = NewsBloc();
  LimitCatBloc limitCatBloc = LimitCatBloc();
  SourcesBloc sourcesBloc = SourcesBloc();
  CountryBloc countryBloc = CountryBloc();
  TagBloc tagBloc = TagBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    news = NewsDao().getNews();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    limitCatBloc.dispose();
    sourcesBloc.dispose();
    newsBloc.dispose();
    countryBloc.dispose();
    tagBloc.dispose();
  }

  isLargeScreen(context) => Responsive.isLargeScreen(context);

  isExtraLargeScreen(context) => Responsive.isExtraLargeScreen(context);

  isMediumScreen(context) => Responsive.isMediumScreen(context);

  isSmallScreen(context) => Responsive.isSmallScreen(context);
  bool didSizeChanged = false;

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    super.didChangeMetrics();
    if (isSmallScreen(context) ||
        isMediumLarge(context) ||
        isExtraLargeScreen(context)) {
      print("size changed");
      didSizeChanged = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: buildAppBar(context),
      body: Scaffold(
        key: _scaffoldKey,
        drawer: isExtraLargeScreen(context) ? null : buildDrawer(),
        body: StreamBuilder<List<Article>>(
            stream: newsBloc.news,
            builder: (context, newsSnap) {
              if (newsSnap.hasData) {
                var newsData = newsSnap.data;
                return (Flex(
                    direction: Axis.horizontal,
                    children: [
                      isExtraLargeScreen(context)
                          ? Expanded(flex: 20, child: buildMenuList())
                          : null,
                      Expanded(flex: 55, child: buildNewsList(newsData)),
                      isLargeScreen(context) || isExtraLargeScreen(context)
                          ? Expanded(flex: 25, child: buildRightMenu())
                          : null
                    ]..removeWhere((value) => value == null)));
              } else
                return CircularProgressIndicator();
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6,
        backgroundColor: Colors.white,
        onPressed: () {},
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
        label: Text(
          "Add News",
          style: GoogleFonts.josefinSans(color: Colors.black),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getChip(name,
      {bool selected,
      Color selectedColor,
      Widget avatar,
      Function(bool value) onSelected}) {
    return FilterChip(
      selected: selected != null ? selected : false,
      selectedColor:
          selectedColor != null ? selectedColor : Colors.cyan.shade600,
      disabledColor: Colors.black87,
      backgroundColor: Colors.black87,
      avatar: avatar,
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      label: Text("#$name"),
      onSelected: onSelected != null ? onSelected : () {},
    );
  }

  Widget buildRightMenu() {
    return FutureBuilder(
      future: limitCatBloc.bizNews.first,
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          limitCatBloc = LimitCatBloc();
//      didSizeChanged=false;
        }
        List<Stream<List<Article>>> categories = [
          limitCatBloc.bizNews,
          limitCatBloc.sportNews,
          limitCatBloc.techNews,
          limitCatBloc.entNews,
          limitCatBloc.healthNews,
          limitCatBloc.sciNews,
        ];
        return Padding(
          padding: isMediumLarge(context)
              ? const EdgeInsets.only(left: 38.0, right: 38.0)
              : const EdgeInsets.only(left: 20.0, right: 29),
          child: ListView(
            children: [
              buildCategoryNewsItem("Trending News",
                  categories[Random().nextInt(categories.length - 1)]),
              buildDivider(),
              buildTagFilter(),
            ],
          ),
        );
      },
    );
  }

  Column buildDivider() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 2,
          color: Colors.black45,
        ),
      ],
    );
  }

  Column buildCategoryNewsItem(String label, stream) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          buildCatTittleText(label),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<List<Article>>(
            stream: stream,
            builder: (context, AsyncSnapshot<List<Article>> news) {
              return news.hasData
                  ? Column(
                      children: [
                        buildSubCategoryItem(context, news.data[0]),
                        SizedBox(
                          height: 30,
                        ),
                        buildSubCategoryItem(context, news.data[1]),
                      ],
                    )
                  : CircularProgressIndicator();
            },
          ),
        ]);
  }

  Text buildCatTittleText(String label) {
    return Text(
      label,
      style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Container buildSubCategoryItem(BuildContext context, newsData) {
    var largeHeight = 200.0;
    var smallHeight = 160.0;
    var image = newsData.urlToImage;
    return Container(
      height: isMediumLarge(context) ? largeHeight : smallHeight,
//                      constraints: BoxConstraints.expand(width:120),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: isMediumLarge(context)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment: isMediumLarge(context)
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Expanded(
                child: Image.network(
              image != null ? image : "",
              height: isMediumLarge(context) ? largeHeight : smallHeight,
              fit: BoxFit.cover,
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(newsData.title,
                  style: GoogleFonts.josefinSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 18)),
            ))
          ],
        ),
      ),
    );
  }

  bool isMediumLarge(BuildContext context) =>
      isMediumScreen(context) || isLargeScreen(context);

  Widget buildNewsList(List<Article> newsData) {
//    var windowWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: /*630*/ isMediumLarge(context) || isLargeScreen(context)
            ? 630 /*windowWidth / 1.5*/
            : isSmallScreen(context)
                ? 630 /*windowWidth - 20*/
                : 630 /*windowWidth / 2*/,
//                    constraints: BoxConstraints.expand(height: 600),
        child: ListView.builder(
            itemCount: newsData.length,
            itemBuilder: (_, pos) {
              var currentNews = newsData[pos];
//                      return Text(currentNews.title);
              var content = currentNews.content;
              var photo = currentNews.urlToImage;
              var title = currentNews.title;
              return NewsItem(title: title, image: photo, content: content);
            }),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: buildMenuList(),
    );
  }

  Widget buildMenuList() {
    return FutureBuilder(
        future: sourcesBloc.sources.first,
        builder: (BuildContext context, AsyncSnapshot<List<Source>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            sourcesBloc = SourcesBloc();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildCatTittleText("Filter By Country:"),
                buildCountryFilter(),
                buildCatTittleText("Browse By Sources:"),
                buildSourceFilter(),
//          DrawerItem(
//            title: "Go to Home Page",
//            iconImage: Icons.home,
//          ),
              ],
            ),
          );
        });
  }

  StreamBuilder<List<Source>> buildSourceFilter() {
    return StreamBuilder<List<Source>>(
        stream: sourcesBloc.sources,
        builder: (context, AsyncSnapshot<List<Source>> snapshot) {
          return snapshot.hasData
              ? Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0,
                  children: snapshot.data
                      .sublist(0, 10)
                      .map((source) => getChip(source.id,
                              selected: source.selected, onSelected: (value) {
                            setState(() {
                              source.selected = !source.selected;
                            });
                          }))
                      .toList(),
                )
              : Text("Loading Sources...");
        });
  }

  Widget buildCountryFilter() {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0,
      children: [
        SizedBox(height: 10),
        ...NewsRepository()
            .getCountries()
            .sublist(0, 10)
            .map((country) => getChip(country.name,
                    avatar: Flag(country.id),
                    selected: country.selected, onSelected: (value) {
                  setState(() {
                    country.selected = !country.selected;
                  });
                }))
            .toList(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildTagFilter() {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0,
      children: [
        SizedBox(height: 10),
        ...NewsRepository()
            .getTags()
//                  .sublist(0, 10)
            .map((tag) =>
                getChip(tag.name, selected: tag.selected, onSelected: (value) {
                  setState(() {
                    tag.selected = !tag.selected;
                  });
                }))
            .toList(),
        SizedBox(height: 10),
      ],
    );
  }

  MyCustomAppBar buildAppBar(BuildContext context) {
    var appBarHeight = 60.0;
    var appIconColor = Colors.cyan[900] /*Colors.grey[800]*/;
    var appBarIconHeight = appBarHeight - 25.0;
    return MyCustomAppBar(
      height: appBarHeight,
      leading: buildLeadingChild(
          appBarHeight, context, appBarIconHeight, appIconColor),
      child: isMediumLarge(context) || isExtraLargeScreen(context)
          ? buildCenterChild(appBarIconHeight, appIconColor)
          : SizedBox(),
      trailing: buildTrailingChild(context),
    );
  }

  Row buildLeadingChild(double appBarHeight, context, double appBarIconHeight,
      Color appIconColor) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.face,
          color: Colors.cyan,
          size: appBarHeight,
        ),
        SizedBox(
          width: 10,
        ),
        RoundIcon(
            icon: Icons.search,
            onPress: () {
              Scaffold.of(context).openDrawer();
            }),
        SizedBox(
          width: 10,
        ),
        isSmallScreen(context)
            ? IconButton(
                iconSize: appBarIconHeight,
                color: appIconColor,
                icon: Icon(Icons.menu),
                onPressed: toggleDrawer,
              )
            : SizedBox(),
      ],
    );
  }

  Row buildTrailingChild(BuildContext context) {
    return Row(
      children: [
        RoundIcon(
            icon: Icons.add,
            onPress: () {
              Scaffold.of(context).openDrawer();
            }),
        RoundIcon(
            icon: Icons.sync,
            onPress: () {
              Scaffold.of(context).openDrawer();
            }),
        RoundIcon(
            icon: Icons.alarm,
            onPress: () {
              Scaffold.of(context).openDrawer();
            }),
        RoundIcon(
            icon: Icons.expand_more,
            onPress: () {
              Scaffold.of(context).openDrawer();
            }),
      ],
    );
  }

  Container buildCenterChild(double appBarIconHeight, Color appIconColor) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: appBarIconHeight,
            color: appIconColor,
            icon: Icon(MyFlutterApp.home),
            onPressed: toggleDrawer,
          ),
          IconButton(
            iconSize: appBarIconHeight,
            color: appIconColor,
            icon: Icon(MyFlutterApp.money),
            onPressed: toggleDrawer,
          ),
          IconButton(
            color: appIconColor,
            iconSize: appBarIconHeight,
            icon: Icon(MyFlutterApp.football_ball),
            onPressed: toggleDrawer,
          ),
          IconButton(
            color: appIconColor,
            iconSize: appBarIconHeight,
            icon: Icon(MyFlutterApp.movie_filter),
            onPressed: toggleDrawer,
          ),
          IconButton(
            iconSize: appBarIconHeight,
            color: appIconColor,
            icon: Icon(MyFlutterApp.health),
            onPressed: toggleDrawer,
          ),
          isMediumScreen(context) || isLargeScreen(context)
              ? IconButton(
                  color: appIconColor,
                  iconSize: appBarIconHeight,
                  icon: Icon(Icons.menu),
                  onPressed: toggleDrawer,
                )
              : null,
        ]..remove(null),
      ),
    );
  }

  toggleDrawer() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openEndDrawer();
    } else {
      _scaffoldKey.currentState.openDrawer();
      setState(() {});
    }
  }
}

class MyRadioTile extends StatelessWidget {
  const MyRadioTile({
    Key key,
    @required this.value,
    @required this.groupValue,
    @required this.onChange,
    @required this.label,
  }) : super(key: key);

  final bool value;
  final bool groupValue;
  final Function(bool value) onChange;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChange),
        Text(label)
      ],
    );
  }
}

class NewsItem extends StatelessWidget {
  static const double imageHeight = 300;

  const NewsItem({
    Key key,
    @required this.title,
    @required this.image,
    @required this.content,
    this.news,
  }) : super(key: key);

  final String title;
  final String image;
  final String content;
  final Article news;

  @override
  Widget build(BuildContext context) {
    return Card(
//      borderRadius: BorderRadius.circular(5),
      elevation: 2,
      child: Column(
        children: [
          image != null
              ? Container(
                  constraints: BoxConstraints.expand(height: imageHeight),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.network(image,
                            height: imageHeight,
                            width: double.infinity,
                            fit: BoxFit.cover),
                      ),
                      buildTittle(),
                    ],
                  ),
                )
              : buildTittle(),
          content != null ? buildSummary() : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildFlatButton(() {}, Icons.share, "Share"),
              buildFlatButton(() {}, Icons.remove_red_eye, "Visit"),
              buildFlatButton(() {}, Icons.bookmark_border, "Save"),
            ],
          )
        ],
      ),
    );
  }

  FlatButton buildFlatButton(Function click, IconData iconImage, String title) {
    return FlatButton.icon(
        onPressed: click,
        icon: Icon(
          iconImage,
          color: Colors.pinkAccent,
        ),
        label: Text(title));
  }

  Widget buildSummary() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Text(
              content,
              style: GoogleFonts.neucha(
                  fontWeight: FontWeight.w600,
                  textStyle: TextStyle(fontSize: 14)),
//          overflow: TextOverflow.fade,
//          maxLines: 3,
//          softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTittle() {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.cyan,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Read more",
                    style: GoogleFonts.acme(
                        textStyle: TextStyle(color: Colors.black87)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
//                overflow: TextOverflow.ellipsis,
//                maxLines: 3,
//                softWrap: false,
                style: GoogleFonts.righteous(
                    textStyle: TextStyle(
                        shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key key,
    @required this.title,
    @required this.iconImage,
  }) : super(key: key);

  final String title;
  final iconImage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(title,
          style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.bold, textStyle: TextStyle(fontSize: 19))),
      leading:
          RoundIcon(icon: iconImage, onPress: () {}, iconColor: Colors.cyan),
    );
  }
}
