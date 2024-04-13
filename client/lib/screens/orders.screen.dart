import 'package:app_flutter/services/order.service.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {

  final List ordersData;

  const OrdersScreen(this.ordersData, {super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: ListView.builder(
        itemCount: widget.ordersData.length,
        itemBuilder: (context, index) {

          return Card(
            child: Row(
              children: [
                Text("${widget.ordersData[index]['dish']['name']}"),
                SizedBox(width: 10.0,),
                Text("Cliente: ${widget.ordersData[index]['customer']['name']}"),
                SizedBox(width: 10.0,),

                TextButton(onPressed: () {

                  orderService().deleteOrder("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYTRjZWFhYTM0NzFjODU1ZDkwM2M2MSIsImlhdCI6MTY3MzEzMTI4NywiZXhwIjoxNjczMjE3Njg3fQ.QJx3E36bNvc3_yrD1nlghitiCef46nne18XSckFRGzM", widget.ordersData[index]['_id']).then((res) {

                    orderService().getOrders("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYTRjZWFhYTM0NzFjODU1ZDkwM2M2MSIsImlhdCI6MTY3MzEzMTI4NywiZXhwIjoxNjczMjE3Njg3fQ.QJx3E36bNvc3_yrD1nlghitiCef46nne18XSckFRGzM");
                    
                    print("Order eliminated");
                  });
                },
                child: Text('Delete')
                ),
              ],
            ),
          );
        },)
        );
  }
}