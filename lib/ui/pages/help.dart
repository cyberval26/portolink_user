part of'pages.dart';

class Help extends StatefulWidget {
  const Help({Key key}) : super(key: key);
  @override
  _HelpState createState() => _HelpState();
}
class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        alignment: Alignment.topCenter,
        child: ListView(
          children: [
            const SizedBox(height:15),
            Image.asset("assets/images/portolink.png", height: 300),
            const SizedBox(height:15),
            const SizedBox(height:45),
            const Text("Cara Pemesanan", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold)),
            const SizedBox(height: 12),
            const Text("1.Pembeli memilih Template yang anda pesan", textAlign: TextAlign.left, style: TextStyle(fontSize: 24)),
            const SizedBox(height:5),
            const Text("2.Pembeli akan memasukkan data pembelian yang tersedia", textAlign: TextAlign.left, style: TextStyle(fontSize: 24)),
            const SizedBox(height:5),
            const Text("3.Pembeli akan mengkonfirmasi pesanan dengan menekan tombol pesan", textAlign: TextAlign.left, style: TextStyle(fontSize: 24)),
            const SizedBox(height:5),
            const Text("4.Seletah order terkirim, pembeli akan dihubungi lewat"" contact yang telah dicantumkan untuk proses lebih lanjutnya", textAlign: TextAlign.left, style: TextStyle(fontSize: 24)),
            const SizedBox(height:5),
            const Text("5.Pembayaran akan digunakan melalui aplikasi e-wallet dan m-banking ", textAlign: TextAlign.left, style: TextStyle(fontSize: 24)),
            const SizedBox(height:5),
            const Text("6.Barang pesanan akan dikirim melalui apikasi melalui menu pending ", textAlign: TextAlign.left, style: TextStyle(fontSize: 24)),
            const SizedBox(height:15)
          ]
        ),
      ),
    );
  }
}