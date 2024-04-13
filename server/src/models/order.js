const { Schema, model } = require("mongoose");

const OrderSchema = new Schema({
    state: String,
    price: Number,
    customer: { type: Schema.ObjectId, ref: "customer"},
    dish: { type: Schema.ObjectId, ref: "dish"},
    seller: { type: Schema.ObjectId, ref: "seller"}
});

module.exports = model("Order", OrderSchema);