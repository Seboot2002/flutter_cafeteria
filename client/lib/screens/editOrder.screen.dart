import 'package:app_flutter/services/order.service.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {

  final String idOrder;

  const EditScreen(this.idOrder, {super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  String _dropDownValue = "Recibido";

  @override
  Widget build(BuildContext context) {
    
    final TextEditingController _stateController = TextEditingController();
    var token = "";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)
            ),
            DropdownButton(
              items: const [
                DropdownMenuItem(child: Text('Recibido'), value: 'Recibido'),
                DropdownMenuItem(child: Text('Preparando'), value: 'Preparando'),
                DropdownMenuItem(child: Text('Listo'), value: 'Listo'),
              ],
              onChanged: (String? value) {

                _dropDownValue = value!;
              }),
            SizedBox(height: 10.0),
            ElevatedButton(
              child: Text('Ingresar'),
              onPressed: () async {
                var res = await orderService().updateOrder('token', widget.idOrder, _dropDownValue).then((res) async {

                  await orderService().getOrders("token");
                  print(res);

                  if(res == null){
                    print("Error");
                  }

                });
              },
            ),
          ],
        ),
      ),
    );
  }
}