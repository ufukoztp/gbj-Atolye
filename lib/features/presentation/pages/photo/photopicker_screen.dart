import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/presentation/provider/photopicker_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/photo/photogallery_widgets.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PhotoPickerScreen extends StatefulWidget {

  final _useCases;

  PhotoPickerScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return _PhotoPickerScreenState();
  }

}

class _PhotoPickerScreenState extends State<PhotoPickerScreen>
    with AfterLayoutMixin<PhotoPickerScreen> {

  PhotoPickerProvider _photoPickerProvider;

  @override
  void afterFirstLayout(BuildContext context) {
    HomeCategory category = HomeCategory.fromJson(appIntent.data);
    _photoPickerProvider.homeCategory=category;
    _photoPickerProvider.context = context;
    _photoPickerProvider.error = AppLocalizations.of(context).txtLblNoSelectedPhoto;
    _photoPickerProvider.rePhotoPickerProvider();
    _photoPickerProvider.loadAssets();
    _photoPickerProvider.useCases = widget._useCases;
  }


  @override
  Widget build(BuildContext context) {

    _photoPickerProvider = Provider.of<PhotoPickerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.white[50],
        actions: <Widget>[
          Expanded(
            child: Container(
              width: 300,
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
                      padding: EdgeInsets.only(left: 15, right: 15,top: 15,bottom: 15),
                    ),
                  ),
                  Expanded(
                      child: Text(
                          AppLocalizations.of(context).txtTitlePhotoPicker,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center),
                  ),
                  InkWell(
                    onTap: () async {
                      var status= await Permission.photos.isDenied;
                      var status2= await Permission.photos.isGranted;
                      if(status==true){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => CupertinoAlertDialog(
                              title: Text('gbjatolye Fotoğraflarınıza Erişmek İstiyor'),
                              content: Text(
                                  'Allow access your photo library'),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text('İzin Verme'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                CupertinoDialogAction(
                                  child: Text('Tamam'),
                                  onPressed: () => openAppSettings(),
                                ),
                              ],
                            ));                      }

                      _photoPickerProvider.loadAssets();
                      if(_photoPickerProvider.resultList.length!=0){
                        _photoPickerProvider.uploadPhotosBtnShow=true;
                        setState(() {
                        });

                      }
                    },
                    child: Padding(
                      child: Image.asset(
                        'images/ic_route_gallery.png',
                        width: 25,
                        height: 25,
                        fit: BoxFit.contain,
                      ),
                      padding: EdgeInsets.only(left: 15.0, right: 15.0,top: 10.0,bottom: 10.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: PhotoGalleryWidget(
        useCases: widget._useCases,
        photoPickerProvider: _photoPickerProvider,
      ),
      bottomNavigationBar: Visibility(
        visible: _photoPickerProvider.resultList.length == 0 ? false : true && _photoPickerProvider.uploadPhotosBtnShow,
        child: GestureDetector(
          child: BottomAppBar(
            color: AppTheme.darkTangerine[50],
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 20.0,
                          spreadRadius: 20.0,
                          offset: Offset(0.0, 20.0)),
                    ],
                    gradient: LinearGradient( colors: <Color>[
                      AppTheme.aqua[50],
                      AppTheme.azureRadiance[50],
                    ])),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      height: 50,
                      child: Center(
                          child: Text(
                              AppLocalizations.of(context).txtBtnUploadPhotos,
                              style: Theme.of(context).textTheme.button,
                              textAlign: TextAlign.center)),
                    ))
                  ],
                )),
          ),
          onTap: () async {
            print("tap to photo upload");
            _photoPickerProvider.uploadPhotos();

          },
        ),
      ),


    );
  }
}
