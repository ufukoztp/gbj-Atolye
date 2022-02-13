import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/localizations/lang/messages_all.dart';
import 'package:intl/intl.dart';

class AppLocalizations {

  AppLocalizations(this.locale);

  final Locale locale;

  // Load function will load the string resources from the desired Locale as you can see in the parameter.
  static Future<AppLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return AppLocalizations(locale);
    });
  }

  // Of function will be a helper like any other InheritedWidget to facilitate the access to any string from any part of the app code.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  //New Page Titles

  String get txtTitleLogin => Intl.message(
        'ÜYE GİRİŞİ',
        name: 'txtTitleLogin',
        args: [],
        locale: locale.toString(),
      );

  String get txtTitleSupport => Intl.message(
    'GBJ DESTEK',
    name: 'txtTitleSupport',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitlePhotoPicker => Intl.message(
    'FOTOĞRAF DÜZENLE',
    name: 'txtTitlePhotoPicker',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleProductDetail => Intl.message(
    'ÜRÜN DETAY',
    name: 'txtTitleProductDetail',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleHome => Intl.message(
    'BİJUTERİ',
    name: 'txtTitleHome',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleForgetPassword1 => Intl.message(
    'ŞİFREMİ UNUTTUM',
    name: 'txtTitleForgetPassword1',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleProductList => Intl.message(
    'ÜRÜNLER',
    name: 'txtTitleProductList',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleRegister1 => Intl.message(
        'ÜYELİK BİLGİLERİ (1/3)',
        name: 'txtTitleRegister1',
        args: [],
        locale: locale.toString(),
      );

  String get txtTitleRegister2 => Intl.message(
    'DOĞRULAMA KODU (2/3)',
    name: 'txtTitleRegister2',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleNewPasswordVerify => Intl.message(
    'DOĞRULAMA KODU',
    name: 'txtTitleNewPasswordVerify',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleRegister3 => Intl.message(
    'ADRES SEÇİMİ (3/3)',
    name: 'txtTitleRegister3',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleTermOfCond => Intl.message(
    'KULLANIM KOŞULLARI',
    name: 'txtTitleTermOfCond',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleTerm1 => Intl.message(
    'I. TARAFLAR',
    name: 'txtTitleTerm1',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleTerm2 => Intl.message(
    'II. AMAÇ',
    name: 'txtTitleTerm2',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleTerm3 => Intl.message(
    'III. KAPSAM',
    name: 'txtTitleTerm3',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleTerm4 => Intl.message(
    'IV. KİŞİSEL VERİLERİN KORUNMASI',
    name: 'txtTitleTerm4',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleTerm5 => Intl.message(
    'V. BİJUTERİ',
    name: 'txtTitleTerm5',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleTerm6 => Intl.message(
    'VI. SON HÜKÜMLER',
    name: 'txtTitleTerm6',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleNewPassword => Intl.message(
    'YENİ ŞİFRE',
    name: 'txtTitleNewPassword',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleChangedPassword => Intl.message(
    '',
    name: 'txtTitleChangedPassword',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleNotifications => Intl.message(
    'BİLDİRİMLER',
    name: 'txtTitleNotifications',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleOrders => Intl.message(
    'SİPARİŞLER',
    name: 'txtTitleOrders',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleRequestAndRepair => Intl.message(
    'TALEP VE ARIZA LİSTESİ',
    name: 'txtTitleRequestAndRepair',
    args: [],
    locale: locale.toString(),
  );

  String get txtTitleSettings => Intl.message(
    'AYARLAR',
    name: 'txtTitleSettings',
    args: [],
    locale: locale.toString(),
  );


  //New Tabs Texts

  String get txtTabsEnableSale => Intl.message(
    'Satışa Açık Ürünler',
    name: 'txtTabsEnableSale',
    args: [],
    locale: locale.toString(),
  );

  String get txtTabsDisableSale => Intl.message(
    'Satışa Kapalı Ürünler',
    name: 'txtTabsDisableSale',
    args: [],
    locale: locale.toString(),
  );

  String get txtTabsWaitingOrders => Intl.message(
    'BEKLEYEN',
    name: 'txtTabsWaitingOrders',
    args: [],
    locale: locale.toString(),
  );

  String get txtTabsManufacturingOrders => Intl.message(
    'ÜRETİLEN',
    name: 'txtTabsManufacturingOrders',
    args: [],
    locale: locale.toString(),
  );

  String get txtTabsProblematicOrders => Intl.message(
    'YETİŞMEYECEK',
    name: 'txtTabsProblematicOrders',
    args: [],
    locale: locale.toString(),
  );

  String get txtTabsReadyOrders => Intl.message(
    'HAZIR',
    name: 'txtTabsReadyOrders',
    args: [],
    locale: locale.toString(),
  );



  //New Popup Texts

  String get txtPopupLocation => Intl.message(
    'Konum bilginiz kapalı gözüküyor. Bu işleme devam edebilmemiz için konum ayarlarınız açmanız gerekmektedir.',
    name: 'txtPopupLocation',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupExitApp => Intl.message(
    'Oturumu sonlandırmak istediğinizden emin misiniz?',
    name: 'txtPopupExitApp',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupWaitLike => Intl.message(
    'Bu ürün bilgilerini doldurabilmeniz için müşteri tarafından beğeni almanız gerekmektedir.',
    name: 'txtPopupWaitLike',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupCancelDetailChanged => Intl.message(
    'Bu üründe kaydedilmemiş değişiklikler gözüküyor. Eğer ekranı sonlandırırsanız yaptığınız değişiklikler kaydedilmeyecektir. Yine de ekranı sonlandırmak istiyor musunuz?',
    name: 'txtPopupCancelDetailChanged',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupChangeOrderProductStatus => Intl.message(
    'Ürünlerinizin sipariş durumlarını aşağıdaki seçeneklerden değiştirebilirsiniz.',
    name: 'txtPopupChangeOrderProductStatus',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupChangeProductStatus=> Intl.message(
    'Ürünlerinizi satışa açabilir, satışa kapatabilir ya da silebilirsiniz.\n DİKKAT : Silme işlemini geri alınamaz!',
    name: 'txtPopupChangeProductStatus',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupSureRemoveProduct=> Intl.message(
    'Seçili ürünleri silmek istediğinize emin misiniz? Bu işlem sonradan geri alınamaz!',
    name: 'txtPopupSureRemoveProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupProductSort=> Intl.message(
    'Ürünlerinizi yapılan en son beğeni, en son ekleme veya eklenen ürün sayısı gibi sıralamalar yapabilirsiniz.',
    name: 'txtPopupSureRemoveProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupPhotoAddRequest=> Intl.message(
    'Fotoğraf ekleme isteğiniz başarıyla iletilmiştir.\nYükleme işlemi tamamlandığında bilgilendireleceksiniz.',
    name: 'txtPopupPhotoAddRequest',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupChooseOptionsTitle=> Intl.message(
    'SEÇENEKLERİ GİRİN',
    name: 'txtPopupChooseOptionsTitle',
    args: [],
    locale: locale.toString(),
  );

  String get txtPopupChooseOptionsDescription=> Intl.message(
    'Müşterilerimize sunmak istediğiniz seçenekleri seçin',
    name: 'txtPopupChooseOptionsDescription',
    args: [],
    locale: locale.toString(),
  );

  //New Snackbar Messages

  String get txtSBTermOfCond => Intl.message(
    'Kullanım koşullarını kabul etmeden devam edemezsiniz',
    name: 'txtSBTermOfCond',
    args: [],
    locale: locale.toString(),
  );

  String get txtSBVerifyCode => Intl.message(
    'Doğrulama kodu 4 karakterden az olamaz',
    name: 'txtSBVerifyCode',
    args: [],
    locale: locale.toString(),
  );

  String get txtSBSentSmsCode => Intl.message(
    'Doğrulama kodu isteği gönderildi',
    name: 'txtSBSentSmsCode',
    args: [],
    locale: locale.toString(),
  );

  String get txtSBReSentSmsCode => Intl.message(
    'Doğrulama kodu isteği tekrar gönderildi',
    name: 'txtSBSentSmsCode',
    args: [],
    locale: locale.toString(),
  );

  String get txtSBFillRequiredFields => Intl.message(
    'Lütfen yanlarında kırmızı işaret bulunan zorunlu alanları tamamlayınız.',
    name: 'txtSBFillRequiredFields',
    args: [],
    locale: locale.toString(),
  );

  String get txtNoSelectOrderStatus => Intl.message(
    'Durumu değiştirilecek herhangi sipariş seçmediniz.',
    name: 'txtNoSelectOrderStatus',
    args: [],
    locale: locale.toString(),
  );

  String get txtNoSelectProductStatus => Intl.message(
    'Lütfen durumunu değiştirmek istediğiniz herhangi bir ürün seçiniz.',
    name: 'txtNoSelectProductStatus',
    args: [],
    locale: locale.toString(),
  );


  //New Checkbox Texts

  String get txtCbRememberMe => Intl.message(
        'Beni Hatırla',
        name: 'txtCbRememberMe',
        args: [],
        locale: locale.toString(),
      );

  String get txtCbTermOfCond1 => Intl.message(
        'Kullanım koşulları',
        name: 'txtCbTermOfCond1',
        args: [],
        locale: locale.toString(),
      );

  String get txtCbTermOfCond2 => Intl.message(
        'nı kabul ediyorum',
        name: 'txtCbTermOfCond2',
        args: [],
        locale: locale.toString(),
      );

  //New Button Texts

  String get txtAddProduct => Intl.message(
    'HEMEN ÜRÜN EKLE',
    name: 'txtAddProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtChangeProductStatus => Intl.message(
    'ÜRÜN DURUMUNU DEĞİŞTİR',
    name: 'txtChangeProductStatus',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnLogin => Intl.message(
        'GİRİŞ YAPIN',
        name: 'txtBtnLogin',
        args: [],
        locale: locale.toString(),
      );

  String get txtBtnGotIt => Intl.message(
    'ANLADIM',
    name: 'txtBtnGotIt',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnDelete => Intl.message(
    'SİL',
    name: 'txtBtnDelete',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnCancel => Intl.message(
    'VAZGEÇ',
    name: 'txtBtnCancel',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnContUpload => Intl.message(
    'YÜKLEMEYE DEVAM ET',
    name: 'txtBtnContUpload',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnEnableForSale => Intl.message(
    'ÜRÜNÜ SATIŞA AÇ',
    name: 'txtBtnEnableForSale',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnDisableForSale => Intl.message(
    'ÜRÜNÜ SATIŞA KAPAT',
    name: 'txtBtnDisableForSale',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnProductRemove => Intl.message(
    'ÜRÜNÜ SİL',
    name: 'txtBtnProductRemove',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnSortByAddedDate => Intl.message(
    'EKLENME TARİHİNE GÖRE',
    name: 'txtBtnSortByAddedDate',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnSortByLikeCount => Intl.message(
    'BEĞENİ SAYISINA GÖRE',
    name: 'txtBtnSortByLikeCount',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnSortByEditedDate => Intl.message(
    'DÜZENLENME DURUMUNA GÖRE',
    name: 'txtBtnSortByEditedDate',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnSendApprove => Intl.message(
    'ONAYA GÖNDER',
    name: 'txtBtnSendApprove',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnUploadPhotos => Intl.message(
    'FOTOĞRAFLARI YÜKLE',
    name: 'txtBtnUploadPhotos',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnSend => Intl.message(
    'GÖNDER',
    name: 'txtBtnSend',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnCropOk => Intl.message(
    'Tamam',
    name: 'txtBtnCropOk',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnCropCancel => Intl.message(
    'İptal',
    name: 'txtBtnCropCancel',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnLoginRegister => Intl.message(
        'Hemen Üye Olun',
        name: 'txtBtnLoginRegister',
        args: [],
        locale: locale.toString(),
      );

  String get txtBtnLoginForgetPassword => Intl.message(
        'Şifremi Unuttum',
        name: 'txtBtnLoginForgetPassword',
        args: [],
        locale: locale.toString(),
      );

  String get txtBtnContinue => Intl.message(
        'DEVAM',
        name: 'txtBtnContinue',
        args: [],
        locale: locale.toString(),
      );

  String get txtBtnCompleted => Intl.message(
    'TAMAMLA',
    name: 'txtBtnCompleted',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnSettings => Intl.message(
    'AYARLARA GİT',
    name: 'txtBtnSettings',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnSendVerifyCode => Intl.message(
    'DOĞRULAMA KODU GÖNDER',
    name: 'txtBtnSendVerifyCode',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnSave => Intl.message(
    'KAYDET',
    name: 'txtBtnSave',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnRouteLogin => Intl.message(
    'GİRİŞ YAP',
    name: 'txtBtnRouteLogin',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnLogout => Intl.message(
    'Çıkış Yap',
    name: 'txtBtnLogout',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnDontSave => Intl.message(
    'Kaydetme',
    name: 'txtBtnDontSave',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnReject => Intl.message(
    'Vazgeç',
    name: 'txtBtnReject',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnChangeOrderStatus => Intl.message(
    'SİPARİŞ DURUMUNU DEĞİŞTİR',
    name: 'txtBtnChangeOrderStatus',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnUploadPhotoContinue => Intl.message(
    'DEVAM ET',
    name: 'txtBtnUploadPhotoContinue',
    args: [],
    locale: locale.toString(),
  );

  String get txtBtnBack => Intl.message(
    'GERİ DÖN',
    name: 'txtBtnBack',
    args: [],
    locale: locale.toString(),
  );

  //New Label Texts

  String get txtLblDownloading => Intl.message(
    'Yükleniyor...',
    name: 'txtLblDownloading',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNote => Intl.message(
    'NOT',
    name: 'txtLblNote',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNotUploadedPhoto => Intl.message(
    'Henüz ürün eklenmedi',
    name: 'txtLblNotUploadedPhoto',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblClickEditPhoto => Intl.message(
    'İlgili fotoğrafın üzerine tıklayarak değişiklik yapabilirsiniz.',
    name: 'txtLblClickEditPhoto',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblProductApproveSending=> Intl.message(
    'Ürün onayınız iletiliyor...',
    name: 'txtLblProductApproveSending',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblProductApproveSent=> Intl.message(
    'Ürün onayınız başarıyla iletildi.',
    name: 'txtLblProductApproveSent',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPackagePrice => Intl.message(
    'Paket Fiyat',
    name: 'txtLblPackagePrice',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPiecePrice => Intl.message(
    'Gram Fiyat',
    name: 'txtLblPiecePrice',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblOptions => Intl.message(
    'Opsiyonlar',
    name: 'txtLblOptions',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblChooseOption => Intl.message(
    'Opsiyon Seç',
    name: 'txtLblChooseOption',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblSpecs => Intl.message(
    'Özellikler',
    name: 'txtLblSpecs',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblChooseSpecs => Intl.message(
    'Özellik Seç',
    name: 'txtLblChooseSpecs',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblChooseSpecsDesc => Intl.message(
    'Fotoğraftaki takıyı doğru şekilde açıklayacak tüm detayları seçin.',
    name: 'txtLblChooseSpecsDesc',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblProfile => Intl.message(
    'Profil',
    name: 'txtLblProfile',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblHome => Intl.message(
    'Home',
    name: 'txtLblHome',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblRequestAndRepair => Intl.message(
    'Talep ve Arıza',
    name: 'txtLblRequestAndRepair',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNoInternetConnection => Intl.message(
    'İnternet bağlantınız yok gibi gözüküyor. Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.',
    name: 'txtLblNoInternetConnection',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNoProduct => Intl.message(
    'kategorisine hemen ürün ekle',
    name: 'txtLblNoProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblQuiklyDetail => Intl.message(
    'HEMEN DETAYLANDIR',
    name: 'txtLblQuiklyDetail',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblGsmNumber => Intl.message(
        'GSM Numarası',
        name: 'txtLblGsmNumber',
        args: [],
        locale: locale.toString(),
      );

  String get txtLblSupportSubject => Intl.message(
    'Hangi konuda yazıyorsun?',
    name: 'txtLblSupportSubject',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblSupportDesc => Intl.message(
    'Konuyu tüm detaylarıyla anlatmak için bu alanı kullanabilirsiniz',
    name: 'txtLblSupportDesc',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblJewelryType => Intl.message(
    'Takı Türü',
    name: 'txtJewelryType',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPackageWeight => Intl.message(
    'Paketin Ağırlığı',
    name: 'txtLblPackageWeight',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblWeight => Intl.message(
    'Ağırlık',
    name: 'txtLblWeight',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblWeightUnit => Intl.message(
    'Gram',
    name: 'txtLblWeightUnit',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPrice => Intl.message(
    'Fiyat',
    name: 'txtLblPrice',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblLike => Intl.message(
    'Beğeni',
    name: 'txtLblLike',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblSingleProduct => Intl.message(
    'Tekli Ürün',
    name: 'txtLblSingleProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPackageProduct => Intl.message(
    'Paket Ürün',
    name: 'txtLblPackageProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPackageCount=> Intl.message(
    'Adet',
    name: 'txtLblPackageCount',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPackageProductCount=> Intl.message(
    'Paketteki Ürün Sayısı',
    name: 'txtLblPackageProductCount',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPackagePiece=> Intl.message(
    'Adet',
    name: 'txtLblPackagePiece',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblProductType=> Intl.message(
    'Ürün Tipi',
    name: 'txtLblProductType',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblPassword => Intl.message(
        'Şifre',
        name: 'txtLblPassword',
        args: [],
        locale: locale.toString(),
      );

  String get txtLblFPNext => Intl.message(
    'Bir sonraki ekranda telefonunuza gelen doğrulama kodunu girerek yeni bir şifre tanımlayabilirsiniz.',
    name: 'txtLblFPNext',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblCompanyName => Intl.message(
        'Atölye Adı',
        name: 'txtLblCompanyName',
        args: [],
        locale: locale.toString(),
      );

  String get txtLblPersonName => Intl.message(
        'İlgili Kişi Adı',
        name: 'txtLblPersonName',
        args: [],
        locale: locale.toString(),
      );

  String get txtLblPersonSurname => Intl.message(
    'İlgili Kişi Soyadı',
    name: 'txtLblPersonSurname',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblRePassword => Intl.message(
        'Aynı Şifreyi Tekrar',
        name: 'txtLblRePassword',
        args: [],
        locale: locale.toString(),
      );

  String get txtLblCurrency => Intl.message(
    'Fiyat Para Birimi',
    name: 'txtLblCurrency',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblVerifyCode => Intl.message(
    'Telefonunuza gelen doğrulama kodunu girin',
    name: 'txtLblVerifyCode',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblReVerifyCode => Intl.message(
    'Kod Gelmedi',
    name: 'txtLblReVerifyCode',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblCountry => Intl.message(
    'Ülke Adı',
    name: 'txtLblCountry',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblProvince => Intl.message(
    'İl',
    name: 'txtLblProvince',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblFullAdress => Intl.message(
    'Adres',
    name: 'txtLblFullAdress',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNewPassword => Intl.message(
    'Yeni Şifre',
    name: 'txtLblNewPassword',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblChangedPassword => Intl.message(
    'Şifreniz başarıyla kaydedildi',
    name: 'txtLblChangedPassword',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblLogOut=> Intl.message(
    'Çıkış Yap',
    name: 'txtLblLogOut',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblSupport=> Intl.message(
    'Destek',
    name: 'txtLblSupport',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblSettings=> Intl.message(
    'Ayarlar',
    name: 'txtLblSettings',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthJan=> Intl.message(
    'Ocak',
    name: 'txtLblMonthJan',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthFab=> Intl.message(
    'Şubat',
    name: 'txtLblMonthFab',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthMarch=> Intl.message(
    'Mart',
    name: 'txtLblMonthMarch',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthApr=> Intl.message(
    'Nisan',
    name: 'txtLblMonthApr',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthMay=> Intl.message(
    'Mayıs',
    name: 'txtLblMonthMay',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthJune=> Intl.message(
    'Haziran',
    name: 'txtLblMonthJune',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthJuly=> Intl.message(
    'Temmuz',
    name: 'txtLblMonthJuly',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthAugust=> Intl.message(
    'Ağustos',
    name: 'txtLblMonthAugust',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthSept=> Intl.message(
    'Eylül',
    name: 'txtLblMonthSept',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthOct=> Intl.message(
    'Ekim',
    name: 'txtLblMonthOct',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthNov=> Intl.message(
    'Kasım',
    name: 'txtLblMonthNov',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblMonthDecember=> Intl.message(
    'Aralık',
    name: 'txtLblMonthDecember',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNoWaitingProduct=> Intl.message(
    'Henüz bekleyen ürününüz bulunmamaktadır.',
    name: 'txtLblNoWaitingProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNoManufacturingProduct=> Intl.message(
    'Henüz üretimde olan ürününüz bulunmamaktadır.',
    name: 'txtLblNoManufacturingProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNoReadyProduct=> Intl.message(
    'Henüz teslime hazır ürününüz bulunmamaktadır.',
    name: 'txtLblNoReadyProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblOrderProductCode=> Intl.message(
    'Ürün Kodu',
    name: 'txtLblOrderProductCode',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblOrderProductCount=> Intl.message(
    'Paketteki Ürün Sayısı',
    name: 'txtLblOrderProductCount',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblOrderProductType=> Intl.message(
    'Tipi',
    name: 'txtLblOrderProductType',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblOrderProductWeight=> Intl.message(
    'Ağırlığı',
    name: 'txtLblOrderProductWeight',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblOrderProductPrice=> Intl.message(
    'Fiyatı',
    name: 'txtLblOrderProductPrice',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblNoSelectedPhoto=> Intl.message(
    'Henüz fotoğraf seçilmedi',
    name: 'txtLblNoSelectedPhoto',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblWizard1=> Intl.message(
    'Modelini tasarla',
    name: 'txtLblWizard1',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblWizard1_1=> Intl.message(
    'Üretime odaklan',
    name: 'txtLblWizard1_1',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblWizard2=> Intl.message(
    'Ürün fotoğrafları ekle',
    name: 'txtLblWizard2',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblWizard2_2=> Intl.message(
    'Dijital kataloğunu oluştur',
    name: 'txtLblWizard2_2',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblWizard3=> Intl.message(
    'Şimdi üye ol',
    name: 'txtLblWizard3',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblWizard3_3=> Intl.message(
    'Kolay ve etkili satışlar yapın',
    name: 'txtLblWizard3_3',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblDontHaveAccount=> Intl.message(
    'HENÜZ HESABINIZ YOK MU?',
    name: 'txtLblDontHaveAccount',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblAlbums=> Intl.message(
    'Albümler',
    name: 'txtLblAlbums',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblAllAlbums=> Intl.message(
    'Tüm Fotoğraflar',
    name: 'txtLblAllAlbums',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblSettingDesc => Intl.message(
    'Bu menüden bildirim ayarlarınızı değiştirebilirsiniz.',
    name: 'txtLblSettingDesc',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblTerms => Intl.message(
    'Bir tarafta GBJ Kuyumculuk ve Danışmanlık Ltd. Şti. (bundan sonra şirket olarak anılacaktır.) Diğer tarafta, akıllı telefon ana yazılımları olan, gerek ANDROID işletim sistemi tabanlı sistem veya iOS tabanlı işletim sistemi olsun iş bu yazılımı indiren ve bu sözleşme gereği bilgileri doğrulanan tüm kişiler kullanıcı olacaktır. (Bundan sonra kullanıcı olarak anılacaklardır).',
    name: 'txtLblTerms',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblTerms1 => Intl.message(
    'İş bu kullanım sözleşmesi ile amaçlanan, Türkiye sınırları içerisinde hangi coğrafi bölgede olursa olsun, kuyumculuk sektöründe üretim yapan, endüstriyel tasarım, marka sahibi, patent sahibi veya doğrudan üretici olan kimselerin kendi yaptıkları ürünleri katalog haline getirebilecekleri, görseller yükleyebilecekleri ve her yerde doğrudan ulaşım ile fiyat bilgisi, malzeme özellikler, ürünün gramajı gibi hususları da ekleyebilecekleri bu nispette kendilerine özel olarak hesap bilgileri ve sair daha bir çok bilgiyi de ekleyebilecekleri bir elektronik platformdur.\n\nİş bu yazılım, GBJ Kuyumculuk ve Danışmanlık Ltd. Şti. tarafından üretilmiş olup, kaynak kod, lisans ve her tür fikri ve sınai hakları şirkete aittir. Bu yazılım, ticari bir amaç gütmemekle birlikte, bu yazılımın kullanılması sonradan ayrıca ücretlendirmeyi gerektirebilir. Bu sözleşmenin yanı sıra ek kullanıcı sözleşmeleri ile sözleşme hüküm ve koşulları açısından şirket değişiklik yapma hakkını saklı tutar. Kullanıcı bu durumu açık iradesi ile kabul ettiğini beyan ve taahhüt eder.\n\nİş bu sözleşme ile iOS 11.0 ve üzeri ile ANDROID 5.1 ve üzeri sürümleri tarafından kullanılabilecektir. Diğer sürümler için kullanım söz konusu olmayacaktır. Şirket gerektiğinde, iOS ve ANDROID işletim sistemlerine ait sürümlere uygunluk açısından düzenleme getirebilecektir. Aşağıda belirtilen haklar saklıdır.',
    name: 'txtLblTerms1',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblTerms2 => Intl.message(
    '1-Kullanıcı kendisinin üretmiş olduğu veya pazarladığı ürünlere ilişkin olarak, üretmiş olduğu ürünlerin kendi ürünleri olduğunu, başka markalar veya ürünler ile endüstriyel tasarımlar ile iltibas halinde olmayacağını açıkça kabul eder. Bu kapsamda 6769 sayılı sınai mülkiyet kanunu çerçevesinde kullanıcılar tarafından üretilen veya arz edilen ürünlerin, Ticaret alanında cins, çeşit, vasıf, kalite, miktar, amaç, değer, coğrafi kaynak belirten veya malların üretildiği, hizmetlerin sunulduğu zamanı gösteren veya malların ya da hizmetlerin diğer özelliklerini belirten işaret veya adlandırmaları münhasıran ya da esas unsur olarak içeren işaretler.  Aynı veya aynı türdeki mal veya hizmetlerle ilgili olarak tescil edilmiş ya da daha önceki tarihte tescil başvurusu yapılmış marka ile aynı veya ayırt edilemeyecek kadar benzer işaretler. Ticaret alanında herkes tarafından kullanılan veya belirli bir meslek, sanat veya ticaret grubuna mensup olanları ayırt etmeye yarayan işaret veya adlandırmaları münhasıran ya da esas unsur olarak içeren işaretler.  Malın doğası gereği ortaya çıkan şeklini ya da başka bir özelliğini veya teknik bir sonucu elde etmek için zorunlu olan veya mala asli değerini veren şeklî ya da başka bir özelliğini münhasıran içeren işaretler. Mal veya hizmetin niteliği, kalitesi veya coğrafi kaynağı gibi konularda halkı yanıltacak işaretler, şeklinde olmadıkları var sayılır. Buna ilişkin olarak, kullanıcıya açılacak her tür davadan şirket sorumlu olmayıp, doğrudan kullanıcı sorumludur.\n\n2-Benzer şekilde 6769 sayılı Sınai Mülkiyet kanunu çerçevesinde, kullanıcı, Marka tescilinden doğan haklar münhasıran marka sahibine aittir. Marka sahibinin, izinsiz olarak yapılması hâlinde, aşağıda belirtilen fiillerin önlenmesini talep etme hakkı vardır. Tescilli marka ile aynı olan herhangi bir işaretin, tescil kapsamına giren mal veya hizmetlerde kullanılması.  Tescilli marka ile aynı veya benzer olan ve tescilli markanın kapsadığı mal veya hizmetlerle aynı veya benzer mal veya hizmetleri kapsayan ve bu nedenle halk tarafından tescilli marka ile ilişkilendirilme ihtimali de dâhil karıştırılma ihtimali bulunan herhangi bir işaretin kullanılması.Aynı, benzer veya farklı mal veya hizmetlerde olmasına bakılmaksızın, tescilli marka ile aynı veya benzer olan ve Türkiye\’de ulaştığı tanınmışlık düzeyi nedeniyle markanın itibarından haksız bir yarar elde edecek veya itibarına zarar verecek veya ayırt edici karakterini zedeleyecek nitelikteki herhangi bir işaretin haklı bir sebep olmaksızın kullanılmasına engel olma ve iş bu kanun çerçevesindeki diğer hükümler ile uluslararası anlaşmalar çerçevesinde TRİPS, PARİS sözleşmesi gibi uluslararası sözleşmelere itibar etmek ile mükelleftir.\n\n3-İş bu uygulama ile kullanıcı, yüklemiş olduğu veya yükleyeceği tüm görsellerin telif haklarının da kendisine ait olduğunu, üçüncü kişiler ile paylaşmayacağını, paylaşması halinde yasal sorumluluğun kendisine ait olduğunu, benzer şekilde, ürünün özellik, fiyat, gramaj, kalite gibi hususları konusunda basiretli bir tacir gibi davranacağını, bu anlamda yapmış olduğu veya yapacağı yanlış bilgi veya bildirimler nedeniyle doğmuş ve doğacak tüm zararlara kendisinin katlanacağını peşinen kabul eder. Şirket bu durumda sorumluluk kabul etmeyeceği gibi, uygulamayı kullanan kullanıcı yanında da yer almayacaktır. Yanlış bilgilendirmeden kaynaklı tüm sorumluluk kullanıcıya aittir.\n\n4-Yayımlanan bu sürüm dahil, diğer sürümler açısından uygulanmanın kullanılabilirliğinin sağlanması söz konusu olacaktır. Ancak yapılacak olan güncellemeler sadece  Şirket, istediği takdirde yazılımı kapatma hakkına sahiptir. Kullanıcı bu durumu kabul ve taahhüt eder. Burada yer alan gerek işletim sistemine uyumluluk gerekse verimlilik açısından şirket gerekli önlemleri alacaktır. Yazılımsal hatalar sebebiyle şirket sorumlu tutulamaz. Şirket bu iş ve işlemlerin yapılması esnasında ticari bir amaç gütmemektedir. Ancak yapılacak olan her revize çalışması veya yazılımın güncellenmesi halinde kullanıcı iş bu uygulamanın ve buna bağlı olan yazılıma ilişkin olarak hüküm ve koşulları okumak, irdelemek ve kabul etmek ile mükelleftir. İş bu programın kullanıcılar tarafından kötü amaçlı olarak kullanılması halinde şirketin kullanıcıya rücu hakkı saklıdır. Yazılımın telif hakkı şirkete ait olup, gerek kullanıcılar gerek üçüncü kişiler tarafından şirketin onayı olmadan kullanılamaz, kopyalanamaz, üzerinde değişiklik yapamaz. Bu durumun tespiti halinde şirket kullanıcıya başvurabilir, doğmuş ve doğacak zararlarının tazminini talep edebilir.\n\nGerek kimlik bilgilerinin alınması, bu sözleşmeye halel getirmeyeceği gibi, aynı zamanda gerek ulusal ve uluslararası fikri sınai mülkiyet haklarının korunması, gerekse kullanıcı üçüncü kişilerin haklarına veya yükümlülüklerine zarar verilmemesi amacıyla toplanır. Doğrudan veya dolaylı zararların oluşması halinde, diğer maddelerde yer alan hakların korunması açısından, yayımcının sorumluluğu da göz önüne alınarak bilgilerin alınması, tasnif edilmesi, şifrelenmesi, saklanması amaçlanmaktadır.  \n\n5-İş bu kullanıcı sözleşmesinin uygulanmasında, sözleşme hükümlerinin hüküm doğurabilmesi için, işletim sistemleri tarafından, kullanıcılara sağlanan kimlik doğrulama sistemleri kullanılır. Bu kapsamda, kullanıcının kullanmış olduğu telefon, tablet, bilgisayar ve her tür veri işleyici ve işletim sistemlerine onay veren sistemler ile yapılan onay geçerli onay olarak kabul edilecek olup 5070 sayılı elektronik imzaya ilişkin hükümler saklıdır. Islak imza olmaksızın kurulan bu iki taraflı sözleşmede, hüküm ve koşullara ilişkin verilmiş olan onay geçerli bir irade beyanı olarak sayılır. Aksinin ispatı kullanıcıya aittir.\n\n6-Şirket ilgili uygulamanın daha iyi geliştirilmesi veya 3. kişiler açısından kullanılabilir hale gelmesi için ek yazılımlar yapabilir. Bu yapılan yeni yazılımlarda şirketin fazlaya ilişkin hakları saklı olup, verilen hizmete yönelik olarak yeni yazılım açısından ücret talep edebilir. Kullanıcı bu hususu kabul ve taahhüt eder.',
    name: 'txtLblTerms2',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblTerms3 => Intl.message(
    '7-İş bu uygulamada, çalışılan kitle itibariyle ve iş bu kullanım sözleşmesi gereği, kişisel verilerin korunması, kullanıcıların vermiş olduğu bilgilerin kanunun öngördüğü ölçüde saklanması ve muhafazasının sağlanması gerekli görüldüğü hallerde veya kullanıcının talimatı ile bu bilgilerin silinmesi söz konusu olacaktır. Burada amaç, kişisel verilerin işlenmesinde başta özel hayatın gizliliği olmak üzere kişilerin temel hak ve özgürlüklerini korumak ve kişisel verileri işleyen gerçek ve tüzel kişilerin yükümlülüklerini düzenleyip korumaktır. \n\n8-Uygulamanın kullanılmasında, kullanıcılar tarafından verilecek olan, kişisel bilgiler dahil olmak üzere, iş amacına uygun olarak yüklenecek bilgiler, fotoğraflar ve her tür görseller ile ürünlere ilişkin statik bilgiler veri işleyicisi tarafından muhafaza edilmek zorundadır. Burada, Kişisel verilerin tamamen veya kısmen otomatik olan ya da herhangi bir veri kayıt sisteminin parçası olmak kaydıyla otomatik olmayan yollarla elde edilmesi, kaydedilmesi, depolanması, muhafaza edilmesi, değiştirilmesi, yeniden düzenlenmesi, açıklanması, aktarılması, devralınması, elde edilebilir hâle getirilmesi, sınıflandırılması ya da kullanılmasının engellenmesi gibi veriler üzerinde gerçekleştirilen her türlü işlemin gerçekleştirilmesi amaçlanır. \nKişisel bilgilerin kapsamının genişletilmesi halinde, bu bilgilerin kişisel verileri ayrıştırıcı nitelikte olduğu bu kapsamda, yasada öngörülen haller dışında üçüncü kişiler ile bu bilgilerin esas itibariyle paylaşılmayacağı esastır.\n\n9-İş bu veriler veri işleyicisi tarafından gerek sınai mülkiyet mevzuatı çerçevesinde gerekse Borçlar Kanunu ve sair mevzuat hükümleri çerçevesinde 5 yıl süreyle muhafaza edilir. Buna ilişkin ayrı bir yönetmeliğin çıkması veya yasa düzenlemesinin oluşması halinde bu sürelere uyulmayacak bu durum kullanıcıya derhal bildirilecektir. Bu kapsamda diğer haklar açısından 4. Madde düzenlemesinde yer alan haklar saklıdır.\n\n10- Mevzuat hükümleri gereğince yazılım ortamı kullanılarak verilecek olan hizmetlere ilişkin verilerin depolanması ve işlenmesi gerekmektedir. Bu kapsamda doğrudan açıkça onay verilmesi aranmaz Bu kapsamda\;\n\na\) Kanunlarda açıkça öngörülmesi.\n\nb\) Fiili imkânsızlık nedeniyle rızasını açıklayamayacak durumda bulunan veya rızasına hukuki geçerlilik tanınmayan kişinin kendisinin ya da bir başkasının hayatı veya beden bütünlüğünün korunması için zorunlu olması.\n\nc\) Bir sözleşmenin kurulması veya ifasıyla doğrudan doğruya ilgili olması kaydıyla, sözleşmenin taraflarına ait kişisel verilerin işlenmesinin gerekli olması.\n\nç\) Veri sorumlusunun hukuki yükümlülüğünü yerine getirebilmesi için zorunlu olması.\n\nd\) İlgili kişinin kendisi tarafından alenileştirilmiş olması.\n\ne\) Bir hakkın tesisi, kullanılması veya korunması için veri işlemenin zorunlu olması.\n\nf\) İlgili kişinin temel hak ve özgürlüklerine zarar vermemek kaydıyla, veri sorumlusunun meşru menfaatleri için veri işlenmesinin zorunlu olması gerektiği açıktır.\n\n•    Kişisel verilerin korunması için açıkça onay verilmesi ve kullanıcının düzeltme talebi:\n\nKullanıcının doğrudan talebi doğrultusunda aşağıda yer alan hükümler açıkça uygulanacaktır.\n\n-Kullanıcı, kişisel verilerin düzeltilmesi, kategorize edilmesi, işlenmesi, buna ilişkin veri tabanı oluşturulması, verilerin saklanması ve muhafazası, işin tamamlanması halinde verilerin silinmesi hususlarında açıkça onay vermiştir.\n\n-Kullanıcı vermiş olduğu kişisel verilerin düzeltilmesini isteme, bunlara ilişkin ver işleme sürecinde gerekli iş ve işlemleri yapılmasına izin vererek, bunlara ilişkin işlemlerin yapılmasını talep edebilir.\n\n-Kullanıcı kendi kişisel bilgilerinin doğruluğunu taahhüt ederek, bu bilgilerin (kimlik bilgileri dahil) işlenmesini açıkça kabul ve taahhüt eder.\n\n-Parmak izi ve yüz tanıma sisteminin kullanılması halinde, kullanılacak veri şirket tarafından depolanmayacaktır. Bu özelliklerin kullanılması işletim sistemi ve kullanılacak olan cihazın özelliklerine bağlı olarak değişkenlik gösterecektir. Bu anlamda şirketin sorumlu olmadığını, kullanıcı kabul ve taahhüt eder.\n\n-Jewelry Box uygulaması kapsamında, kullanıcılar tarafından girilecek olan ve kendi müşterilerine ait olan verilerin (adres, telefon, elektronik posta varsa kimlik numarası bilgileri) bunlar hakkında veri tabanı oluşturulmayacaktır. İstatistiki olarak veri tabanı oluşturulması halinde bu bilgiler anonimleştirilecek ve üçüncü kişiler ile paylaşılmayacaktır. Bu hususa kullanıcı açıkça onay verir, kabul eder.\n\n11-Kişisel verilerin kullanılması açısında, hüküm ve koşulların onaylanması halinde kişisel verilerin kullanılması açısından açıkça irade beyanı ile onay verildiği kabul edilir. Bu halde, kullanıcıya zarar vermemek koşulu ile şirket, kişisel verilere ilişkin tutmuş olduğu istatistikleri üçüncü kişiler ile paylaşabilir, buna ilişkin istatistik oluşturabilir, kullanıcı bu hususu açıkça kabul ve taahhüt eder. Siber güvenlik gereği, paylaşılmaya müsait olan istatistiki veriler anonimleştirilerek paylaşılır. Aksinin ispatı kullanıcıya aittir.\n\n12-KVKK çerçevesinde Kişisel veriler, kanunda yer alan 5 inci maddenin ikinci fıkrası ile 6 ncı maddenin üçüncü fıkrasında belirtilen şartlardan birinin varlığı ve kişisel verinin aktarılacağı yabancı ülkede; Yeterli korumanın bulunması, Yeterli korumanın bulunmaması durumunda Türkiye\'deki ve ilgili yabancı ülkedeki veri sorumlularının yeterli bir korumayı yazılı olarak taahhüt etmeleri ve Kurulun izninin bulunması, kaydıyla ilgili kişinin açık rızası aranmaksızın yurt dışına aktarılabilir. Bu durum, Türkiye\'nin taraf olduğu uluslararası sözleşmeleri, Kişisel veri talep eden ülke ile Türkiye arasında veri aktarımına ilişkin karşılıklılık durumunu, Her somut kişisel veri aktarımına ilişkin olarak, kişisel verinin niteliği ile işlenme amaç ve süresini, kapsamak zorundadır. Kullanıcı bu hususları kabul ve taahhüt eder.\n\n13-Şirket, kişisel veriler ile tüm bunlara bağlı yan unsurları işlenmesini sağlamak, saklanması için veri tabanı oluşturmak ve gerekli şifrelemeleri yaparak, gerektiği takdirde yedeklerini alarak ve bunlar için ayrı şifreleme yöntemleri kullanmak suretiyle tüm güvenlik önlemelerini almak zorundadır. Bilgi edinme kanunu çerçevesinde bu verilerin saklanmasına yönelik kullanıcının bilgi edinme hakkı saklıdır. Kamu kurumları ve devlet organları nezdinde işlenmiş olan ve işlenecek olan kişisel verilere ilişkin olarak kullanıcının rızası olmaksızın bilgi verilmesi mümkündür.\n\n14-Bilgilerin güncellenmesi açısından, yapılan tüm değişikliklere ilişkin olarak kullanıcı tüm bilgiler için doğru bilgi vermek ile mükelleftir. Yanlış yapılan bildirimler neticesinde şirketin bir sorumluluğu olmayıp buna ilişkin olarak yanlış bilgi verme neticesinde oluşacak olan her türlü olumsuz durum ile yasal durumlar karşısında şirket verileri esas alınır. Kullanıcı hatası sebebiyle oluşacak ihtilaflar veya iltibaslar neticesinde şirketin kullanıcıya rücu etme hakkı saklı olup, kullanıcı şirketi gayri kabili rücu ibra eder.\n\n15-Kişisel verilerin işlenme sürecinde işin niteliği gereği, veri tabanı oluşturmak için kullanılacaktır. Aynı zamanda bu bililerin toplanması TTK gereğince şeffaflık ilkesi gereği haksız rekabetin engellenmesi ve serbest piyasa koşulları göz önünde tutularak istatistiki bilgiler ve veriler oluşturmakta kullanılacaktır. Ticari bir amaç söz konusu olmadığı gibi, haksız kullanım veya kullandırma neticesinde doğmuş ve doğacak olan zarar ve ziyan şirkete aittir. Ancak burada değişen hayat koşulları teknolojik yenilikler ve buna bağlı olan yasal düzenlemeler ön planda tutulacak olup, olası bir sorun halinde uzlaşma prosedürünün işletilmesi öncelikle yazılı olarak şirkete başvuru yapılması, hatanın veya iltibasın yazılı yoldan düzeltilmesi istenilmesi esastır.\n\n\• Kişisel verilerin kullanıcı talebi ile silinmesi:\n\n-Kullanıcı tarafından girilen her türlü kişisel veriye yönelik olarak, şirket bu verilerin anonimleştirilerek saklanacağını ilgili yönetmelikler neticesinde kabul eder.\n-Kullanıcı bildirmiş olduğu her tür verinin silinmesine yönelik olarak açıkça yazılı talepte bulunmak zorundadır. Bulunan yazılı talep neticesinde gerekli araştırma yapılarak verilerin silindiği kullanıcıya sms yolu ile bildirilir. Bildirilen SMS neticesinde kendisine gönderilen şifrenin şirkete bildirilmesi gerekmektedir. Silinen verilerin kullanılması daha sonraki aşamada mümkün olmaz. Kullanıcı bu hususu anladığını açıkça onay verdiğini ve yasal yükümlülükler gereğince istemi halinde işlemin gerçekleştirileceğini bildiğini kabul ve taahhüt eder.',
    name: 'txtLblTerms3',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblTerms4 => Intl.message(
    '16-Yukarıda III. Maddenin 6. Bendinde yer alan hüküme dayanarak, burada belirtilen yazılım neticesinde, bununla birlikte kullanılmak üzere şirket tarafından Jewelry Box uygulaması geliştirilmiştir. İş bu yazılım, diğer yazılım ile birlikte entegre olarak çalışmakla birlikte, kullanıcıların iş ağlarını genişletmek, elektronik katalog yaratmak, ürün, fiyat bilgisi girmek ve bunları gerek sms gerekse sair iletişim şekilleri ile birlikte son tüketiciye pazarlamasını kolaylaştırmayı amaçlamaktadır.\n\n17-Bu uygulamanın kullanımı Atölye uygulamasının yüklenmesine ve burada yer alan sözleşmenin kabul edilerek, kullanıcı adı ve şifre oluşturulmasına bağlıdır. Aksi halde uygulama çalışmaz. Burada yer alan tüm kullanım koşulları ve haklar doğrudan iş bu uygulamayı da kapsar ve açıkça onay verilmesine bağlı olarak kullanılabilir. Bu uygulamanın kullanımında uygulamaya onay vermeleri halinde, cep telefonun özellikleri ve arayüz olan yazılım yeterlilikilerinin sağlanması halinde, parmak izi veya yüz tanıma sistemi ile uygulamaya ilk girişten sonra giriş yapılması mümkündür. Burada doğrudan işletim sistemine bağlı arayüzdeki yazılım özellikleri ve şifreleme yöntemleri kullanılacağından, şirketin parmak izi ve yüz tanıma sistemine bağlı verilere ulaşma imkanı söz konusu değildir. Bu kapsamda KVKK gereğince ayrıca bir onay alınmasına gerek olmaksızın verilerin şirket nezdinde saklanmayacağını şirket kabul ve taahhüt eder. Bu kapsam uygulama neticesinde iş bu kişisel verilerinin çalındığını düşünen kullanıcı veya kullandırdığı üçüncü kişi nezdinde şirketin hiç bir sorumluluğu yoktur. Kullanıcı bu anlamda şirketi gayri kabili rücu ibra eder. 18- Uygulamada, müşteriler elektronik katalog oluştururken, sergileyecekleri her türlü ürünlere ilişkin, üst limitlere uymak kaydı ile özelliklerini belirtebilir, gramaj, taş özellikleri ve cinsi, kullanılan madenin cinsi ve fiyatlandırma açısından üst veya alt limit kullanabilirler. Burada aynı zamanda çalışmakta oldukları müşterilerine ilişkin bilgilerini kaydedebilir geniş anlamda elektronik posta adresleri, iş yeri adreslerinin ve sair bilgilerin kaydı mümkündür. Aynı zamanda müşterilere ilişkin notların alınması da söz konusudur. Kaydedilen bilgilere yönelik olarak elektronik ortamda PDF formatında ürüne ilişkin girileri yazılı olarak geçebilir, benzer şekilde telefon rehberlerinde kayıtlı olan kişilerin bilgilerini iş bu uygulamaya entegre edebilirler.\n\n18-Uygulamada, müşteriler elektronik katalog oluştururken, sergileyecekleri her türlü ürünlere ilişkin, üst limitlere uymak kaydı ile özelliklerini belirtebilir, gramaj, taş özellikleri ve cinsi, kullanılan madenin cinsi ve fiyatlandırma açısından üst veya alt limit kullanabilirler. Burada aynı zamanda çalışmakta oldukları müşterilerine ilişkin bilgilerini kaydedebilir geniş anlamda elektronik posta adresleri, iş yeri adreslerinin ve sair bilgilerin kaydı mümkündür. Aynı zamanda müşterilere ilişkin notların alınması da söz konusudur. Kaydedilen bilgilere yönelik olarak elektronik ortamda PDF formatında ürüne ilişkin girileri yazılı olarak geçebilir, benzer şekilde telefon rehberlerinde kayıtlı olan kişilerin bilgilerini iş bu uygulamaya entegre edebilirler.\n\nKullanıcının müşterilerine dair kaydedilen bilgilerine yönelik olarak KVKK gereği muvafakatname alma görevi kullanıcıya aittir. Burada yer alan müşteri bilgileri kullanıcının hesabında tutulacak olup, şirket bünyesinde kayıt altına alınmayacaktır. Burada kayıt altında tutulacak olan hususlar Atölye uygulaması benzer olacak şekilde sadece ürünlerin özellikleri ve fiyatlandırılmasına yöneliktir.\n\n19-İş bu uygulama, taraflara internet üzerinden ödeme sistemleri sunmaz, ticari bir aracılık görevi görmez. Bu kapsamda bu uygulama üzerinden elektronik ödeme kabulu veya kullanıcıların müşterilerine yönelik doğrudan bir hizmet sunulmamakla birlikte, müşteri ve kullanıcı arasında çıkacak olan her türlü ihtilafta şirket taraf olarak sayılamaz, kendisine dava ikame edilemez. Buna yönelik olarak doğmuş ve doğacak zararalara ilişkin olarak, şirketin yasal yollara başvurma hakkı saklıdır.\n\n20-İş bu sözleşmenin 18.madde atfıyla benzer şekilde kullanıcılar uygulama ile kayıt altına aldıkları müşterilerine yönelik olarak birden fazla seçme yaparak ürün resmi ve özelliklerini gönderebilir. Burada yer alan özellikleri şirket tamamen ücretsiz olarak kullanıcılara sunar. Yazılımın geliştirilmesi sonucunda daha sonraki aşamalarda şirketin uygulamanın bazı özelliklerine ilişkin açık onay alma kaydı ile ücretlendirme yapma hakkı saklıdır.\n\n21-iş bu sözleşme ve uygulamalar bir bütün olarak yer alır. Dolayısıyla sözleşmeye ilişkin hükümler, her iki uygulamayı da kapsamaktadır. Taraflar iş bu sözleşmenin hükümlerini ve bağlayıcının farkında olarak ve açık rızaları ile iş bu sözleşmeyi onaylamışlardır.\n\n',
    name: 'txtLblTerms4',
    args: [],
    locale: locale.toString(),
  );

  String get txtLblTerms5 => Intl.message(
    '22-Kullanıcı sözleşmesi elektronik ortamda hazırlanmış olup, onay verilmesi halinde geçerli olacaktır. Aksi halde iş bu yazılımın kullanılması mümkün değildir. Bu onayın verilmesi ile kullanıcının tüm sözleşmeyi okuduğu, anladığı ve onay verdiği kabul edilir. Bu kapsamda bu sözleşmenin kabulü ile yazılım için gerekli olan diğer programlara ve cihaz donanımına ulaşmaya açık rıza ile onay verilmiş sayılır.\n\n23-Burada bahsi geçen yasal mevzuatların yanı sıra olası çıkacak bir uyuşmazlıkla ilgili olarak şirkete yazılı olarak ister işletim sistemi kanalı ile veya kullanılacak uygulama ile geri dönüş yapılması veya elektronik posta ile bilgilendirme yapılması hususunu kullanıcı açıkça kabul eder. Burada yapılan yazışmalar doğrudan kesin delil olarak sayılır. Şirket olası bir olumsuzluk veya iltibas halinde en geç 3 gün içerisinde yazılı dönüş yapacak 15 gün içerisinde yapılmış bir hata söz konusu ise bu hatanın düzeltilmesini sağlayacaktır. Hatanın şirketin kendisinden kaynaklanmadığı hallerde ise yazılı olarak bilgi verilecektir.\n\n24-Hukukun üstünlüğü ilkesi gereği, burada yer alan hükümlerin yanı sıra sair mevzuat hükümleri uygulanacaktır. Değişen yasa hükümleri gereğince bir maddenin geçersiz hale gelmesi halinde bile bu sözleşmenin tüm maddeleri hükümsüz sayılmaz. Geriye kalan maddeler uygulamaya devam eder.\n\n25-Uzlaşma veya anlaşma sağlanamaması halinde, İstanbul Çağlayan mahkemeleri ve icra daireleri yetkili olup, taraflar elektronik ortamda tanzim edilen iş bu yetki sözleşmesini kabul ve taahhüt ederler.',
    name: 'txtLblTerms5',
    args: [],
    locale: locale.toString(),
  );


  //Switch Texts

  String get txtSwitchOrderNotf => Intl.message(
    'Ürün Şipariş Bildirimi',
    name: 'txtSwitchOrderNotf',
    args: [],
    locale: locale.toString(),
  );

  String get txtSwitchOrderNotfDesc => Intl.message(
    'Bu alan yeni siparişiniz olduğunu size bildirir. Eğer bu alanı kapatırsanız sipariş takibiniz zorlaşabilir.',
    name: 'txtSwitchOrderNotfDesc',
    args: [],
    locale: locale.toString(),
  );

  String get txtSwitchProductAddNotf => Intl.message(
    'Ürün Eklenme Bildirimi',
    name: 'txtSwitchProductAddNotf',
    args: [],
    locale: locale.toString(),
  );

  String get txtSwitchProductAddNotfDesc => Intl.message(
    'Bu alan eklediğiniz ürünlerin, listenize yüklenme işleminin tamamlandığını size bildirir.',
    name: 'txtSwitchProductAddNotfDesc',
    args: [],
    locale: locale.toString(),
  );

  String get txtSwitchProductLikeNotf => Intl.message(
    'Ürün Beğeni Bildirimi',
    name: 'txtSwitchProductLikeNotf',
    args: [],
    locale: locale.toString(),
  );

  String get txtSwitchProductLikeNotfDesc => Intl.message(
    'Bu alan müşterilerin herhangi bir ürününüzü beğendiğini size bildirir. Bu alanı kapatmanız ürünlerinizin beğeni takibini yapmanızı zorlaştırabilir.',
    name: 'txtSwitchProductLikeNotfDesc',
    args: [],
    locale: locale.toString(),
  );

  String get txtSwitchInfoNotf => Intl.message(
    'Bilgilendirme Bildirimi',
    name: 'txtSwitchInfoNotf',
    args: [],
    locale: locale.toString(),
  );

  String get txtSwitchInfoNotfDesc => Intl.message(
    'Bu alan herhangi bir konuda bilgilendirme için gönderilen bildirimlerin size iletilmesini sağlar. Bu alanı kapatmanız birçok bilgilendirmeden uzak kalmanıza neden olabilir.',
    name: 'txtSwitchInfoNotfDesc',
    args: [],
    locale: locale.toString(),
  );


  //Showcase Texts

  String get txtShowcaseHamburgerMenu=> Intl.message(
    'Bu menüden özel isteklerini, tamir siparişlerini be bildirim ayarlarını yönetebilirsin.',
    name: 'txtShowcaseHamburgerMenu',
    args: [],
    locale: locale.toString(),
  );

  String get txtShowcaseNotifications=> Intl.message(
    'Senin tüm bildirim ayarların burada. İlgilenmeniz gereken bazı sayfalara erişim sağlayabilirsiniz.',
    name: 'txtShowcaseNotifications',
    args: [],
    locale: locale.toString(),
  );

  String get txtShowcaseOrder=> Intl.message(
    'Bu menüden siparişlerinizin takibini ve yönetimini yapabilirsiniz.',
    name: 'txtShowcaseOrder',
    args: [],
    locale: locale.toString(),
  );

  String get txtShowcaseCollectionItem=> Intl.message(
    'Ürün eklemek için doğru ürün kategori listeni seç, ürününü gir ve detaylandır.',
    name: 'txtShowcaseCollectionItem',
    args: [],
    locale: locale.toString(),
  );

  String get txtShowcaseAddProduct=> Intl.message(
    'Bu ürün listene fotoğraf eklemek için buraya tıkla.',
    name: 'txtShowcaseAddProduct',
    args: [],
    locale: locale.toString(),
  );

  String get txtShowcaseOrderBy=> Intl.message(
    'Ürün eklenme tarihi, beğeni sayısı veya son düzenlenme tarihine göre ürünlerini sıralı görmek istediğinizde bu seçeneği kullanın.',
    name: 'txtShowcaseOrderBy',
    args: [],
    locale: locale.toString(),
  );

  String get txtShowcaseProductEdit=> Intl.message(
    'Bu liste içerisindeki ürünlerini uygun şekilde düzenle ve bu listeden silmek için bu seçeneği kullanın.',
    name: 'txtShowcaseProductEdit',
    args: [],
    locale: locale.toString(),
  );

  String get txtShowcaseProductNote=> Intl.message(
    'Sadece kendinizin görebildiği özel bir not yazın. Notlar ürünün malzemeleri, tedariği veya üretim ayrıntılarını içerebilir.',
    name: 'txtShowcaseProductNote',
    args: [],
    locale: locale.toString(),
  );

  String get txtShowcaseProductDetails=> Intl.message(
    'Bu ürün detay bölümü, müşterilerimiz fotoğrafı beğendikten sonra doldurulabilir. Ürün beğeni aldıktan sonra ayrıntıları eklemeniz için size bildirilecek.',
    name: 'txtShowcaseProductDetails',
    args: [],
    locale: locale.toString(),
  );



  //Error messages

  String get txtErMisCharacter => Intl.message(
        'Şifreniz en az 6 karakterden oluşmalıdır.',
        name: 'txtErMisCharacter',
        args: [],
        locale: locale.toString(),
      );

  String get txtErSmsCodeTimeOut => Intl.message(
    'Doğrulama kodu gönderilemiyor. Lütfen daha sonra tekrar deneyin.',
    name: 'txtErSmsCodeTimeOut',
    args: [],
    locale: locale.toString(),
  );

  String get txtErInternetError => Intl.message(
    'Internet bağlantınız yok.',
    name: 'txtErInternetError',
    args: [],
    locale: locale.toString(),
  );

  String get txtErMinPackageProductCount => Intl.message(
    'Paketteki ürün sayısı en az iki adet olabilir.',
    name: 'txtErMinPackageProductCount',
    args: [],
    locale: locale.toString(),
  );

  String get txtErServerError => Intl.message(
    'Server Hatası.',
    name: 'txtErInternetError',
    args: [],
    locale: locale.toString(),
  );

  String get txtErLocalError => Intl.message(
    'Yerel veri hatası.',
    name: 'txtErInternetError',
    args: [],
    locale: locale.toString(),
  );

  String get txtErMisPhoneNumber => Intl.message(
        'Eksik veya yanlış telefon numarası girdiniz.',
        name: 'txtErMisPhoneNumber',
        args: [],
        locale: locale.toString(),
      );

  String get txtErMissCharacter => Intl.message(
        'En az 3 karakter girmelisiniz',
        name: 'txtErMissCharacter',
        args: [],
        locale: locale.toString(),
      );

  String get txtErEmptySubject => Intl.message(
    'Konu alanı boş geçilemez',
    name: 'txtErMissCharacter',
    args: [],
    locale: locale.toString(),
  );

  String get txtErEmptyFeedBack => Intl.message(
    'Açıklama alanı boş geçilemez',
    name: 'txtErMissCharacter',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode1 => Intl.message(
    'İşlem limitini aştınız.',
    name: 'txtErSmsCode1',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode2 => Intl.message(
    'Eksik bir değer mevcut, lütfen kontrol edip tekrar deneyin.',
    name: 'txtErSmsCode2',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode3 => Intl.message(
    'Geçersiz bir numara girdiniz, lütfen kontrol edip tekrar deneyin.',
    name: 'txtErSmsCode3',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode4 => Intl.message(
    'Bir hata oluştu. Lütfen daha sonra tekrar deneyin.',
    name: 'txtErSmsCode4',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode5 => Intl.message(
    'Bir hata oluştu. Lütfen daha sonra tekrar deneyin.',
    name: 'txtErSmsCode5',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode6 => Intl.message(
    'Bir hata oluştu: Lütfen daha sonra tekrar deneyin.',
    name: 'txtErSmsCode6',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode7 => Intl.message(
    'Doğrulamaya çalıştığınız numara kara listede.',
    name: 'txtErSmsCode7',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode9 => Intl.message(
    'Hesabınızın bu isteği işleme koymak için yeterli kredisi yok.',
    name: 'txtErSmsCode9',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode10 => Intl.message(
    'Aynı anda birden fazla doğrulama yapmaya çalışıyorsunuz. Lütfen bir süre bekleyin ve sonra tekrar deneyin.',
    name: 'txtErSmsCode10',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode15 => Intl.message(
    'Bir hata oluştu. Lütfen daha sonra tekrar deneyin.',
    name: 'txtErSmsCode15',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode16 => Intl.message(
    'Doğrulama kodu hatalı, lütfen kontrol edin.',
    name: 'txtErSmsCode16',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode17 => Intl.message(
    'Çok sayıda hatalı doğrulama kodu girildi. Hatalı kod girmeye devam ederseniz hesabınız bloke edilecek!',
    name: 'txtErSmsCode17',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode18 => Intl.message(
    'İsteğinize maksimum 10 numara ekleyebilirsiniz.',
    name: 'txtErSmsCode18',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCode101 => Intl.message(
    'Eşleşen doğrulama isteği yok.',
    name: 'txtErSmsCode101',
    args: [],
    locale: locale.toString(),
  );

  String get txtErSmsCodeGeneral => Intl.message(
    'Genel Hata',
    name: 'txtErSmsCodeGeneral',
    args: [],
    locale: locale.toString(),
  );


}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  Future<AppLocalizations> load(Locale locale) async{
    List preferredLanguages = ['tr'];
    Locale locale;
    if (preferredLanguages == null) locale = Locale("tr");
    String selectedLanguage = preferredLanguages[0];
    switch (selectedLanguage) {
      case "tr-TR":
        locale = Locale("tr");
        break;
      case "en-TR":
        locale = Locale("en");
        break;
      default:
        locale = Locale("tr");
        break;
    }
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  @override
  bool isSupported(Locale locale) => ['tr', 'en'].contains(locale.languageCode);
}


