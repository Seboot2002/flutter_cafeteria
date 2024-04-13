const Dish = require("../models/dish");
const User = require("../models/user");

const DishController = {

    saveDish: (req, res)=>{
        let userId = req.idUser;
        var data = req.body;
        let newDish = new Dish();

        if(data.name && data.price && data.imagePath){
            newDish.name = data.name;
            newDish.price = data.price;
            newDish.imagePath = data.imagePath;
        
            User.findOne({_id: userId, type: "seller"}, (err, seller)=>{
    
                if(!seller) res.send("You are not a seller");
                if(seller)
                {
                    newDish.save((err, dishSaved)=>{
                        if(err) res.send(err);
                        if(dishSaved) res.send(dishSaved);
                    });
                }
            });
        }


    },

    deleteDish: (req, res)=>{
        let userId = req.idUser;
        let idDish = req.params.id;
        
        User.findOne({_id: userId, type: "seller"}, (err, seller)=>{

            if(!seller) res.send("You are not a seller");
            if(seller)
            {
                Dish.find({_id: idDish}).remove((err)=>{
                    if(err) res.send(err);
        
                    return res.send("Dish eliminated");
                });
            }
        });

    },

    updateDish: (req, res)=>{
        let userId = req.idUser;
        let idDish = req.params.id;
        let newData = req.body;

        User.findOne({_id: userId, type: "seller"}, (err, seller)=>{
            
            if(!seller) res.send("You are not a seller");
            if(seller)
            {
                Dish.findByIdAndUpdate({_id: idDish}, newData, { new: true }, (req, dishUpdated)=>{
                    if(err) res.send(err);
                    if(dishUpdated) res.send(dishUpdated);
                });
            }
        });

    },

    getDishes: (req, res)=>{
        let userId = req.idUser;

        if(userId)
        {
            Dish.find({}, (err, dishes)=>{
                if(err) res.send(err);
                if(!dishes) res.status(404).send("No se encontraron platos")
                if(dishes) res.send({'dishes': dishes});
            });
        }
        
    }

}

module.exports = DishController;