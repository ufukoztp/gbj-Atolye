import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/login_provider.dart';

import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginInputsWidget extends StatefulWidget {
  final LoginProvider loginProvider;
  final UseCases useCase;

  LoginInputsWidget({@required this.loginProvider, @required this.useCase});

  @override
  
  _LoginInputsWidgetState createState() => _LoginInputsWidgetState();
}

class _LoginInputsWidgetState extends State<LoginInputsWidget> {


  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.loginProvider.formKey,
        // ignore: deprecated_member_use
       // autovalidate: widget.loginProvider.autoValidate,
        child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /*
            new Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).txtLblGsmNumber,
                    style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'GothamBook',
                        color: AppTheme.eclipse[50]),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: widget.loginProvider.numberInputWidth,
                        child: CountryCodePicker(
                          padding: EdgeInsets.all(0),
                          onChanged: (code) {
                           widget.loginProvider.updateCountryDialCode(code.dialCode);
                          },
                          initialSelection: 'TR',
                          favorite: ['+90', 'TR'],
                          showCountryOnly: false,
                          textStyle: Theme.of(context).textTheme.display1,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: true,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: widget.loginProvider.userGsmController,
                          style: Theme.of(context).textTheme.display1,
                          cursorColor: AppTheme.darkTangerine[50],
                          maxLength: 15,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: false),
                          decoration: new InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(bottom: 2.0,top: 2.0),
                              hintText: "535 123 4567",
                              alignLabelWithHint: false,
                              counterText: ""),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            */

                 Container(
                  margin: EdgeInsets.only(top: 20.0,bottom: 20.0),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/ic_home_title.png',
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),

                /* Gsm Number Input */
                 Container(
                  child: Center(
                    child: TextFormField(
                      controller: widget.loginProvider.userGsmController,
                      style: Theme.of(context).textTheme.headline4,
                      
                      cursorColor: AppTheme.bigStone[50],

                      inputFormatters: [widget.loginProvider.maskFormatter],
                      validator: (String arg) {
                        if (arg.contains("+")) {
                          if (arg.length < 18)
                            return AppLocalizations.of(context)
                                .txtErMisPhoneNumber;
                        } else {
                          if (arg.length < 11)
                            return AppLocalizations.of(context)
                                .txtErMisPhoneNumber;
                        }
                        return null;
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                      decoration: new InputDecoration(

                          contentPadding: EdgeInsets.only(top: 10.0),
                          labelText:
                              AppLocalizations.of(context).txtLblGsmNumber,
                          errorStyle: Theme.of(context).textTheme.headline2,
                          labelStyle: Theme.of(context).textTheme.headline1,

                          alignLabelWithHint: true,
                          counterText: ""),
                    ),
                  ),
                  width: double.maxFinite,
                ),

                /* Password Input */
                new Stack(
                    alignment: const Alignment(1.0, 1.0),
                    children: <Widget>[
                      new Container(
                        child: TextFormField(
                          controller: widget.loginProvider.passwordController,
                          style: Theme.of(context).textTheme.headline4,
                          validator: (String arg) {
                            if (arg.length < 6)
                              return AppLocalizations.of(context)
                                  .txtErMisCharacter;
                            else
                              return null;
                          },
                          obscureText: widget.loginProvider.obscureText,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10.0),
                              labelText:
                                  AppLocalizations.of(context).txtLblPassword,
                              errorStyle: Theme.of(context).textTheme.headline2,
                              labelStyle: Theme.of(context).textTheme.headline1,
                              alignLabelWithHint: true,
                              counterText: ""),
                          maxLength: 20,
                          maxLines: 1,
                          onChanged: (e) {
                            if (widget.loginProvider.passwordController.text
                                    .length >
                                0)
                              widget.loginProvider.eyeClosed = true;
                            else {
                              widget.loginProvider.eyeOpened = false;
                              widget.loginProvider.eyeClosed = false;
                            }
                          },
                        ),
                        margin: EdgeInsets.only(top: 10.0),
                        width: double.maxFinite,
                      ),
                      Positioned(
                        top: 35.0,
                        child: InkWell(
                          child: Visibility(
                            visible: widget.loginProvider.eyeClosed,
                            child: Container(
                              child: Center(
                                child: Image.asset(
                                  'images/ic_eye_closed.png',
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            widget.loginProvider.eyeClosed = false;
                            widget.loginProvider.eyeOpened = true;
                            widget.loginProvider.obscureText = false;
                          },
                        ),
                      ),
                      Positioned(
                        top: 35.0,
                        child: InkWell(
                          child: Visibility(
                            visible: widget.loginProvider.eyeOpened,
                            child: Container(
                              child: Image.asset(
                                'images/ic_eye_opened.png',
                                width: 25,
                                height: 25,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          onTap: () {
                            widget.loginProvider.eyeClosed = true;
                            widget.loginProvider.eyeOpened = false;
                            widget.loginProvider.obscureText = true;
                          },
                        ),
                      )
                    ]),

                /* Forget Password & Remember Me*/
                new Container(
                  margin: EdgeInsets.only(top: 30),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              AppLocalizations.of(context)
                                  .txtBtnLoginForgetPassword,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14.0,
                                  fontFamily: 'MontserratSemiBold',
                                  color: AppTheme.riverBed[50]),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.forgotpassword1);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeColor: AppTheme.aqua[50],
                              value: widget.loginProvider.switchRememberme,
                              onChanged: (bool value) async {
                                widget.loginProvider.switchRememberme =
                                    !widget.loginProvider.switchRememberme;
                              },
                            ),
                          ),
                          GestureDetector(
                            child: new InkWell(
                              child: Center(
                                child: Container(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .txtCbRememberMe,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'MontserratSemiBold',
                                        color: AppTheme.riverBed[50]),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              widget.loginProvider.switchRememberme =
                                  !widget.loginProvider.switchRememberme;

                              widget.loginProvider.rememberMeState=  !widget.loginProvider.rememberMeState;
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),

                /* Login Button */
                new Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              gradient: LinearGradient(colors: <Color>[
                                AppTheme.aqua[50],
                                AppTheme.azureRadiance[50],
                              ])),
                          padding: EdgeInsets.all(15.0),
                          child: Text(AppLocalizations.of(context).txtBtnLogin,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.button),
                        ),
                        onTap: () {
                          if(widget.loginProvider.switchRememberme==true){
                            widget.loginProvider.rememberMeState=true;
                            widget.loginProvider.prf.setString("number",widget.loginProvider.maskFormatter.getUnmaskedText().toString());
                            print('login widgetten gelen number'+widget.loginProvider.maskFormatter.getUnmaskedText().toString());
                          //  widget.loginProvider.prf.setString("password", widget.loginProvider.passwordController.text);
                            widget.loginProvider.prf.setBool(PrefKeys.REMEMBERME_KEYS, widget.loginProvider.rememberMeState);
                         
                          }else{
                            widget.loginProvider.rememberMeState=false;
                            widget.loginProvider.prf.setBool(PrefKeys.REMEMBERME_KEYS, widget.loginProvider.rememberMeState);
                          }
                          widget.loginProvider.doLogin();
                        },
                      ),
                    ),
                  ]),
                ),

                /* Haven't an account Button */

                new Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Center(
                      child: Container(
                          child: Text(
                        AppLocalizations.of(context).txtLblDontHaveAccount,
                        style: Theme.of(context).textTheme.headline4,
                      )
                      ),
                    )
                  ]),
                ),

                /* Register Button */
                new Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Center(
                      child: InkWell(
                        child: Container(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              AppLocalizations.of(context).txtBtnLoginRegister,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14.0,
                                  fontFamily: 'MontserratSemiBold',
                                  color: AppTheme.riverBed[50]),
                            )),
                        onTap: () {
                          Navigator.pushNamed(context,  AppRoutes.register1);
                        },
                      ),
                    )
                  ]),
                )
              ],
            )
    );
  }

}
