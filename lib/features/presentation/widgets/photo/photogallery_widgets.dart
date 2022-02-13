import 'dart:io';
import 'package:gbjatolye/features/presentation/provider/photopicker_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';


class PhotoGalleryWidget extends StatefulWidget {

  final PhotoPickerProvider photoPickerProvider;
  final useCases;

  PhotoGalleryWidget(
      {Key key, @required this.photoPickerProvider, @required this.useCases})
      : super(key: key);

  @override
  _PhotoGalleryWidgetState createState() => _PhotoGalleryWidgetState();
}

class _PhotoGalleryWidgetState extends State<PhotoGalleryWidget> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Stack(
        //fit: StackFit.expand,
        children: <Widget>[

          Visibility(
            visible: widget.photoPickerProvider.resultList.length == 0 ? true : false,
            child:Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(AppLocalizations.of(context).txtLblNotUploadedPhoto,
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center),
              ),
            ) ,
          ),

          Visibility(
            visible: widget.photoPickerProvider.resultList.length == 0 ? false : true,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  child:Text(AppLocalizations.of(context).txtLblClickEditPhoto,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'GothamBook',
                          color: AppTheme.collectionPageColor[50]),
                      textAlign: TextAlign.center),
                  padding: EdgeInsets.all(15.0),
                ),
                Expanded(
                  child:GridView.builder(
                    shrinkWrap: false,
                    key: PageStorageKey("list1"),
                    itemCount: widget.photoPickerProvider.resultList.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) => Stack(
                      children: [
                        InkWell(
                          child: Container(
                             child: Crop.file(
                              widget.photoPickerProvider.resultList[index],
                              key: widget.photoPickerProvider.imageKeys[index],
                              aspectRatio: 1.0 / 1.0,
                            ),
                          ),
                          onTap: () async {
                            widget.photoPickerProvider.uploadPhotosBtnShow=false;
                            File image = await widget.photoPickerProvider.cropPhoto(widget.photoPickerProvider.resultList[index]);
                            if (image != null) {
                              widget.photoPickerProvider.imageIndex = index;
                              widget.photoPickerProvider.updateResultList(await widget.photoPickerProvider.reWriteImage(image), index);
                            }
                            widget.photoPickerProvider.uploadPhotosBtnShow=true;
                          },
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                                onTap: ()async{
                                  setState(() {
                                     widget.photoPickerProvider.resultList.removeAt(index);
                                     widget.photoPickerProvider.images.removeAt(index);

                                     if(widget.photoPickerProvider.resultList.length==0){
                                       widget.photoPickerProvider.uploadPhotosBtnShow=false;
                                       widget.photoPickerProvider.images.clear();
                                     }
                                     widget.photoPickerProvider.uploadPhotosBtnShow=true;


                                  });


                                },
                                child: Stack(
                                  children: [
                                    Icon(Icons.clear,color:Colors.white,size: 32,),

                                    Icon(Icons.clear,color: AppTheme.bigStone[50],size: 30,),
                                  ],
                                )))
                      ],
                    ),
                  ),
                )

              ],
            ),
          )

        ],
      ),
    );
  }
}
