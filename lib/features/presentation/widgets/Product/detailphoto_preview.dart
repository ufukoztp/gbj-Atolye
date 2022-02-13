import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailPhotoPreviewScreen extends StatefulWidget {
  final String photoUrl;

  DetailPhotoPreviewScreen(this.photoUrl);

  @override
  State<StatefulWidget> createState() {
    return DDetailPhotoPreviewScreenState();
  }
}

class DDetailPhotoPreviewScreenState extends State<DetailPhotoPreviewScreen>
    with AfterLayoutMixin<DetailPhotoPreviewScreen> {
  @override
  void afterFirstLayout(BuildContext context) async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onVerticalDragEnd: (s) {
          Navigator.of(context).pop();
        },
        child: PhotoViewGallery.builder(
          loadingChild: Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppTheme.azureRadiance[50]),
            ),
          ),
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            String fullUrl = widget.photoUrl;

            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(fullUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained,
            );
          },
          itemCount: 1,
          //onPageChanged: onPageChanged,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "Çıkmak için aşağıya kaydırınız",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
