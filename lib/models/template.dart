part of 'models.dart';

class Template {
  final String tid;
  final String name;
  final String desc;
  final String price;
  final String photo;
  const Template(
    this.tid,
    this.name,
    this.desc,
    this.price,
    this.photo
  );
  List<Object> get props => [
    tid,
    name,
    desc,
    price,
    photo
  ];
}