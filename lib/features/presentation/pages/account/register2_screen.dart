import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/entities/account/user_register.dart';
import 'package:gbjatolye/features/presentation/provider/register2_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Account/register2_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/scroll_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register2Screen extends StatefulWidget {
  final _useCases;

  Register2Screen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return Register2ScreenState();
  }
}

class Register2ScreenState extends State<Register2Screen>
    with AfterLayoutMixin<Register2Screen> {
  Register2Provider register2Provider;

  @override
  void afterFirstLayout(BuildContext context)async {
    register2Provider.pageIntent = appIntent.intent;

    if (appIntent.intent == PageIntents.ToVerifyCodeFromForgetPassword) {
      print(appIntent.data);
      register2Provider.userRegisterRequest = UserRegisterRequest(phone: appIntent.data);
      register2Provider.useCases = widget._useCases;
      register2Provider.context = context;
      register2Provider.requestSmsCode();
    }
    else{
      print(appIntent.data);
      register2Provider.userRegisterRequest = appIntent.data;
      register2Provider.useCases = widget._useCases;
      register2Provider.context = context;
      register2Provider.requestSmsCode();
    }


  }

  @override
  Widget build(BuildContext context) {
    register2Provider = Provider.of<Register2Provider>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme.white[50],
          actions: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      child: Image.asset(
                        'images/ic_back.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                      padding: EdgeInsets.only(left: 15.0,top: 15.0,bottom: 15.0, right: 15),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right:40.0),
                      child: Text(
                        appIntent.intent !=
                                PageIntents.ToVerifyCodeFromForgetPassword
                            ? AppLocalizations.of(context).txtTitleRegister2
                            : AppLocalizations.of(context)
                                .txtTitleNewPasswordVerify,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ScrollWidget(
            widget: Register2Widget(
                register2Provider: register2Provider,
                useCases: widget._useCases)));
  }
}
