import 'package:flutter/material.dart';

var products = [
  {
    "id": 1,
    "name": "Netflix Temel Plan (Aylık) ",
    "in-stock": true,
    "photo":
        "https://images.ctfassets.net/y2ske730sjqp/1aONibCke6niZhgPxuiilC/2c401b05a07288746ddf3bd3943fbc76/BrandAssets_Logos_01-Wordmark.jpg?w=940"
  },
  {
    "id": 2,
    "name": "Netflix Standard Plan (Aylık) ",
    "in-stock": true,
    "photo":
        "https://images.ctfassets.net/y2ske730sjqp/1aONibCke6niZhgPxuiilC/2c401b05a07288746ddf3bd3943fbc76/BrandAssets_Logos_01-Wordmark.jpg?w=940"
  },
  {
    "id": 3,
    "name": "Netflix Özel Plan (Aylık) ",
    "in-stock": true,
    "photo":
        "https://images.ctfassets.net/y2ske730sjqp/1aONibCke6niZhgPxuiilC/2c401b05a07288746ddf3bd3943fbc76/BrandAssets_Logos_01-Wordmark.jpg?w=940"
  },
  {
    "id": 4,
    "name": "Netflix Özel Plan (Yıllık %30 İndirimli ) ",
    "in-stock": true,
    "photo":
        "https://images.ctfassets.net/y2ske730sjqp/1aONibCke6niZhgPxuiilC/2c401b05a07288746ddf3bd3943fbc76/BrandAssets_Logos_01-Wordmark.jpg?w=940"
  }
];

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({super.key});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            //netflix iconu
            title: Row(
              children: [
                Image.asset(
                  'assets/images/netflix_logo.png',
                  height: 20,
                  width: 80,
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Anasayfa',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Diziler',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Filmler',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Yeni ve Popüler',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Listem',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Dile Göz At',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_outlined),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/f/f7/Reuni%C3%A3o_com_o_ator_norte-americano_Keanu_Reeves_cropped_2_%2846806576944%29_%28cropped%29.jpg',
                    fit: BoxFit.cover,
                  )),
            ],
          ),
        ),
      ),
      body: SizedBox.expand(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(1.0),
            ),
            margin: const EdgeInsets.all(14.0),
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Image.network(products[index]["photo"].toString()),
                Text(products[index]["name"].toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
