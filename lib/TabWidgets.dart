import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollapseAppBar extends StatelessWidget {
  const CollapseAppBar({
    Key key,
    this.expandedHeight,
    this.leading,
    this.actions,
    this.centerTitle,
    this.title,
    this.background,
  }) : super(key: key);

  final double expandedHeight;
  final Icon leading;
  final List<Widget> actions;
  final bool centerTitle;
  final Text title;
  final Image background;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight != null ? expandedHeight : 250,
      floating: false,
      pinned: true,
      leading: leading != null ? leading : null,
      actions: leading != null ? actions : null,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: centerTitle != null ? centerTitle : false,
        title: title != null ? title : null,
        background: background != null ? background : Image.asset(""),
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  TabWidget(
      {Key key,
      @required this.tabsList,
      this.unselectedColor,
      this.selectedColor,
      this.initial = 0,
      this.ontap})
      : super(key: key);

  final List<Tab> tabsList;
  final Color unselectedColor;
  final Color selectedColor;
  final int initial;
  final Function(int pos) ontap;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
//      initialIndex: initial==0?0:initial,
      length: tabsList.length,
      child: SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            TabBar(
                onTap: ontap,
                unselectedLabelColor: unselectedColor,
                labelColor: selectedColor,
                tabs: tabsList),
          )),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: new Container(
        color: Colors.white,
        child: _tabBar,
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget leading;
  final Widget child;
  final Widget trailing;

  const MyCustomAppBar({
    Key key,
    this.height,
    this.leading,
    this.child,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CenterGap = 20.0;
    return Column(children: [
      Material(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              leading,
              SizedBox(
                width: CenterGap,
              ),
              Expanded(child: child),
              SizedBox(
                width: CenterGap,
              ),
              trailing,
            ]..removeWhere((element) => element == null),
          ),
        ),
      ),
    ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class RoundIcon extends StatelessWidget {
  const RoundIcon({
    Key key,
    @required this.icon,
    @required this.onPress,
    this.iconColor,
  }) : super(key: key);

  final IconData icon;
  final Function onPress;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        child: IconButton(
          color: iconColor != null ? iconColor : Colors.black,
          icon: Icon(icon),
          onPressed: onPress,
        ),
      ),
    );
  }
}

class Sample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 200),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ListTile(
                  title: Text("Index: $index"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.network(
          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "MySliverAppBar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
