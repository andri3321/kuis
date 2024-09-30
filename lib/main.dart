import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String registeredUsername = '';
  String registeredPassword = '';

  void login() {
    if (_formKey.currentState!.validate()) {
      if (usernameController.text == registeredUsername && passwordController.text == registeredPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login berhasil!')));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(registeredUsername)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username/Password salah')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/images/login.webp', height: 200),
              SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) => value!.isEmpty ? 'Masukkan username' : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Masukkan password' : null,
              ),
              ElevatedButton(onPressed: login, child: Text('Login')),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage(onRegisterSuccess))), child: Text('Belum punya akun?')),
            ],
          ),
        ),
      ),
    );
  }

  void onRegisterSuccess(String username, String password) {
    setState(() {
      registeredUsername = username;
      registeredPassword = password;
    });
  }
}

class RegisterPage extends StatefulWidget {
  final Function(String, String) onRegisterSuccess;

  RegisterPage(this.onRegisterSuccess);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        widget.onRegisterSuccess(usernameController.text, passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registrasi berhasil')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password tidak sama')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrasi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/images/login.webp', height: 200),
              SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) => value!.isEmpty ? 'Masukkan username' : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Masukkan password' : null,
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: 'Konfirmasi Password'),
                obscureText: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords tidak sama';
                  }
                  return null;
                },
              ),
              ElevatedButton(onPressed: register, child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> foodItems = [
   {'name': 'Bakso', 'price': 15000, 'image': 'assets/images/menu.webp'},
   {'name': 'Mie ayam', 'price': 12000, 'image': 'assets/images/menu.webp'},
   {'name': 'ketoprak', 'price': 12000, 'image': 'assets/images/menu.webp'},
   {'name': 'Gado gado', 'price': 10000, 'image': 'assets/images/menu.webp'},
];

class HomePage extends StatelessWidget {
  final String username;

  HomePage(this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hallo $username'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Log Out',
              style: TextStyle(color: Colors.blue), 
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mau makan apa hari ini?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity, 
              height: 200, 
              child: Image.asset(
                'assets/images/banner.webp', 
                fit: BoxFit.cover, 
              ),
            ),
            SizedBox(height: 16), 
            GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7, 
              ),
              itemCount: foodItems.length,
              shrinkWrap: true, 
              physics: NeverScrollableScrollPhysics(), 
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(foodItems[index]['image'], height: 100), 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          foodItems[index]['name'],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('\Rp${foodItems[index]['price']}'),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => DetailOrderPage(foodItems[index])));
                        },
                        child: Text('Beli'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailOrderPage extends StatefulWidget {
   final Map<String, dynamic> foodItem;

   DetailOrderPage(this.foodItem);

   @override
   _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
   final quantityController = TextEditingController();

   void submitOrder() {
     int quantity = int.tryParse(quantityController.text) ?? 0;
     double pricePerItem = widget.foodItem['price'];
     double totalPrice = quantity * pricePerItem;

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
       Text('Total harga :  \Rp${totalPrice.toStringAsFixed(2)}')));
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar:
         AppBar(title:
         Text(widget.foodItem['name'])),
       body:
         Padding(padding:
           const EdgeInsets.all(16.0),
           child:
             Column(children:[
               Image.asset(widget.foodItem['image']),
               SizedBox(height :10),
               Text(widget.foodItem['name'], style :
                 TextStyle(fontSize :24)),
               SizedBox(height :10),
               Text('\Rp${widget.foodItem['price']}', style :
                 TextStyle(fontSize :20)),
               SizedBox(height :10),
               TextFormField(controller :
                 quantityController, decoration :
                 InputDecoration(labelText :'Quantity')),
               ElevatedButton(onPressed :
                 submitOrder, child :Text('Submit')),
             ])
           )
         );
   }
}