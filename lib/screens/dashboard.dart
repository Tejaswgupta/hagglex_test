import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  static final id = "Dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: BottomNavigationBar(
          selectedFontSize: 12,
          selectedItemColor: Colors.purple[900],
          unselectedItemColor: Colors.grey[400],
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.grid_view,
                size: 30,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet_rounded,
                size: 30,
              ),
              label: "Wallet",
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: Colors.purple[900],
                child:
                    Icon(Icons.compare_arrows, size: 30, color: Colors.white),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_rounded,
                size: 30,
              ),
              label: "Cryptosave",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_rounded,
                size: 30,
              ),
              label: "More",
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopContainer(),
            FloatingCard(),
            CurrencyContainer(),
            Container(height: 5, color: Colors.grey[200]),
            DoMoreContainer(),
            Container(height: 5, color: Colors.grey[200]),
            NewsContainer(),
          ],
        ),
      ),
    );
  }
}

class NewsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Trending on Crypto News",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          for (int i = 0; i < 5; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    "https://specials-images.forbesimg.com/imageserve/5fff7511054c5ffa3d55729a/960x0.jpg?fit=scale",
                    fit: BoxFit.cover,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    "Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "6hrs ago",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Category:",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "DeFi",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          Divider(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("View All stories"),
              Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
          Divider(height: 40),
        ],
      ),
    );
  }
}

class DoMoreContainer extends StatelessWidget {
  final titleList = [
    "Send money instantly",
    "Receive money from anyone",
    "Virtual Card",
    "Global Remittance",
  ];
  final subtitleList = [
    "Send crypto to another wallet",
    "Receive crypto from another wallet",
    "Make faster payments using HaggleX cards",
    "Send money to anyone, anywhere"
  ];
  final iconList = [
    Icons.send,
    Icons.send_outlined,
    Icons.credit_card_outlined,
    Icons.language,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Do more with HaggleX",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 20),
          for (int index = 0; index < titleList.length; index++)
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: ListTile(
                title: Text("${titleList[index]}"),
                subtitle: Text(
                  "${subtitleList[index]}",
                  style: TextStyle(fontSize: 12),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.purple.withOpacity(0.3),
                  child: Icon(
                    iconList[index],
                    color: Colors.purple[900],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class CurrencyContainer extends StatelessWidget {
  final nameList = [
    "Haggle (HAG)",
    "Bitcoin (BTC)",
    "Etherium (ETC)",
    "Tether (USDT)",
    "Bitcoin Cash (BCH)",
    "Dodgecoin (DOGE)",
    "Litecoin (LTC)",
  ];

  final subtitleList = [
    "NGN 380",
    "NGN 4,272,147.00",
    "NGN 4,272,147.00",
    "NGN 4,272,147.00",
    "NGN 4,272,147.00",
    "NGN 4,272,147.00",
    "NGN 4,272,147.00",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("Markets",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for (int index = 0; index < nameList.length; index++)
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(Icons.money, size: 40),
                  title: Text("${nameList[index]}"),
                  subtitle: Row(
                    children: [
                      Text("${subtitleList[index]}"),
                      SizedBox(width: 10),
                      Text(
                        "+2.34%",
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class FloatingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      child: Card(
        color: Colors.purple[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HaggleX",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                "Marketplace",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                "Trade crypto and giftcard on HaggleX securely ",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.purple[200],
                  child: Text(
                    "SV",
                    style: TextStyle(color: Colors.purple[900]),
                  ),
                ),
              ),
              Text("HaggleX",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.2),
                child: Icon(Icons.notifications, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            "Total portfolio balance",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Text(
                "\$*****",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
