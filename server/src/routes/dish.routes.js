const express = require("express");
const router = express.Router();

const DishController = require("../controllers/dish.controller");
const verifyToken = require("../controllers/verifyToken");

router.get("/getDishes", verifyToken, DishController.getDishes)

router.post("/saveDish", verifyToken, DishController.saveDish);

router.delete("/deleteDish/:id", verifyToken, DishController.deleteDish);

router.put("/updateDish/:id", verifyToken, DishController.updateDish);

module.exports = router;