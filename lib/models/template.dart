part of 'models.dart';

class Template {
  final String templateId;
  final String templateName;
  final String description;
  final String price;
  final String photoFile;
  const Template(
    this.templateId,
    this.templateName,
    this.description,
    this.price,
    this.photoFile
  );
  List<Object> get props => [
    templateId,
    templateName,
    description,
    price,
    photoFile
  ];
}