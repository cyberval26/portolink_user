part of 'models.dart';


class Pending extends Equatable{
  final String pendingId;
  final String templateName;
  final String link;
  final String description;
  final String status;


  const Pending(
      this.pendingId,
      this.templateName,
      this.link,
      this.description,
      this.status,
      );

  @override
  // TODO: implement props
  List<Object> get props => [
    pendingId,
    templateName,
    link,
    description,
    status,
  ];
}