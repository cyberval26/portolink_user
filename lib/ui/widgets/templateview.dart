part of 'widgets.dart';


class TemplateView extends StatefulWidget {
  const TemplateView({Key key, this.template}) : super(key: key);
  static const String routeName = "/templateview";
  final Template template;
  @override
  _TemplateViewState createState() => _TemplateViewState();
}
class _TemplateViewState extends State<TemplateView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Template template = widget.template;
    return Container(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderTemplate(
                tid: template.tid,
                name: template.name,
                desc: template.desc,
                price: template.price,
                photo :template.photo,
              )
            )
          );
        },
        child: Stack(
          children: [
            Image.network(
              template.photo,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.black.withOpacity(0.7),
              child: Text(
                template.name,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w200
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}