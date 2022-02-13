class AppApi {

  // ignore: non_constant_identifier_names
  static final String HOSTNAME = "https://gbjatolye.azurewebsites.net";
  // ignore: non_constant_identifier_names
  static final String TOKEN_API = "/api/Account/Login";
  // ignore: non_constant_identifier_names
  static final String REGISTER_API = "/api/Account/Register";
  // ignore: non_constant_identifier_names
  static final String HOME_API = "/api/ProductOption/GetJewelryTypes";
  // ignore: non_constant_identifier_names
  static final String CURRENCYLIST_API = "/api/Supplier/GetPriceTypes";
  // ignore: non_constant_identifier_names
  static final String COLLECTIONLIST_API = "/api/CollectionGroup/List";
  // ignore: non_constant_identifier_names
  static final String JEWELERYTYPES_API = "/api/ProductOption/GetJewelryTypes";
  // ignore: non_constant_identifier_names
  static final String SUBJEWELERYTYPES_API = "/api/ProductOption/GetSubJewelryTypes";
  // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names
  static final String ACTIVEPRODUCTLIST_API = "/api/Product/SalesList";
  // ignore: non_constant_identifier_names
  static final String ADDPRODUCTS_API = "/api/Product/AddProduct";
  // ignore: non_constant_identifier_names
  static final String DEACTIVEPRODUCTLIST_API = "/api/Product/UnSalesList";
  // ignore: non_constant_identifier_names
  static final String HOMEPAGE_API = "/api/Account/Home";
  // ignore: non_constant_identifier_names
  static final String PRODUCTDETAIL_API = "/api/Product/Detail";
  // ignore: non_constant_identifier_names
  static final String DESIGNTYPES_API ="/api/ProductOption/GetDesignTypes";
  // ignore: non_constant_identifier_names
  static final String OPTIONS_API ="/api/ProductOption/GetPersonalizeOptions";
  // ignore: non_constant_identifier_names
  static final String OTHEROPTIONS_API ="/api/ProductOption/GetOtherOptionGroups";




  // ignore: non_constant_identifier_names
  static final String EXISTUSER_API = "/api/Account/CheckUser";
  // ignore: non_constant_identifier_names
  static final String REQUESTSMSCODE_API = "https://api.nexmo.com/verify/json";
  // ignore: non_constant_identifier_names
  static final String REQUESTIDSTATUS_API = "https://api.nexmo.com/verify/search/json";
  // ignore: non_constant_identifier_names
  static final String RESENDSMSCODE_API = "https://api.nexmo.com/verify/search/json";
  // ignore: non_constant_identifier_names
  static final String VERIFYSMSCODE_API = "https://api.nexmo.com/verify/check/json";
  // ignore: non_constant_identifier_names
  static final String UPDATEADRESS_API = "/api/Account/UpdateAddress";
  // ignore: non_constant_identifier_names
  static final String FORGOTPASSWORDVERIFY_API = "/api/Account/ForgotPasswordVerify";
  // ignore: non_constant_identifier_names
  static final String CHANGEPASSWORD_API = "/api/Account/ChangePassword";
  // ignore: non_constant_identifier_names
  static final String SETPRODUCTACTIVE_API = "/api/Product/SetStatus";
  // ignore: non_constant_identifier_names
  static final String SETPRODUCTDEACTIVE_API = "/api/Product/SetStatus";
  // ignore: non_constant_identifier_names
  static final String DELETEPRODUCT_API = "/api/Product/DeleteProduct";
  // ignore: non_constant_identifier_names
  static final String PRODUCTSENDAPPROVAL_API = "/api/Product/UpdateProduct";
  // ignore: non_constant_identifier_names
  static final String PRODUCTSENDAPPROVALAVAILABLE_API = "/api/ProductOption/AddAvailableOption";
  // ignore: non_constant_identifier_names
  static final String GETNOTIFICATIONLIST_API = "/api/Notification/GetNotificationList";





  static final String SETNOTIFICATION_API = "/api/Notification/SetNotificationRead";
  // ignore: non_constant_identifier_names
  static final String GETORDERLIST_API = "/api/SupplierOrderProduct/GetOrderList";

  static final String UNREGISTER_API = "/api/Notification/UnRegisterDevice";

  static final String REGISTERDEVICE_API = "/api/Notification/RegisterDevice";

  static final String SETORDERSTATUS_API = "/api/SupplierOrderProduct/SetStatus";

  static final String GETTICKETLIST_API = "/api/Ticket/GetTicketList";
  // ignore: non_constant_identifier_names
  static final String PRODUCTSETNOTE_API = "/api/Product/UpdateSupplierNote";
  // ignore: non_constant_identifier_names
  static final String UPDATESETTINGS_API = "/api/Product/ss";



  static String getRequestUrl(String pathname) {
    return HOSTNAME + pathname;
  }

}

class PrefKeys {

  // ignore: non_constant_identifier_names
  static final String TOKEN_KEYS = "Token";
  // ignore: non_constant_identifier_names
  static final String SMSREQUSETID_KEYS = "SmsRequestId";
  // ignore: non_constant_identifier_names
  static final String REMEMBERME_KEYS = "rememberMe";
  // ignore: non_constant_identifier_names
  static final String UPDATEDATE_KEYS = "updateDate";
  // ignore: non_constant_identifier_names
  static final String PRICETYPE_KEYS = "priceType";
  // ignore: non_constant_identifier_names
  static final String CUSTOMNOTIFICATION_KEYS = "customNotification";
  // ignore: non_constant_identifier_names
  static final String ALLNOTIFICATION_KEYS = "allNotification";
  // ignore: non_constant_identifier_names
  static final String ORDERNOTIFICATION_KEYS = "orderNotification";
  // ignore: non_constant_identifier_names
  static final String PRODUCTADDEDNOTIFICATION_KEYS = "productAddedNotification";
  // ignore: non_constant_identifier_names
  static final String PRODUCTLIKENOTIFICATION_KEYS = "productLikeNotification";
  // ignore: non_constant_identifier_names
  static final String HOMESHOWCASE_KEYS = "homeShowcase";
  // ignore: non_constant_identifier_names
  static final String PRODUCTLISTSHOWCASE_KEYS = "productListShowcase";
  // ignore: non_constant_identifier_names
  static final String PRODUCTDETAILSHOWCASE_KEYS = "productDetailShowcase";

}

class NotificationTypes{

  // ignore: non_constant_identifier_names
  static final String NOTFDEFAULT_TYPE = "notifications";

  // ignore: non_constant_identifier_names
  static final String NOTFORDER_TYPE = "orders";

  // ignore: non_constant_identifier_names
  static final String NOTFLIKE_TYPE = "like";

  // ignore: non_constant_identifier_names
  static final String NOTFLIKEDETAIL_TYPE = "likedetail";
  // ignore: non_constant_identifier_names
  static final String NOTFADDPRODUCT_TYPE = "addproduct";
}
