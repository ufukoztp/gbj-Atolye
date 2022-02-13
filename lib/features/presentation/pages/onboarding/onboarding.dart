import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbjatolye/features/presentation/provider/onboarding_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:provider/provider.dart';


class OnboardingScreen extends StatefulWidget {

  final _usecase;

  OnboardingScreen(this._usecase);

  @override
  State<StatefulWidget> createState() {
    return OnboardingScreenState();
  }

}


class OnboardingScreenState extends State<OnboardingScreen>{

  OnboardingProvider onboardingProvider;

  onBackPressed(cxt) {}
  @override



  @override
  Widget build(BuildContext context) {

    onboardingProvider = Provider.of<OnboardingProvider>(context);
    onboardingProvider.useCases=widget._usecase;
    onboardingProvider.context=context;

    return  WillPopScope(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 0.0,bottom: 50.0,left: 10),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/ic_home_title.png',
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),

                CarouselSlider(
                  items: onboardingProvider.getWizards(context),
                  options: CarouselOptions(
                    height: 280.0,
                    enlargeCenterPage: false,
                    initialPage: 0,

                    onPageChanged: (index,s) {
                      index!=null?
                      onboardingProvider.current=index: onboardingProvider.current=0;
                    },
                    viewportFraction: 1.0,

                  ),

                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: onboardingProvider.map<Widget>(
                    onboardingProvider.imgList,
                        (index, url) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:  onboardingProvider.current == index
                                ? AppTheme.azureRadiance[50]
                                : AppTheme.grey[50]),
                      );
                    },
                  ),
                ),

              ]),
          bottomNavigationBar: GestureDetector(
            child: BottomAppBar(
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient( colors: <Color>[
                        AppTheme.aqua[50],
                        AppTheme.azureRadiance[50],
                      ]),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 20.0,
                            spreadRadius: 20.0,
                            offset: Offset(0.0, 20.0)),
                      ]),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            height: 50,
                            child: Center(
                                child: Text(AppLocalizations.of(context).txtBtnLogin,
                                    style: Theme.of(context).textTheme.button,
                                    textAlign: TextAlign.center)),
                          ))
                    ],
                  )),
            ),
            onTap: () async {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login,(Route<dynamic> route) => false);

            },
          ),
        ),
        onWillPop: () {
          return onBackPressed(context);
        });
  }



}
