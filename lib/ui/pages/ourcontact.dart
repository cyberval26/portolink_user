part of'pages.dart';

class OurCountact extends StatefulWidget {
  const OurCountact({Key key}) : super(key: key);

  @override
  _OurCountactState createState() => _OurCountactState();
}

class _OurCountactState extends State<OurCountact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(40),
          alignment: Alignment.topCenter,
          child: ListView(
              children: [
                SizedBox(height:15),
                Image.asset("assets/images/portolink.png", height: 300),
                SizedBox(height:15),
                SizedBox(height:45),
                Text("Cara Pemesanan", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),),
                const SizedBox(height: 12),
                Text("1.Pembeli memilih Template yang anda pesan", textAlign: TextAlign.left, style: TextStyle(fontSize: 24),),
                SizedBox(height:5),
                Text("2.Pembeli akan memasukkan data pembelian yang tersedia", textAlign: TextAlign.left, style: TextStyle(fontSize: 24),),
                SizedBox(height:5),
                Text("3.Pembeli akan mengkonfirmasi pesanan dengan menekan tombol pesan", textAlign: TextAlign.left, style: TextStyle(fontSize: 24),),
                SizedBox(height:5),
                Text("4.Seletah order terkirim, pembeli akan dihubungi lewat"
                    " contact yang telah dicantumkan untuk proses lebih lanjutnya", textAlign: TextAlign.left, style: TextStyle(fontSize: 24),),
                SizedBox(height:5),
                Text("5.Pembayaran akan digunakan melalui aplikasi e-wallet dan m-banking ", textAlign: TextAlign.left, style: TextStyle(fontSize: 24),),
                SizedBox(height:5),
                Text("6.Barang pesanan akan dikirim melalui apikasi melalui menu pending ", textAlign: TextAlign.left, style: TextStyle(fontSize: 24),),
                SizedBox(height:15),
              ]
          ),
      ),
    );
  }
}
