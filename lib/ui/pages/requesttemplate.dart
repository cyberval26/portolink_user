part of 'pages.dart';

class RequestTemplate extends StatefulWidget {
  static const String routeName = "/ordertemplate";
  final String tid;
  final String name;
  final String desc;
  final String price;
  final String photo;

  const RequestTemplate(
      {Key key,
        this.tid,
        this.name,
        this.desc,
        this.price,
        this.photo,
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
                  primary: Colors.blue,
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
                  primary: Colors.blue,
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
            onPressed:() =>  Navigator.pushReplacementNamed(context, MainMenu.routeName),
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
                          Image.network(
                            widget.photo,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          SizedBox(height:15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(" "+widget.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(ActivityServices.toIDR(widget.price) ,textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
                          SizedBox(height:15),
                          Row(
                            children: [
                              Expanded(
                                child:(
                                    Text("  "+widget.desc, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:45),
                          Container(
                            color: Colors.blue,
                            padding: EdgeInsets.all(10),
                            child:Column(
                                children:[
                                  Text("Cara Pemesanan", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold,color: Colors.white),),
                                  const SizedBox(height: 12),
                                  Text("1.Pembeli akan memasukkan data pembelian yang tersedia", textAlign: TextAlign.left, style: TextStyle(fontSize: 24,color: Colors.white),),
                                  SizedBox(height:5),
                                  Text("2.Pembeli dapat memasukkan desain seperti apa yang dinginkan untuk template ini", textAlign: TextAlign.left, style: TextStyle(fontSize: 24,color: Colors.white),),
                                  SizedBox(height:5),
                                  Text("3.Active contact dapat disi dengan media sosial line, whatsapp, gmail ", textAlign: TextAlign.left, style: TextStyle(fontSize: 24,color: Colors.white),),
                                  SizedBox(height:5),
                                  Text("4.Pembeli dimohon untuk mencantukan foto contoh referensi yang dinginkan,"
                                      " untuk penambahan / update foto referensi akan dilakukan lebih lanjut melalui kontak personal", textAlign: TextAlign.left, style: TextStyle(fontSize: 24,color: Colors.white),),
                                  SizedBox(height:5),
                                  Text("5.Pembeli akan mengkonfirmasi pesanan dengan menekan tombol pesan", textAlign: TextAlign.left, style: TextStyle(fontSize: 24,color: Colors.white),),
                                  SizedBox(height:5),
                                  Text("6.Seletah order terkirim, pembeli akan dihubungi lewat"
                                      " contact yang telah dicantumkan untuk proses lebih lanjutnya", textAlign: TextAlign.left, style: TextStyle(fontSize: 24,color: Colors.white),),
                                  SizedBox(height:5),
                                  Text("7.Pembayaran akan digunakan melalui aplikasi e-wallet dan m-banking ", textAlign: TextAlign.left, style: TextStyle(fontSize: 24,color: Colors.white),),
                                  SizedBox(height:5),
                                  Text("8.Barang pesanan akan dikirim melalui apikasi melalui menu pending ", textAlign: TextAlign.left, style: TextStyle(fontSize: 24,color: Colors.white),),
                                ]
                            ),
                          ),
                          SizedBox(height:15),
                          SizedBox(height:15),
                          Text("Form Pemesanan", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),),
                          SizedBox(height:24),
                          TextFormField(
                            controller:  ctrlDesc,
                            keyboardType:  TextInputType.name,
                            decoration: InputDecoration(
                              labelText:"description design",
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
                          TextFormField(
                            controller:  ctrlContact,
                            keyboardType:  TextInputType.name,
                            decoration: InputDecoration(
                              labelText:"Active Contact",
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
                              Text("file tidak ditemukan."),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderTemplate(
                                        tid: widget.tid,
                                        name: widget.name,
                                        desc: widget.desc,
                                        price: widget.price,
                                        photo :widget.photo,
                                      )));
                            },
                            child :const Text("Ingin memilih template yang sudah ada ?",
                              style : TextStyle(color: Colors.deepPurple,
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
                                  Order order = Order("",widget.name,"",
                                      ctrlContact.text,ctrlDesc.text,"","");
                                  Pending pending = Pending("",widget.name,"",
                                      "", "", ctrlDesc.text,"", "");

                                  await OrderServices.addRequest(order, pending, imageFile).then((value){
                                    if(value == true){
                                      Fluttertoast.showToast(msg: "Add order succesfully !",
                                          backgroundColor: Colors.green);
                                      clearForm();
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pushReplacementNamed(context, MainMenu.routeName);
                                    }else{
                                      ActivityServices.showToast("Add Order failed", Colors.red);
                                    }
                                  });

                                  await PendingServices.addPending(pending, imageFile).then((value){
                                    if(value == true){
                                      Fluttertoast.showToast(msg: "You can check your order in pending list !",
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
                                primary: Colors.blue,
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

