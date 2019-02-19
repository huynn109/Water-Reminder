import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        elevation: 0.toDouble(),
        title: Text('Account'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard() =>
      SizedBox(
        height: 210,
        child: Card(
          elevation: 4.0,
          color: Colors.indigo,
          child: Column(
            children: [
              ListTile(
                title: Text('1625 Main Street',
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                subtitle: Text(
                  'My City, CA 99984', style: TextStyle(color: Colors.white),),
                leading: Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                ),
              ),
              Divider(color: Colors.white10,),
              ListTile(
                title: Text('(408) 555-1212',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: Text(
                    'costa@example.com', style: TextStyle(color: Colors.white),
                    ),
                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
}