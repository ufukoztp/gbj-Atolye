import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';

abstract class OnboardingProviderUseCases {
  List getWizards(context);

  List<T> map<T>(List list, Function handler);
}

class OnboardingProvider
    with ChangeNotifier
    implements OnboardingProviderUseCases {

  BuildContext _context;
  UseCases _useCases;
  int _current = 0;

  final List<String> imgList = [
    "images/ic_wizard_1.png",
    "images/ic_wizard_2.png",
    "images/ic_wizard_3.png"
  ];

  @override
  List getWizards(context) {
    return map<Widget>(
      imgList,
      (index, i) {
        String h1 = "";
        String h2 = "";

        switch (index) {
          case 0:
            h1 = AppLocalizations.of(context).txtLblWizard1;
            h2 = AppLocalizations.of(context).txtLblWizard1_1;
            break;
          case 1:
            h1 = AppLocalizations.of(context).txtLblWizard2;
            h2 = AppLocalizations.of(context).txtLblWizard2_2;
            break;
          case 2:
            h1 = AppLocalizations.of(context).txtLblWizard3;
            h2 = AppLocalizations.of(context).txtLblWizard3_3;
            break;
        }

        return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(children: <Widget>[

              Container(
                height: 200.0,
                child: Image.asset(
                  i,
                  fit: BoxFit.contain,
                  height: 200.0,
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Column(
                  children: <Widget>[
                    Text(h1,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'MontserratSemiBold',
                            color: AppTheme.riverBed[50])),
                    Text(
                      h2,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'MontserratBold',
                          color: AppTheme.bigStone[50]),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );

      },
    ).toList();
  }

  @override
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  OnboardingProvider() {
    _current = 0;
    notifyListeners();
  }

  reOnboardingProvider() {
    _current = 0;
    notifyListeners();
  }

  ///Getters
  ///
  // ignore: unnecessary_getters_setters
  UseCases get useCases => _useCases;

  int get current => _current;

  // ignore: unnecessary_getters_setters
  BuildContext get context => _context;

  ///Setters
  ///

  // ignore: unnecessary_getters_setters
  set useCases(UseCases value) {
    _useCases = value;
  }

  // ignore: unnecessary_getters_setters
  set context(BuildContext value) {
    _context = value;
  }

  set current(int value) {
    _current = value;
    notifyListeners();
  }
}
