import 'package:flutter/material.dart';
import 'package:flutter_app_list/notification_page.dart';
import 'package:flutter_app_list/profile_page.dart';

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

  Widget _buildCard() => Column(
        children: [
          ListTile(
            title:
                Text('Profile', style: TextStyle(fontWeight: FontWeight.w500)),
            leading: Icon(
              Icons.person,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: Icon(
              Icons.notifications,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => NotificationPage()));            },
          ),
          ListTile(
            title: Text(
              'Drinks info',
            ),
            leading: Icon(
              Icons.info,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              print("Hello");
            },
          ),
          ListTile(
            title: Text(
              'Default Volumes',
            ),
            leading: Icon(
              Icons.free_breakfast,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              print("Hello");
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Send feedback',
            ),
            leading: Icon(
              Icons.feedback,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              print("Hello");
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Share with friends',
            ),
            leading: Icon(
              Icons.share,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              print("Hello");
            },
          ),
          ListTile(
            title: Text(
              'Rate us',
            ),
            leading: Icon(
              Icons.star,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              print("Hello");
            },
          ),
        ],
      );
}
