enum DialogFilterType { ItemTypes, Collections }
enum DetailVisibleOptions {
  TotalCost,
  RetailPrice,
  Weight,
  ProductCode,
  ItemType,
  CollectionGroup,
  Gemstone,
  Bead
}
enum MessageDialogTypes { OK, CANCEL }

enum DialogType {
  RemoveProduct,
  ExitAccount,
  BackWidget,
  AddMoreProduct,
  UpdateApp,
  Permissions,
  DetailWaitLike
}

enum PageIntents {
  ToVerifyCodeFromForgetPassword,
  ToProductListCodeFromHome,
  ToPhotoPickerFromProductList,
  ToProductListCodeFromNotification,
  ToVerifyCodeFromRegister,
  ToSupplierPhoneFromForgetPassword,
  ToProductDetailFromProductList
}


enum OptionsDialogType {
  ProductSaleStatusChange,
  ProductSortBy,
  OrderProductStatusChange
}

enum OptionsDialogButton {
  Active,
  DeActive,
  Remove,
  OrderByAddedDate,
  OrderByLikeCount,
  OrderByEditStatus,
  OrderProductWaiting,
  OrderProductProduction,
  OrderProductReady,
  OrderProductNoProduction
}

enum popPage{
  DesignTypesPage,
  OptionPage,
  DetailPage

}

enum OtherOptionsType{
  otherOptions,
  availableOptions
}

enum SupportTipe{
  Support,PhotoSupport
}