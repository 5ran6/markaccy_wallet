import 'package:flutterCrypto/import/Imports.dart';

class NewDetailView extends StatelessWidget {
  final int index;
  NewDetailView({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.darkblueTheme,
            leading: Padding(
              padding: EdgeInsets.only(left: 5),
              child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/double_arrows_left.svg',
                    height: 50.h,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            expandedHeight: 0.8.hp,
            pinned: true,
            floating: false,
            flexibleSpace: _top(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 25, right: 25),
                    child: AutoSizeText(
                      cryptoNews[index].story,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: AppTheme.lightFontFamily,
                        color: Theme.of(context).textSelectionHandleColor,
                        fontSize: ScreenUtil().setSp(50),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _top(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
      titlePadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      title: AutoSizeText(
        cryptoNews[index].title,
        textAlign: TextAlign.center,
        maxLines: 3,
        minFontSize: 10,
        style: TextStyle(
          fontFamily: AppTheme.mediumFontFamily,
          color: Colors.white,
          fontSize: ScreenUtil().setSp(60),
        ),
      ),
      background: Hero(
        tag: '${index.toString()}image',
        child: Container(
          height: 1.hp,
          width: 1.wp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(cryptoNews[index].image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
          ),
        ),
      ),
    );
  }
}
