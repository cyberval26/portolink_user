part of 'pages.dart';

class OrderTemplate extends StatefulWidget {
  static const String routeName = "/ordertemplate";
  final String tid;
  final String name;
  final String desc;
  final String price;
  final String photo;
  const OrderTemplate({
    Key key,
    this.tid,
    this.name,
    this.desc,
    this.price,
    this.photo,
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
  final ImagePicker imagePicker = ImagePicker();
  Future chooseFile(String type) async {
    ImageSource imgSrc;
    if (type == "camera") {
      imgSrc = ImageSource.camera;
    } else {
      imgSrc = ImageSource.gallery;
    }
    final selectedImage = await imagePicker.getImage(
      source: imgSrc,
      imageQuality: 50,
    );
    setState(() {
      imageFile = selectedImage;
    });
  }
  void showFileDialog(BuildContext ctx) {
    showDialog(
      context: ctx, builder: (ctx) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Pick image from:"),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                chooseFile("camera");
              },
              icon: const Icon(Icons.camera),
              label: const Text("camera"),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.blue,
                elevation: 0
              )
            ),
            ElevatedButton.icon(
              onPressed: () {
                chooseFile("gallery");
              },
              icon: const Icon(Icons.folder_outlined),
              label: const Text("gallery"),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.blue,
                elevation: 0
              )
            )
          ]
        );
      }
    );
  }
  //mengurangi memori ketika mengetik
  @override
  void dispose() {
    ctrlColor.dispose();
    ctrlContact.dispose();
    super.dispose();
  }
  void clearForm() {
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
        title: const Text("Order Template"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, ListTemplate.routeName),
        )
      ),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Image.network(widget.photo, fit: BoxFit.cover, width: double.infinity),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " " + widget.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ActivityServices.toIDR(widget.price),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24)
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: (
                              Text(
                                "  " + widget.desc,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 24),
                              )
                            )
                          )
                        ]
                      ),
                      const SizedBox(height: 45),
                      Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Text(
                              "Cara Pemesanan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              )
                            ),
                            SizedBox(height: 12),
                            Text(
                              "1.Pembeli akan memasukkan data pembelian yang tersedia",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24, color: Colors.white)
                            ),
                            SizedBox(height: 5),
                            Text(
                              "2.Color untuk digunakan untuk memilih warna yang pembeli inginkan dari warna template yang tersedia",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "3.Active contact dapat disi dengan media sosial line, whatsapp, gmail ",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24, color: Colors.white)
                            ),
                            SizedBox(height: 5),
                            Text(
                              "4.Pembeli akan mengkonfirmasi pesanan dengan menekan tombol pesan",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "5.Seletah order terkirim, pembeli akan dihubungi lewat"
                              " contact yang telah dicantumkan untuk proses lebih lanjutnya",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "6.Pembayaran akan digunakan melalui aplikasi e-wallet dan m-banking ",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "7.Barang pesanan akan dikirim melalui apikasi melalui menu pending ",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24, color: Colors.white)
                            )
                          ]
                        )
                      ),
                      const SizedBox(height: 15),
                      const SizedBox(height: 15),
                      const Text(
                        "Form Pemesanan",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlColor,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Color",
                          prefixIcon: Icon(Icons.label)
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the field!";
                          } else {
                            return null;
                          }
                        }
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlContact,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Active Contact",
                          prefixIcon: Icon(Icons.class__outlined)
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the field!";
                          } else {
                            return null;
                          }
                        }
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => RequestTemplate(
                                tid: widget.tid,
                                name: widget.name,
                                desc: widget.desc,
                                price: widget.price,
                                photo: widget.photo
                              )
                            )
                          );
                        },
                        child: const Text(
                          "Memiliki request sendiri ?",
                          style: TextStyle(color: Colors.deepPurple, fontSize: 16)
                        )
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Order order = Order("", widget.name, ctrlColor.text, ctrlContact.text, "", "", "");
                            Pending pending = Pending("", widget.name, "", "", ctrlColor.text, "", "", "");
                            await OrderServices.addOrder(order, pending, imageFile).then((value) {
                              if (value == true) {
                                Fluttertoast.showToast(
                                  msg: "Add Order Success",
                                  backgroundColor: Colors.grey
                                );
                                clearForm();
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushReplacementNamed(context, ListTemplate.routeName);
                              } else {
                                ActivityServices.showToast("Add Order failed", Colors.red);
                              }
                            });
                          } else {
                            ActivityServices.showToast("Please check form fields", Colors.red);
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Submit Order"),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.blue,
                          elevation: 4
                        )
                      )
                    ]
                  )
                )
              ]
            ),
            isLoading == true
            ? ActivityServices.loadings()
            : Container()
          ]
        )
      )
    );
  }
}