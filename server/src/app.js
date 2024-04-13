const express = require("express");
const morgan = require("morgan");
const path = require("path");

const userRoutes = require("./routes/user.routes");
const dishRoutes = require("./routes/dish.routes");
const orderRoutes = require("./routes/order.routes");

const app = express();

app.set("port", 3700);

app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use(express.static(path.resolve("public")));

app.use(userRoutes);
app.use(dishRoutes);
app.use(orderRoutes);

module.exports = app;