import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/domain/entities/jewelerytypes.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/homepage_provider.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/atolyeexpansiontile.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcase.dart';
import 'package:sizer/sizer.dart';
import '../../../app.dart';

class HomePageWidgets extends StatefulWidget {
  final HomePageProvider homePageProvider;
  final String arguments;
  final UseCases useCase;

  const HomePageWidgets(
      {@required this.homePageProvider, @required this.useCase,this.arguments});

  @override
  _HomePageWidgetsState createState() => _HomePageWidgetsState();
}

class _HomePageWidgetsState extends State<HomePageWidgets> {
   HomePageProvider _homePageProvider;
   String arguments;
   Future refreshData()async{

     await _homePageProvider.getCollectionList();

     await _homePageProvider.getJeweleryTypes(_homePageProvider.collectionGroupId);

   }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePageProvider=widget.homePageProvider;
    arguments=widget.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*  Center(child:
            ///tüm datalara yollanan collectionname aynı olduğundan herhangi biri alınabilir
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(homePageProvider.jewelerytpess[0].collectiongroupname,
              style: TextStyle(color: AppTheme.azureRadiance[50],fontSize: 20),
              ),
            ),),

           */
              Column(
                children: List.generate(widget.homePageProvider.jewelerytpess.length,
                    (position) {
                  List<Subjewelrytypes> subjewelerytypes = _homePageProvider.jewelerytpess[position].subjewelrytypes;
                  Widget widget = InkWell(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: <Widget>[
                                          ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  const Radius.circular(10.0)),
                                              child: CachedNetworkImage(
                                                imageUrl: _homePageProvider
                                                    .jewelerytpess[position]
                                                    .bannerimage,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: double.maxFinite,
                                                  height: 120.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )),
                                          cardBody(subjewelerytypes, position, context),
                                        ],
                                      ),
                                    ),
                                    subjewelerytypes.length > 8
                                        ? Positioned(
                                            left: 35.0.w,
                                            bottom:0.6.h,
                                            child: InkWell(
                                                onTap: () {
                                                  _homePageProvider
                                                      .jewelerytpess[position]
                                                      .exp = true;
                                                  _homePageProvider
                                                      .jewelerytpess[position]
                                                      .state = true;
                                                  _homePageProvider
                                                      .expansionTileList[
                                                          position]
                                                      .currentState
                                                      .expand();
                                                },
                                                child: Visibility(
                                                    visible: !_homePageProvider
                                                        .jewelerytpess[position]
                                                        .exp,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                        'Tümünü gör',
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                    .collectionPageColor[
                                                                50],
                                                            fontFamily:
                                                                'MontserratSemiBold',
                                                            fontSize: 13.0),
                                                      ),
                                                        Icon(Icons.keyboard_arrow_down_outlined,color: AppTheme.collectionPageColor[50],)

                                                      ],
                                                    ))),
                                          )
                                        : Container()
                                  ],
                                ),
                              ],
                            ))),
                    onTap: () {
                      if (subjewelerytypes.length == 0) {
                        appIntent.intent =
                            PageIntents.ToProductListCodeFromHome;
                        print(  _homePageProvider.jewelerytpess[position].id);

                        appIntent.data = HomeCategory(
                          supplierId:_homePageProvider.supplierId ,
                          jeweleryType:  _homePageProvider.jewelerytpess[position].name,
                                collectionGroupId: _homePageProvider.collectionGroupId,
                                jewelrytypeid:
                                   _homePageProvider.jewelerytpess[position].id,
                                titleName: _homePageProvider.jewelerytpess[position].name,
                                subtype: false)
                            .toJson();
                        print( _homePageProvider.jewelerytpess[position].collectiongroupname);

                        Navigator.pushNamed(context, AppRoutes.productlist,arguments:_homePageProvider.jewelerytpess[position].id).then((value)async {


                        });
                      }
                    },
                  );

                  return _joinWidget(widget, position, context);
                }),
              ),
            ],
          ),
        ));
  }

  Widget _joinWidget(Widget widget, int position, BuildContext context) {
    return position == 0
        ? Showcase(
            key: _homePageProvider.colShowcaseKey,
            description: AppLocalizations.of(context).txtShowcaseCollectionItem,
            descTextStyle: Theme.of(context).textTheme.headline4,
            animationDuration: Duration(milliseconds: 500),
            child: widget)
        : widget;
  }

  Padding cardBody(List<Subjewelrytypes> subjewelerytypes, int position, BuildContext context) {
    return Padding(padding: EdgeInsets.only(
        top: 15.0,
        left: 15.0,
        right: 15.0,
        bottom:
        subjewelerytypes.length >= 8 ? 0 : 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment:
              Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    widget.homePageProvider
                        .jewelerytpess[
                    position]
                        .name
                        .toUpperCase(),
                    style: TextStyle(
                        color: AppTheme
                            .collectionPageColor[
                        50],
                        fontFamily:
                        'MontserratSemiBold',
                        fontSize: 15.0),
                  ),
                  SizedBox(width: 10,),
                  widget.homePageProvider
                      .jewelerytpess[
                  position]
                      .totalproductcount!=0?
                  Text(
                    widget.homePageProvider
                        .jewelerytpess[
                    position]
                        .totalproductcount.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                        color: AppTheme
                            .collectionPageColor[
                        50],
                        fontFamily:
                        'MontserratSemiBold',
                        fontSize: 15.0),
                  ):Container()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 20.0),
            ),
            Stack(
              children: [
                ///Açılır pencere elemanları
                Padding(
                    padding:
                    EdgeInsets.only(
                        top: 40,
                        bottom: 0),
                    child: subjewelerytypes
                        .length >
                        8
                        ? Column(
                        children: [
                          Container(
                              key: PageStorageKey(
                                  position),
                              child:
                              AppExpansionTile(
                                onExpansionChanged:
                                    (s) {
                                  widget.homePageProvider.changedElementItem(position, s);
                                },
                                key:
                                widget.homePageProvider.getExpansionTileKey(position),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 80, bottom: 0),
                                    child: Column(children: [
                                      subjewelerytypes.length > 8
                                          ? Row(
                                        children: List.generate(subjewelerytypes.length - 8 >= 4 ? 4 : subjewelerytypes.length - 8, (index) {
                                          return Expanded(
                                            child: InkWell(
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(bottom: 5.0),
                                                        child: Center(
                                                          child: CachedNetworkImage(
                                                            imageUrl: subjewelerytypes[8 + index].icon,
                                                            width: 40,
                                                            height: 40,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        subjewelerytypes[8 + index].name.toUpperCase(),
                                                        style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 10.0),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Text(
                                                        '(${subjewelerytypes[8 + index].productCount})',
                                                        style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 10.0,fontWeight: FontWeight.w800),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                itemTap(position, subjewelerytypes, 8+index, context);
                                              },
                                            ),
                                          );
                                        }),
                                      )
                                          : Container(),
                                      subjewelerytypes.length > 12
                                          ? Row(
                                        children: List.generate(subjewelerytypes.length - 12 >= 4 ? 4 : subjewelerytypes.length - 12, (index) {
                                          return Expanded(
                                            child: InkWell(
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(bottom: 5.0),
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 20.0),
                                                            child: CachedNetworkImage(
                                                              imageUrl: subjewelerytypes[12 + index].icon,
                                                              width: 40,
                                                              height: 40,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        subjewelerytypes[12 + index].name.toUpperCase(),
                                                        style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 10.0),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Text(
                                                        '(${subjewelerytypes[12 + index].productCount})',
                                                        style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 10.0,fontWeight: FontWeight.w800),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                itemTap(position, subjewelerytypes, 12+index, context);
                                              },
                                            ),
                                          );
                                        }),
                                      )
                                          : Container(),
                                      subjewelerytypes.length > 16
                                          ? Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(subjewelerytypes.length - 16 >= 4 ? 4 : subjewelerytypes.length - 16, (index) {
                                          return Expanded(
                                            child: InkWell(
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(bottom: 5.0),
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 20.0),
                                                            child: CachedNetworkImage(
                                                              imageUrl: subjewelerytypes[16 + index].icon,
                                                              width: 40,
                                                              height: 40,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        subjewelerytypes[16 + index].name.toUpperCase(),
                                                        style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 10.0),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Text(
                                                        '(${subjewelerytypes[16 + index].productCount})',
                                                        style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 10.0,fontWeight: FontWeight.w800),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                itemTap(position, subjewelerytypes, 16+index, context);

                                              },
                                            ),
                                          );
                                        }),
                                      )
                                          : Container()
                                    ]),
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom:
                                2,
                                top:
                                4),
                            child:
                            Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      widget.homePageProvider.jewelerytpess[position].exp = false;
                                      widget.homePageProvider.jewelerytpess[position].state = false;
                                      widget.homePageProvider.expansionTileList[position].currentState.collapse();
                                    },
                                    child: Padding(
                                      padding:  EdgeInsets.all(8.0.sp),
                                      child: Container(
                                        child: Visibility(
                                            visible: widget.homePageProvider.jewelerytpess[position].exp,
                                            child: Center(
                                              child: Text('Gizle', style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 13.0)),
                                            )),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ])
                        : Container(
                      height: 0,
                      width: 0,)),
                Column(
                  children: [
                    ///Gösterilen ilk iki satır
                    Row(
                      children: List.generate(
                          subjewelerytypes
                              .length >=
                              4
                              ? 4
                              : subjewelerytypes
                              .length,
                              (index) {
                            return Expanded(
                              child: InkWell(
                                child: Stack(
                                  children: [
                                    Column(
                                      children: <
                                          Widget>[
                                        Container(
                                          padding:
                                          EdgeInsets.only(bottom: 0),
                                          child:
                                          Center(
                                            child: CachedNetworkImage(
                                              imageUrl: subjewelerytypes[index].icon,
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          subjewelerytypes[index].name.toUpperCase(),
                                          style: TextStyle(
                                              color: AppTheme.collectionPageColor[50],
                                              fontFamily: 'MontserratSemiBold',
                                              fontSize: 9.0),
                                          textAlign:
                                          TextAlign.center,
                                        ),
                                        Text(
                                          '(${subjewelerytypes[index].productCount})',
                                          style: TextStyle(
                                              color: AppTheme.collectionPageColor[50],
                                              fontFamily: 'MontserratSemiBold',
                                              fontSize: 10.0,fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  itemTap(position, subjewelerytypes, index, context);

                                },
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                subjewelerytypes.length >
                    4
                    ? Padding(
                  padding:
                  const EdgeInsets
                      .only(
                      top: 79),
                  child: Row(
                    mainAxisSize:
                    MainAxisSize
                        .min,
                    children: List.generate(
                        subjewelerytypes.length <= 8
                            ? subjewelerytypes.length -
                            4
                            : 4,
                            (index) {
                          return Expanded(
                            child:
                            InkWell(
                              child:
                              Stack(
                                children: [
                                  Column(
                                    mainAxisSize:
                                    MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: CachedNetworkImage(
                                              imageUrl: subjewelerytypes[4 + index].icon,
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        subjewelerytypes[4 + index].name.toUpperCase(),
                                        style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 9.0),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '(${subjewelerytypes[4 + index].productCount})',
                                        style: TextStyle(color: AppTheme.collectionPageColor[50], fontFamily: 'MontserratSemiBold', fontSize: 10.0,fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              onTap:
                                  () {
                                    itemTap(position, subjewelerytypes, 4+index, context);

                                  },
                            ),
                          );
                        }),
                  ),
                )
                    : Container(),

                ///tümünü gör altındaki container ve tümünü gör
                subjewelerytypes.length >=
                    8
                    ? Positioned(
                  bottom: 0,
                  child: Visibility(
                      visible: !widget.homePageProvider
                          .jewelerytpess[
                      position]
                          .exp,
                      child:
                      Container(
                        width: MediaQuery.of(
                            context)
                            .size
                            .width,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Colors
                                .white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, -8),
                                  blurRadius: 7)
                            ]),
                      )),
                )
                    : Container(
                  height: 0,
                  width: 0,
                ),

                ///expansionTile lenghte göre tümünü gör yazısının hizalanması
              ],
            ),
          ],
        ));
  }

  void itemTap(int position, List<Subjewelrytypes> subjewelerytypes, int index, BuildContext context) {

    appIntent.intent = PageIntents.ToProductListCodeFromHome;
    
    appIntent.data = HomeCategory(
      jeweleryType:  _homePageProvider.jewelerytpess[position].name,
      supplierId: widget.homePageProvider.supplierId,
      collectionGroupId: widget.homePageProvider.collectionGroupId,
      jewelrytypeid: subjewelerytypes[index].id,
      titleName:  subjewelerytypes[index].name + " " + widget.homePageProvider.jewelerytpess[position].name ,
      subtype: true,
    ).toJson();


    Navigator.pushNamed(context, AppRoutes.productlist, arguments: subjewelerytypes[index].id).then((value) async{
    subjewelerytypes[index].productCount=value;
    setState(() {

        });

    });


  }
}
