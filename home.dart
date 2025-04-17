import 'package:flutter/material.dart';
import 'helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<Map<String, dynamic>> userDataFuture;
  late Future<Map<String, dynamic>> productDataFuture;

  @override
  void initState() {
    super.initState();
    userDataFuture = getUserData();
    productDataFuture = getProductData();
  }

  Future<Map<String, dynamic>> getUserData() async {
    await Future.delayed(Duration(seconds: 1));
    return {'name': 'Alice', 'age': 30};
  }

  Future<Map<String, dynamic>> getProductData() async {
    await Future.delayed(Duration(seconds: 1));
    return {'product': 'Laptop', 'price': 999};
  }

  
 void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('This is an alert message!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Data Fetch Example'),
      ),
      body: FutureBuilder(
        future: Future.wait([userDataFuture, productDataFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var userData = snapshot.data![0];
            var productData = snapshot.data![1];
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    title: Text('User: ${userData['name']}'),
                    subtitle: Text('Age: ${userData['age']}'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Product: ${productData['product']}'),
                    subtitle: Text('Price: \$${productData['price']}'),
                  ),
                  SizedBox(
                    child: ElevatedButton(onPressed: () async {
                      setSession('authedUser', null);
                      Navigator.pushReplacementNamed(context, '/login');
                    }, child: const Text('登出')),
                  ),
                  SizedBox(
                    child: 
                    ElevatedButton(
                      onPressed: () => _showAlert(context),
                      child: Text('Show Alert'),
                    )
                  )
                ],
              )
            ) ;
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
  
}