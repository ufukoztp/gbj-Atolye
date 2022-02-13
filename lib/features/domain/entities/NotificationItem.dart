class NotificationItem {
  final body;
  final title;
  final route;
  final productId;
  final jewelryTypeId;
  final subtype;
  final image;
  final productListTitle;

  NotificationItem(
      {this.route,
      this.body,
      this.title,
      this.image,
      this.jewelryTypeId,
      this.productId,
      this.subtype,
      this.productListTitle});

  static NotificationItem notificationItemForMessage(
      Map<String, dynamic> message) {
    final dynamic data = message['data'] ?? message;
    return NotificationItem(
        title: data['title'],
        body: data['body'],
        route: data['route'],
        subtype: data['subtype'],
        image: data['image'],
        jewelryTypeId: data['jewelrytype_id'],
        productId: data['product_id'],
        productListTitle: data['productlisttitle']);
  }
}
