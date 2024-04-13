const User = require("../models/user");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const UserController = {

    saveUser: (req, res)=>{
        const data = req.body;
        const newUser = new User();

        if(data.name && data.email && data.password && data.code_uni && data.type){
            newUser.name = data.name;
            newUser.email = data.email;
            newUser.code_uni = data.code_uni;
            newUser.type = data.type;

            User.find({ $or: [{email: newUser.email.toLowerCase()}, {code_uni: newUser.code_uni.toLowerCase()}]}).exec((err, users)=>{

                if(users && users.length >= 1){
                    return res.send("Este usuario ya existe");
                }
                else
                {
                    jwt.sign({id: newUser.id}, "TextoSecreto", {
                        expiresIn: 60 * 60 * 24
                    });

                    bcrypt.hash(data.password, 8, (err, hash)=>{
                        if(err) return res.send(err);

                        if(hash){
                            newUser.password = hash;

                            newUser.save((err, UserSaved)=>{
                                if(err) return res.send(err);
                                if(res) return res.send(UserSaved);
                            });
                        }
                    });
                }
            });
        }

    },

    loginUser: (req, res)=>{
        const data = req.body;
        const dataEmail = data.email;
        const dataPassword = data.password;

        User.findOne({ email: dataEmail }, (err, user)=>{
            if(err) res.send("Error");
            if(!user) res.status(404).send("No se encontro al usuario");

            if(user){
                bcrypt.compare(dataPassword, user.password, (err, checkUser)=>{

                    if(checkUser){

                        if(data.getToken)
                        {
                            const token = jwt.sign({id: user.id}, "TextoSecreto", {
                                expiresIn: 60 * 60 * 24
                            });
    
                            res.send({token: token});
                        }
                        else
                        {
                            res.send(user);
                        }
                    }
                    else
                    {
                        res.send(err);
                    }
                })
            }
        });
    },

    getSellers: (req, res)=>{
        let userId = req.idUser;

        User.findOne({_id: userId, type: "customer"}, (err, customer)=>{
            if(err) res.send("Error");

            if(!customer) res.send("You are not a customer");
            if(customer)
            {
                User.find({type: "seller"}, (err, sellers)=>{
        
                    if(err) res.send(err);
        
                    res.send(sellers);
                });
            }
        })
    },

    getCustomers: (req, res)=>{
        let userId = req.idUser;

        User.findOne({_id: userId, type: "customer"}, (err, seller)=>{
            if(seller) res.send("Error");

            if(!seller) res.send("You are not a customer");
            if(seller)
            {
                User.find({type: "customer"}, (err, customers)=>{
        
                    if(err) res.send(err);
                    
                    res.send(customers);
                });
            }
        });

    }

}

module.exports = UserController;