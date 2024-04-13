const mongoose = require("mongoose");

mongoose.set("strictQuery", false);
mongoose.connect("mongodb://127.0.0.1:27017/cafeteria")
.then(db => console.log("Base de datos conectada"))
.catch(err => console.log(err));