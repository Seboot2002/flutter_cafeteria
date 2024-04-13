const express = require("express");
const router = express.Router();

const OrderController = require("../controllers/order.controller");
const verifyToken = require("../controllers/verifyToken");

router.get("/getOrdersCustomer", verifyToken, OrderController.getOrdersCustomer);

router.get("/getOrdersSeller", verifyToken, OrderController.getOrdersSeller);

router.post("/saveOrder/:sellerId/:dishId", verifyToken, OrderController.saveOrder);

router.delete("/deleteOrder/:id", verifyToken, OrderController.deleteOrder);

router.put("/updateOrder/:id", verifyToken, OrderController.updateOrder);

module.exports = router;