

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbjatolye/features/presentation/provider/forgotpassword2_provider.dart';
import 'package:gbjatolye/features/presentation/provider/forgotpassword3_provider.dart';
import 'package:gbjatolye/features/presentation/provider/homepage_provider.dart';
import 'package:gbjatolye/features/presentation/provider/notifications_provider.dart';
import 'package:gbjatolye/features/presentation/provider/onboarding_provider.dart';
import 'package:gbjatolye/features/presentation/provider/options_provider.dart';
import 'package:gbjatolye/features/presentation/provider/orderlist_provider.dart';
import 'package:gbjatolye/features/presentation/provider/photopicker_provider.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/provider/productlist_provider.dart';
import 'package:gbjatolye/features/presentation/provider/register1_provider.dart';
import 'package:gbjatolye/features/presentation/provider/register2_provider.dart';
import 'package:gbjatolye/features/presentation/provider/register3_provider.dart';
import 'package:gbjatolye/features/presentation/provider/settings_provider.dart';
import 'package:gbjatolye/features/presentation/provider/splash_provider.dart';
import 'package:gbjatolye/features/presentation/provider/ticket_provider.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:provider/provider.dart';
import 'dependecy_injection/app_injector.dart';
import 'dependecy_injection/app_module.dart';
import 'features/presentation/provider/forgotpassword1_provider.dart';
import 'features/presentation/provider/login_provider.dart';
import 'features/presentation/provider/productlist_provider.dart';


void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppTheme.azureRadiance[50], // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  var container = await AppInjector.create(AppModule());

  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductListProvider()),
        ChangeNotifierProvider(create: (context)=> LoginProvider(),),
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context)=>ForgotPassword1Provider(),),
        ChangeNotifierProvider(create: (context)=>ForgotPassword2Provider(),),
        ChangeNotifierProvider(create: (context)=>ForgotPassword3Provider(),),
        ChangeNotifierProvider(create: (context)=>Register1Provider(),),
        ChangeNotifierProvider(create: (context)=>Register2Provider(),),
        ChangeNotifierProvider(create: (context)=>Register3Provider(),),
        ChangeNotifierProvider(create: (context)=>HomePageProvider(),),
        ChangeNotifierProvider(create: (context)=>SettingsProvider(),),
        ChangeNotifierProvider(create: (context)=>TicketProvider(),),
        ChangeNotifierProvider(create: (context) => PhotoPickerProvider()),
        ChangeNotifierProvider(create: (context) => NotificationsProvider()),
        ChangeNotifierProvider(create: (context) => OrderListProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (context) => OptionPageProvider()),
      ],
      child: container.app,
    ),
  );

}