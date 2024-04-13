const express = require("express");
const router = express.Router();

const UserController = require("../controllers/user.controller");
const verifyToken = require("../controllers/verifyToken");

router.get("/getCustomers", verifyToken, UserController.getCustomers);

router.get("/getSellers", verifyToken, UserController.getSellers);

router.post("/register", UserController.saveUser);

router.post("/login", UserController.loginUser);

module.exports = router;