part of 'models.dart';

class Order {
  final String orderId;
  final String templateName;
  final String color;
  final String contact;
  final String requestDescription;
  final String photoReference;
  final String createdAt;
  const Order(
    this.orderId,
    this.templateName,
    this.color,
    this.contact,
    this.requestDescription,
    this.photoReference,
    this.createdAt
  );
  List<Object> get props => [
    orderId,
    templateName,
    color,
    contact,
    requestDescription,
    photoReference,
    createdAt
  ];
}