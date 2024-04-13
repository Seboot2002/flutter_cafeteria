const Order = require("../models/order");
const Dish = require("../models/dish");
const User = require("../models/user");

const OrderController = {

    saveOrder: (req, res)=>{
        let userId = req.idUser;
        let dishId = req.params.dishId;
        let sellerId = req.params.sellerId;
        let newOrder = new Order();

        User.findOne({_id: userId, type: "customer"}, (err, customer)=>{

            if(!customer) res.send("You are not a customer");
            if(customer){

                newOrder.state = "Recibido";
                newOrder.customer = userId;
                newOrder.dish = dishId;
                newOrder.seller = sellerId;
                    
                Dish.findById(dishId, (err, dish)=>{
                    newOrder.price = dish.price;
        
                    newOrder.save((err, dishSaved)=>{
                        if(err) res.send(err);
                        if(dishSaved) res.send(dishSaved);
                    });
                });
            }
        });

    },

    deleteOrder: (req, res)=>{
        let userId = req.idUser;
        let idOrder = req.params.id;
        
        User.findOne({_id: userId, type: "seller"}, (err, seller)=>{
        
            if(!seller) res.send("You are not a seller");
            if(seller){

                Order.findByIdAndDelete({_id: idOrder}, (err, order)=>{
                    if(err) res.send(err);

                    res.send({Deleted_Order: order});
                });
            }
        });

    },

    updateOrder: (req, res)=>{
        let userId = req.idUser;
        let idOrder = req.params.id;
        let newData = req.body;

        User.findOne({_id: userId, type: "seller"}, (err, seller)=>{

            if(!seller) res.send("You are not a seller");
            if(seller)
            {
                Order.findByIdAndUpdate({_id: idOrder}, newData, {new: true}, (err, orderUpdated)=>{
                    if(err) return res.send(err);
                    if(!orderUpdated) return res.send("No se pudo eliminar");

                    return res.send(orderUpdated);
                })
            }
        });

    },

    getOrdersSeller(req, res){
        let userId = req.idUser;

        User.findOne({_id: userId, type: "seller"}, (err, seller)=>{
            if(!seller) res.send("You are not a customer");

            if(seller){
                
                //En populate debes agregar el modelo registrado con el nombre del esquema de este servidor
                Order.find({seller: userId}).populate([{path: 'customer', model: 'User', select: {'password': 0}}, {path: 'dish', model: 'Dish'}]).clone().exec((err, orders)=>{

                    if(err) res.send(err);
                    if(!orders) res.send("No hay ordenes");

                    if(orders){
                        var totalPrice = 0;

                        orders.forEach(order => {
                            totalPrice += order.price;
                        });

                        res.send({orders: orders, totalPrice: totalPrice});
                    }
                });
            }
        });
    },

    getOrdersCustomer: (req, res)=>{
        let userId = req.idUser;

        User.findOne({_id: userId, type: "customer"}, (err, customer)=>{

            if(!customer) res.send("You are not a customer");

            if(customer){

                Order.find({ customer: customer._id }).populate([{path: 'customer', model: 'User', select: {'password': 0}}, {path: 'dish', model: 'Dish'}]).clone().exec((err, orders)=>{
                    if(err) res.send(err);
        
                    if(orders){
                        var totalPrice = 0;
        
                        orders.forEach(order => {
                            totalPrice += order.price;
                        });
        
                        res.send({orders: orders, totalPrice: totalPrice});
                    }
                });
            }
        });

    }

}

module.exports = OrderController;