const { Schema, model } = require("mongoose");

const DishSchema = new Schema({
    name: String,
    price: Number,
    imagePath: String,
});

module.exports = model("Dish", DishSchema);