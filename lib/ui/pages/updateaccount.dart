part of 'pages.dart';

class UpdateAccount extends StatefulWidget {
  static const String routeName = "/ordertemplate";
  final String id;
  final String name;
  final String phone;
  final String email;

  const UpdateAccount({
    Key key,
    this.id,
    this.name,
    this.phone,
    this.email,
  }) : super(key: key);
  @override
  _UpdateAccountState createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlContact = TextEditingController();
  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  //mengurangi memori ketika mengetik

  @override
  void initState() {
    ctrlName.text = widget.name;
    ctrlEmail.text = widget.email;
    ctrlPhone.text = widget.phone;
    super.initState();
  }

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPhone.dispose();
    ctrlContact.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlEmail.clear();
    ctrlPhone.clear();
    ctrlContact.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Update Account"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, ListTemplate.routeName),
          )),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          Container(
            child: ListView(padding: EdgeInsets.all(16), children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: ctrlName,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Nama",
                        prefixIcon: Icon(Icons.label),
                        //  border: OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill the field!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: ctrlPhone,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        prefixIcon: Icon(Icons.phone),
                        //  border: OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill the field!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: ctrlEmail,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.mail),
                        //  border: OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill the field!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Users users = Users(
                              "",
                              ctrlName.text,
                              ctrlPhone.text,
                              ctrlEmail.text,
                              "",
                              "",
                              "",
                            );
                            await AuthServices.updateaccount(users, widget.id)
                                .then((value) {
                              if (value == true) {
                                Fluttertoast.showToast(
                                    msg: "Add order succesfully !",
                                    backgroundColor: Colors.green);
                                clearForm();
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushReplacementNamed(
                                    context, Dashboard.routeName);
                              } else {
                                ActivityServices.showToast(
                                    "Add Order failed", Colors.red);
                              }
                            });
                          } else {
                            ActivityServices.showToast(
                                "Please check form fields !", Colors.red);
                            // bisa dikosongkan saja
                            //Fluttertoast.showToast(msg: "Please check the fields !",backgroundColor: Colors.red);
                          }
                        },
                        icon: Icon(Icons.save),
                        label: Text("Update Profile"),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.teal[200],
                          elevation: 4,
                        )),
                  ],
                ),
              ),
            ]),
          ),
          isLoading == true ? ActivityServices.loadings() : Container()
        ]),
      ),
    );
  }
}
