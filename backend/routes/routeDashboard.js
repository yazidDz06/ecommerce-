const db = require("../models");
const User = db.User;
const Product = db.Product;
const Order = db.Order;
const Categories = db.Category;
const express = require('express');
const router = express.Router();
const authMiddleware = require("../middlewares/authmw"); 
const isAdmin = require("../middlewares/isAdmin");

router.get("/", authMiddleware, isAdmin, async (req, res) => {
  try {
    const totalUsers = await User.count();
    const totalProducts = await Product.count();
    const totalOrders = await Order.count();
    const totalCategories = await Categories.count();
    res.status(200).json({ totalUsers, totalProducts, totalOrders, totalCategories });
  } catch (error) {
    res.status(500).json({ message: "Erreur serveur", error: error.message });
  }
});
module.exports = router;