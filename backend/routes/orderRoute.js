const express = require("express");
const db = require("../models");
const router = express.Router();
const authMiddleware = require('../middlewares/authmw');
const isAdmin = require("../middlewares/isAdmin");
const Cart = db.Cart;
const CartItem = db.CartItem;
const Product = db.Product; 
const Order = db.Order;
const OrderItem = db.OrderItem;
const User = db.User;


router.post("/",authMiddleware,async (req,res)=>{
    try{
     const userId = req.user.id;
     
          
     const cart = await Cart.findOne({
     where: { userId  },
     include: [
        {
          model: CartItem,
          as: "items",
          include: [{ model: Product, as: "product" }]
        }
      ]
      });
     if(!cart || !cart.items || cart.items.length === 0){
       return res.status(404).json("l'utilisateur n'a pas de panier encore");
     }
    const order = await Order.create({
      userId,
      city:req.body.city,
      street:req.body.street,
      statut: req.body.statut,
      total: req.body.total
    });
  console.log(cart.items)
     for (const item of cart.items) {
      await db.OrderItem.create({
        orderId: order.id,
        productId: item.productId,
        quantity: item.quantity,
        price: item.product.price
      });
    }
    await CartItem.destroy({ where: { cartId: cart.id } });

    res.status(201).json({ message: "Commande créée", order });

    }catch(error){
  console.error(error);
    res.status(500).json("Erreur serveur");
    }
})
router.get("/",authMiddleware,async (req,res)=>{
try {
    const userId = req.user.id;
    
    if (!userId) {
        return res.status(404).json("utilisateur introuvable");
    }
    
    const orders = await Order.findAll({
        where: {
            userId , 
        },
       include: [{ model: OrderItem, as: "items" ,
        include:[{
        model: Product ,as :"product"}]
     }],
    })
    if(!orders || orders.length === 0){
       return res.status(200).json("pas de commande!");
    }
      console.log(orders);
      return res.status(200).json(orders);

} catch (error) {
    return res.status(400).json("erreur serveur");
}
  
})
router.get("/allorders", authMiddleware, isAdmin, async (req, res) => {
  try {
    const orders = await Order.findAll({
      include: [
        {
          model: OrderItem,
          as: "items",
          include: [
            { model: Product, as: "product" }
          ]
        },
        {
          model: User,
          as: "user", 
          attributes: ["id", "username", "email"]
        }
      ]
    });

    if (!orders || orders.length === 0) {
      return res.status(200).json({ message: "Aucune commande trouvée" });
    }

    return res.status(200).json(orders);
  } catch (error) {
    console.error("Erreur GET /orders/allorders (admin):", error);
    return res
      .status(500)
      .json({ message: "Erreur serveur", error: error.message });
  }
});

module.exports = router;