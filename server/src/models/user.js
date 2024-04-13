const { Schema, model } = require("mongoose");

const UserSchema = new Schema({
    name: String,
    email: String,
    password: String,
    code_uni: String,
    type: { type: String, enum: ['customer', 'seller']},
    getToken: Boolean
});

module.exports = model("User", UserSchema);