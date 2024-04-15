import 'package:flutter/material.dart';

import 'package:app_flutter/screens/screens.dart';//Aqui importamos todos los screens para ahorrar espacio

void main() {
  runApp(const MyApp());
}

//StatelessWidget dibuja una vez y no nos permite cambiar los valores mostrados
class MyApp extends StatelessWidget {
  const MyApp({super.key});//Constructor, pero si se agrega el {} se vuelven opcionales los parametros

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen() /*const MyHomePage(title: 'Flutter Demo Home Page')*/,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/homeSeller': (context) => const HomeSellerScreen(),
      },
    );
  }
}

//StatefulWidget dibuja en la pantalla, pero nos permite cambiar los valores llamando al metodo setState()
//En este caso se divide en dos clases entre el StatefulWidget y su Estado
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); //Ejecutamos el estado que se encarga de manejar los cambios de los valores
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0; //En el estado podemos agregar variables que no son 'final', es decir que pueden cambiar

  void _incrementCounter() {
    //Al ejecutar la funcion se generamos un setState que redibuja la pantalla pero cambiando valores, todo mediante una funcion anonima. Se volvera a ejecutar el metodo build
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold( //Scaffold es el tipo de estructura de la app que tendrda un appBar y body
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView( //Hay widgets que pediran varios widgets como hijos como 'Column con Containers' o 'ListView con Containers'
        children: [
          Container( //Container es como un div con sus caracteristicas
            //Hay widgets que estan hechos para contener a otros widgets como 'Container con child' o 'Center con child'
            padding: const EdgeInsets.all(20.0),
            child: Image.network('https://www.laespanolaaceites.com/wp-content/uploads/2019/06/pizza-con-chorizo-jamon-y-queso-1080x671.jpg'),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Image.network('https://www.laespanolaaceites.com/wp-content/uploads/2019/06/pizza-con-chorizo-jamon-y-queso-1080x671.jpg'),
          ),
          Container(
            child: Row( //Filas
              mainAxisAlignment: MainAxisAlignment.center, //Los elementos se centran segun el tamaño en el eje principal, en el caso del row es x
              crossAxisAlignment: CrossAxisAlignment.center, //Los elementos se centran segun el tamaño en el eje principal, en el caso del row es y
              mainAxisSize: MainAxisSize.max, //El row tendra el tamaño maximo que puede, toda la pantalla
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.5, //Obtengo el tamano with del contexto del widget de Home
                  child: const Text("data1", textAlign: TextAlign.center)
                  ),
                const Text("data2")
              ],
            ),
          ),
          Container(
            child: ElevatedButton( //Boton
              onPressed: () {
                //Se ejecuta una funcion anonima
                var t = DateTime.now();
                print(t);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(
                    //Generar espacio entre elementos
                    width: 7,
                  ),
                  cuerpo()
                ],
              ),
            ),
          ),
          mostrarPulsaciones(_counter)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar valor mostrado',
        child: const Icon(Icons.add),
      ),
    );

  }
}

//Puedes crear más widgets que podrás utilizar dentro de otros widgets para ahorrar espacio
Widget mostrarPulsaciones(counter) {

  return Container(
    child: Column(
      children: [
        const Text("Cantidad de veces que presionaste:"),
        Text('$counter')
      ],
    ),
  );

}

Widget cuerpo() {
  
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(image: NetworkImage("https://fondosmil.com/fondo/70852.jpg"),
      fit: BoxFit.cover
      )
    ),
    child: const Text("Tiempo actual"),
  );
}

Widget nombre() {

  return Container(
    child: const Text("Login", style: TextStyle(
      color: Colors.blue,
      fontSize: 12.0,
      fontWeight: FontWeight.bold
    )
    ),
  );
}

Widget CampoEmail() {

  return Container(
    child: const TextField(
      decoration: InputDecoration(
        hintText: 'Email',
        filled: true,
        fillColor: Colors.blueAccent,
      ),
    ),
  );
}