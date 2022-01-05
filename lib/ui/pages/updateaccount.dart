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
  final ctrlPhone = TextEditingController();
  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();
  //mengurangi memori ketika mengetik
  @override
  void initState() {
    ctrlName.text = widget.name;
    ctrlPhone.text = widget.phone;
    super.initState();
  }
  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPhone.dispose();
    super.dispose();
  }
  void clearForm() {
    ctrlName.clear();
    ctrlPhone.clear();
    setState(() {
      imageFile = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Account"),
        centerTitle: true
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
                      const SizedBox(height: 48),
                      TextFormField(
                        controller: ctrlName,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.bookmark)
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
                        controller: ctrlPhone,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(Icons.phone),
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
                              "",
                              "",
                              "",
                              ""
                            );
                            await AuthServices.updateAccount(users, widget.id).then((value) {
                              if (value == true) {
                                Fluttertoast.showToast(msg: "Update Success!", backgroundColor: Colors.grey);
                                clearForm();
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushReplacementNamed(context, AccountView.routeName);
                              } else {
                                ActivityServices.showToast("Update failed", Colors.red);
                              }
                            });
                          } else {
                            ActivityServices.showToast("Please check form fields!", Colors.red);
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Update Profile") 
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