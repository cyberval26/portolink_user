part of 'pages.dart';

class OrderTemplate extends StatefulWidget {
  static const String routeName = "/ordertemplate";
  final String templateId;
  final String templateName;
  final String description;
  final String price;
  final String photoFile;

  const OrderTemplate(
      {Key key,
        this.templateId,
        this.templateName,
        this.description,
        this.price,
        this.photoFile,
      })
      : super(key: key);
  @override
  _OrderTemplateState createState() => _OrderTemplateState();
}

class _OrderTemplateState extends State<OrderTemplate> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlColor = TextEditingController();
  final ctrlContact = TextEditingController();
  PickedFile imageFile;
  final ImagePicker  imagePicker = ImagePicker();

  Future chooseFolder(String type) async{
    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if(result != null) {
    // List<File> files = result.paths.map((path) => File(path)).toList();
    } else {
      // User canceled the picker
    }
  }

  Future chooseFile(String type) async{
    ImageSource imgSrc;
    if(type == "camera"){
      imgSrc= ImageSource.camera;
    }else{
      imgSrc= ImageSource.gallery;
    }

    final selectedImage = await imagePicker.getImage(
        source: imgSrc,
      imageQuality: 50,
    );
    setState(() {
      imageFile = selectedImage;
    });
  }

  void showFileDialog(BuildContext ctx){
    showDialog(
      context:  ctx,
      builder:  (ctx){
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Pick image from:"),
          actions:[
            ElevatedButton.icon(
              onPressed: (){
                chooseFile("camera");
              },
              icon:  Icon(Icons.camera),
              label: Text("camera"),
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.teal[200],
                elevation: 0
              ),
            ),
            ElevatedButton.icon(
              onPressed: (){
                chooseFile("gallery");
              },
              icon:  Icon(Icons.folder_outlined),
              label: Text("gallery"),
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.teal[200],
                  elevation: 0
              ),
            ),
          ],
        );
      }
    );
  }

  //mengurangi memori ketika mengetik
  @override
  void dispose(){
    ctrlColor.dispose();
    ctrlContact.dispose();
    super.dispose();
  }

  void clearForm(){
    ctrlColor.clear();
    ctrlContact.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Template"),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() =>  Navigator.pushReplacementNamed(context, ListTemplate.routeName),
          )
      ),
      resizeToAvoidBottomInset: false ,
      body: Container(
        width : double.infinity,
        height : double.infinity,
        child: Stack(
          children:[
            Container(
              alignment: Alignment.topCenter,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: [
                  Image.asset("assets/images/portolink.png", height: 300
                  ),

                  SizedBox(height:15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.black54,),
                      Text(" "+widget.templateName, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                    ],
                  ),
                  SizedBox(height:15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.black54,),
                      Text("  "+widget.description, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                    ],
                  ),
                  SizedBox(height:15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.black54,),
                      Text("  "+widget.price, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child:ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Form(
                      key:_formKey,
                      child:  Column(
                        children: [
                          SizedBox(height:24),
                          TextFormField(
                            controller:  ctrlColor,
                            keyboardType:  TextInputType.name,
                            decoration: InputDecoration(
                              labelText:"Color",
                              prefixIcon: Icon(Icons.label),
                              //  border: OutlineInputBorder(),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value.isEmpty){
                                return"Please fill the field!";
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height:24),
                          TextFormField(
                            controller:  ctrlContact,
                            keyboardType:  TextInputType.name,
                            //maxLines: 3,
                            decoration: InputDecoration(
                              labelText:"Active contact",
                              prefixIcon: Icon(Icons.class__outlined),
                              //  border: OutlineInputBorder(),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value.isEmpty){
                                return"Please fill the field!";
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height:24),

                          ElevatedButton.icon(
                              onPressed: () async {
                                if(_formKey.currentState.validate() ){
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Order order = Order("",widget.templateName,ctrlColor.text,
                                      ctrlContact.text,"","","");
                                  await OrderServices.addOrder(order, imageFile).then((value){
                                    if(value == true){
                                      Fluttertoast.showToast(msg: "Add order succesfully !",
                                          backgroundColor: Colors.green);
                                      clearForm();
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pushReplacementNamed(context, Dashboard.routeName);
                                    }else{
                                      ActivityServices.showToast("Add Order failed", Colors.red);
                                    }
                                  });
                                }else{
                                  ActivityServices.showToast("Please check form fields !", Colors.red);
                                  // bisa dikosongkan saja
                                  //Fluttertoast.showToast(msg: "Please check the fields !",backgroundColor: Colors.red);
                                }
                              },
                              icon : Icon(Icons.save),
                              label: Text("submit order"),
                              style : ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.teal[200],
                                elevation: 4,
                              )
                          ),

                        ],
                      ),
                    ),
                  ]
              ) ,
            ),

            isLoading == true
                ? ActivityServices.loadings()
                : Container()
          ]
        ),
      ),
    );
  }
}

