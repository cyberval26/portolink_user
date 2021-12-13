part of 'pages.dart';

class RequestTemplate extends StatefulWidget {
  static const String routeName = "/ordertemplate";
  final String templateId;
  final String templateName;
  final String description;
  final String price;
  final String photoFile;

  const RequestTemplate(
      {Key key,
        this.templateId,
        this.templateName,
        this.description,
        this.price,
        this.photoFile,
      })
      : super(key: key);
  @override
  _RequestTemplateState createState() => _RequestTemplateState();
}

class _RequestTemplateState extends State<RequestTemplate> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlDesc = TextEditingController();
  final ctrlContact = TextEditingController();
  PickedFile imageFile;
  final ImagePicker  imagePicker = ImagePicker();

  Future chooseFolder(String type) async{
    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if(result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
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
    ctrlDesc.dispose();
    ctrlContact.dispose();
    super.dispose();
  }

  void clearForm(){
    ctrlDesc.clear();
    ctrlContact.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Design Request"),
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
              child:ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Form(
                      key:_formKey,
                      child:  Column(
                        children: [
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
                          SizedBox(height:24),
                          TextFormField(
                            controller:  ctrlDesc,
                            keyboardType:  TextInputType.name,
                            decoration: InputDecoration(
                              labelText:"description",
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

                         imageFile == null ?
                          Column(
                            children :[
                              ElevatedButton.icon(
                                onPressed: (){
                                  showFileDialog(context);
                                  // chooseFile();
                                },
                                icon: Icon(Icons.photo_camera),
                                label:Text ("Ambil foto"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors.deepPurple
                                ),
                              ),
                              SizedBox(height:16),
                              Text("file tidak ditemukan.")
                            ],
                          )
                              :
                         Column(
                            children :[
                              ElevatedButton.icon(
                                onPressed: (){
                                  showFileDialog(context);
                                  // chooseFile();
                                },
                                icon: Icon(Icons.photo_camera),
                                label:Text ("Ulang foto"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors.deepPurple
                                ),
                              ),

                              SizedBox(height:16),
                              Semantics(
                                child : Image.file(File(imageFile.path),
                                  width:100,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height:24),
                          SizedBox(height: 24),
                          GestureDetector(
                            onTap :(){
                              Navigator.pushReplacementNamed(context, Register.routeName);
                            },
                            child :const Text("memiliki request sendiri",
                              style : TextStyle(color: Colors.tealAccent,
                                  fontSize : 16
                              ),
                            ),
                          ),
                          SizedBox(height:24),

                          ElevatedButton.icon(
                              onPressed: () async {
                                if(_formKey.currentState.validate() ){
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Order order = Order("",widget.templateName,ctrlDesc.text,
                                      "","","","");
                                  await OrderServices.addRequest(order, imageFile).then((value){
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
