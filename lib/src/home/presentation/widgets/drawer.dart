import 'package:flutter/material.dart';



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curved Drawer Example'),
      ),
      drawer: buildCurvedDrawer(context),
      body: Center(
        child: Text('Main Content'),
      ),
    );
  }

  Widget buildCurvedDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.zero,
        child: ClipPath(
          clipper: CurvedDrawerClipper(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'Curved Drawer',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Handle item tap
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Handle item tap
                  },
                ),
                // Add more items as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurvedDrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 30);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height - 20, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
