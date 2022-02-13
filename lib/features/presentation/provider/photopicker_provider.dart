import 'dart:io';
import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/messagedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
 import 'package:path_provider/path_provider.dart';
import 'package:image_crop/image_crop.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

abstract class PhotoPickerProviderUseCases {

  ///Resim kırpma işlemleri
  Future<File> cropPhoto(File image);

  ///Galeriden alınan fotoğrafların localden temizlenmesi sağlar.
  Future<void> clearTempData(var dir);

  ///Resim gönderildikten sonra tüm herşeyi sıfırla
  Future<void> clearAllData();

  Future<File> reWriteImage(File f);

  ///Galeriden fotoğrafları alıp local'e kaydet
  Future<void> loadAssets();

  List<T> mapping<T>(List list, Function handler);

  ///Slider için image view ları doldurur
  List productImageViewList();

  void fillKeys();

  void addImageKeys(GlobalKey<CropState> gk);

  void uploadPhotos();

  rePhotoPickerProvider();

}

class PhotoPickerProvider
    with ChangeNotifier
    implements PhotoPickerProviderUseCases {

  var uri = Uri.parse(AppApi.getRequestUrl(AppApi.ADDPRODUCTS_API ));
  List<Asset> _images;
  String _error;
  List<File> _resultList;
  List _child;
  int _imageIndex = 0;
  List<int> _cropImage;
  UseCases _useCases;
  BuildContext _context;
  List<GlobalKey<CropState>> _imageKeys;
  HomeCategory _homeCategory;
  bool _uploadPhotosBtnShow;

  bool get uploadPhotosBtnShow => _uploadPhotosBtnShow;

  HomeCategory get homeCategory => _homeCategory;

  List<GlobalKey<CropState>> get imageKeys => _imageKeys;

  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  List<int> get cropImage => _cropImage;

  int get imageIndex => _imageIndex;

  List get child => _child;

  String get error => _error;

  List<Asset> get images => _images;

  List<File> get resultList => _resultList;

  set imageKeys(List<GlobalKey<CropState>> value) {
    _imageKeys = value;
    notifyListeners();
  }

  set uploadPhotosBtnShow(bool value) {
    _uploadPhotosBtnShow = value;
    notifyListeners();
  }

  set homeCategory(HomeCategory value) {
    _homeCategory = value;
    notifyListeners();
  }

  set cropImage(List<int> value) {
    _cropImage = value;
    notifyListeners();
  }

  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }

  set context(BuildContext value) {
    _context = value;
    notifyListeners();
  }

  set imageIndex(int value) {
    _imageIndex = value;
    notifyListeners();
  }

  set child(List value) {
    _child = value;
    notifyListeners();
  }

  set resultList(List<File> value) {
    _resultList = value;
    notifyListeners();
  }

  set error(String value) {
    _error = value;
    notifyListeners();
  }

  set images(List<Asset> value) {
    _images = value;
    notifyListeners();
  }

  PhotoPickerProvider() {
    _images = [];
    _resultList = List<File>();
    _child = List<Widget>();
    _cropImage = List<int>();
    _imageKeys = List<GlobalKey<CropState>>();
    _uploadPhotosBtnShow=true;
  }


  @override
  rePhotoPickerProvider() {
    _images = [];
    _resultList = [];
    _child = [];
    _cropImage = [];
    _imageKeys = [];
    _uploadPhotosBtnShow=true;

  }

  void updateResultList(File file, int index) {
    print("update resultlist");

    _resultList[index] = file;
    notifyListeners();
  }

  @override
  Future<File> cropPhoto(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'FOTOĞRAF DÜZENLE',
        toolbarColor: AppTheme.darkTangerine[50],
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
      ),
      iosUiSettings: IOSUiSettings(
          doneButtonTitle: AppLocalizations.of(context).txtBtnCropOk,
          cancelButtonTitle: AppLocalizations.of(context).txtBtnCropCancel),
      maxWidth: 512,
      maxHeight: 512,
    );
    print("success crop");
    return croppedFile;
  }

  @override
  // ignore: missing_return
  Future clearTempData(dir) {
    ///Eğer data mevcutsa temizle
    var files = dir.listSync().toList();
    files.forEach((i) {
      i.deleteSync();
    });
  }

  @override
  Future<File> reWriteImage(File f) async {
     var absdir;

    if(Platform.isAndroid){
       absdir = (await getApplicationDocumentsDirectory()).path;
    }
    else{
      absdir =  (await getTemporaryDirectory()).path;
    }

    final dir = Directory(absdir + "/TempAppImages");

    File file;

    var ms = (new DateTime.now()).millisecondsSinceEpoch;
    var date = (ms / 1000).round();

    try {
      file = new File(dir.path + "/" + date.toString() + images[imageIndex].name);
      final data = f.readAsBytesSync();
      file.writeAsBytesSync(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
      var decodedImage = await decodeImageFromList(data);
      if (decodedImage.width == decodedImage.height)
        cropImage.remove(imageIndex);
    } catch (e) {
      debugPrint(e.toString()+"--------- hatası -----");
    }
    return file;
  }

  @override
  Future<void> loadAssets() async {

    fillKeys();

    String error = 'No Error Dectected';

    List<Asset> _resultList = [];

    ///take photos with original raw datas
    try {
      _resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: false,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: "#0091FF",
          statusBarColor: '#0091FF',
          actionBarTitle: AppLocalizations.of(context).txtLblAlbums,
          allViewTitle: AppLocalizations.of(context).txtLblAllAlbums,
          useDetailsView: false,
          selectCircleStrokeColor: "#FFFFFF",
          selectionLimitReachedText: "",
          textOnNothingSelected: "",
        ),
        cupertinoOptions: CupertinoOptions(
          selectionFillColor: "#0091FF",
          backgroundColor: "#F3F4F8",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    ///Save photos to my local device from icloud etc

    showPreloader(context, "");

    var absdir;
    if(Platform.isAndroid){
      absdir = (await getApplicationDocumentsDirectory()).path;
    }
    else{
      absdir =  (await getTemporaryDirectory()).path;
    }
    final dir = Directory(absdir + "/TempAppImages");
    final List<File> tempImages = new List<File>();

    try {

      if (dir.existsSync())
        await clearTempData(dir);
      else
        dir.createSync();

      for (int i = 0; i < _resultList.length; i++) {

        File file = new File(dir.path + "/" + _resultList[i].name.toString());

        final data = await _resultList[i].getByteData(quality: 50);

        await file.writeAsBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

        tempImages.add(file);

      }

      images = _resultList;
      resultList = tempImages;

      error = error;
    } catch (e) {
      debugPrint(e.toString());
    }

    hidePreloader(context);
  }

  @override
  List<T> mapping<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  List productImageViewList() {
    var mapList = mapping<Widget>(
      resultList,
          (index, i) {
        return InkWell(
          child: Container(
            width: 50.0,
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              //borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Crop.file(
                i,
                key: imageKeys[index],
                aspectRatio: 1.0 / 1.0,
              ),
            ),
          ),
          onTap: () async {
            File image = await cropPhoto(resultList[index]);
            if (image != null) {
              imageIndex = index;
              updateResultList(await reWriteImage(image), index);
            }
          },
        );
      },
    ).toList();
    return mapList;
  }

  @override
  void uploadPhotos() async {


    showPreloader(context, "");

    try {
      List<File> imageList = List<File>();

      for (int i = 0; i < resultList.length; i++) {
        final scale = _imageKeys[i].currentState.scale;

        final area = _imageKeys[i].currentState.area;

        final sample = await ImageCrop.sampleImage(
          file: resultList[i],
          preferredSize: (2000 / scale).round(),
        );

        final file = await ImageCrop.cropImage(
          file: sample,
          area: area,
        );

        imageList.add(file);
      }

      var result = await useCases.getLocalUserToken();

      result.fold((exception) {
        SnackbarErrors(context: context, exp: exception);
      }, (token) async {

        var request = MultipartRequest('POST',uri);


        request.headers['authorization'] = "bearer " + token;
        for (int i = 0; i < imageList.length; i++) {
          request.files.add(
            MultipartFile(
                'files',
                // ignore: deprecated_member_use
                ByteStream(DelegatingStream.typed(imageList[i].openRead())),
                await imageList[i].length(),
                filename: basename(imageList[i].path),
                contentType: MediaType.parse("image/jpg")),
          );
          print(imageList[i]);
        }
        print("jewelery id "+homeCategory.jewelrytypeid.toString());
        print("collection id "+homeCategory.collectionGroupId.toString());
        print("supplier id "+homeCategory.supplierId.toString());

        request.fields['JewelryTypeId'] = homeCategory.jewelrytypeid.toString();
        request.fields['CollectionGroupId'] = homeCategory.collectionGroupId.toString();
        request.fields['SupplierId'] = homeCategory.supplierId.toString();

      var result= await useCases.addProductImages(request);

      result.fold((exception) {
        SnackbarErrors(context: context, exp: exception);

      }, (model) {print(model);});

        images.clear();
        resultList.clear();

        hidePreloader(context);

        MessageDialogTypes dialogOption = await asyncFilterMessageDialog(
            context,
            DialogType.AddMoreProduct,
          //  AppLocalizations.of(context).txtPopupPhotoAddRequest,
          appIntent.data["titleName"]+ " kategorisine daha fazla ürün eklemek ister misiniz?"
        );

        if (dialogOption != null && dialogOption == MessageDialogTypes.OK) loadAssets();
        else if (dialogOption != null && dialogOption == MessageDialogTypes.CANCEL) Navigator.of(context).pop();

        /*
        addProductResponse.fold((exception) {
          hidePreloader(context);
          SnackbarErrors(context: context, exp: exception);
        }, (token) async {
          clearAllData();
          hidePreloader(context);
          appSnackbar(context, "Resimleriniz yüklendiğinde bildirim alacaksınız.");
        });

         */
      });
    } catch (ex) {
      hidePreloader(context);
    }
  }

  @override
  void addImageKeys(GlobalKey<CropState> gk) {
    imageKeys.add(gk);
    notifyListeners();
  }

  @override
  void fillKeys() {
    imageKeys.clear();
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
    addImageKeys(GlobalKey<CropState>());
  }

  // ignore: missing_return
  Future<void> clearAllData() {
    resultList = List<File>();
    images = [];
  }

}
