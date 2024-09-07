import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List of products (T-Shirts) with name, price, and quantity
  List<Map<String, dynamic>> products = [
    {"name": "Heavy Metal T-Shirt", "price": 50.0, "quantity": 1},
    {"name": "Formal T-Shirt", "price": 40.0, "quantity": 1},
    {"name": "Casul T-Shirt", "price": 60.0, "quantity": 1},
  ];

  double getTotalAmount() {
    double total = 0;
    for (var product in products) {
      total += product["price"] * product["quantity"];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          return Column(
            children: [
              // Product List in a scrollable view
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Generate product cards for each T-shirt
                      ...products.map((product) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Product Image
                                Container(
                                  width: isMobile ? 80 : 120,
                                  height: isMobile ? 80 : 120,
                                  child: Image.network(
                                    'https://appdeveloperalex.com/image/tshirt.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16),
                                // Product Description
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product["name"],
                                        style: TextStyle(
                                          fontSize: isMobile ? 16 : 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '\$${product["price"].toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: isMobile ? 14 : 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Quantity Controls
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          if (product["quantity"] > 1) {
                                            product["quantity"]--;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '${product["quantity"]}',
                                      style: TextStyle(
                                        fontSize: isMobile ? 16 : 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          product["quantity"]++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              // Total and Checkout button at the bottom
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Total Amount
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total Amount: \$${getTotalAmount().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final snackBar = SnackBar(
                            content:
                            Text('Congratulations! You have checked out.'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 14 : 18,
                          ),
                        ),
                        child: Text(
                          'CHECK OUT',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
