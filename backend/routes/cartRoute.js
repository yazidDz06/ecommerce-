const express = require('express');
const db = require('../models');
const authMiddleware = require('../middlewares/authmw');

const Cart = db.Cart;
const Product = db.Product;
const CartItem = db.CartItem;

const router = express.Router();


// ✅ 1. Récupérer le panier de l'utilisateur
router.get('/', authMiddleware, async (req, res) => {
  try {
    const userId = req.user.id;

    const cart = await Cart.findOne({
      where: { userId },
      include: [
        {
          model: CartItem,
          as: "items",
          include: [{ model: Product, as: "product" }]
        }
      ]
    });

    if (!cart || !cart.items || cart.items.length === 0) {
      return res.status(200).json({ message: "Panier vide" });
    }

    return res.status(200).json(cart);

  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Erreur serveur" });
  }
});


// ✅ 2. Ajouter un produit au panier
router.post('/add', authMiddleware, async (req, res) => {
  try {
    const userId = req.user.id;
    const { product, quantity } = req.body;

    // Vérifier que product est un objet et récupérer son id
    if (!product || !product.id) {
      return res.status(400).json({ message: "product.id manquant" });
    }
    const productId = product.id;

    // Vérifier que le produit existe
    const dbProduct = await Product.findByPk(productId);
    if (!dbProduct) {
      return res.status(404).json({ message: "Produit introuvable" });
    }

    // Vérifier si l'utilisateur a déjà un panier
    let cart = await Cart.findOne({ where: { userId } });
    if (!cart) cart = await Cart.create({ userId });

    // Vérifier si le produit est déjà dans le panier
    let item = await CartItem.findOne({ where: { cartId: cart.id, productId } });

    if (item) {
      item.quantity += quantity;
      await item.save();
    } else {
      item = await CartItem.create({ cartId: cart.id, productId, quantity });
    }

    return res.status(201).json({ message: "Produit ajouté au panier", item });

  } catch (err) {
    console.error("Erreur addToCart:", err);
    return res.status(500).json({ error: err.message });
  }
});



// ✅ 3. Modifier la quantité d’un produit
router.put('/:id', authMiddleware, async (req, res) => {
  try {
    const userId = req.user.id;
    const productId = req.params.id;
    const { quantity } = req.body;

    const cart = await Cart.findOne({ where: { userId } });
    if (!cart) return res.status(404).json({ message: "Panier introuvable" });

    const item = await CartItem.findOne({ where: { cartId: cart.id, productId } });
    if (!item) return res.status(404).json({ message: "Produit non trouvé dans le panier" });

    if (quantity > 0) {
      item.quantity = quantity;
      await item.save();
    } else {
      await item.destroy();
    }

    return res.status(200).json({ message: "Panier mis à jour" });

  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Erreur serveur" });
  }
});


// ✅ 4. Supprimer un produit du panier
router.delete('/:id', authMiddleware, async (req, res) => {
  try {
    const userId = req.user.id;
    const productId = req.params.id;

    const cart = await Cart.findOne({ where: { userId } });
    if (!cart) return res.status(404).json({ message: "Panier introuvable" });

    const item = await CartItem.findOne({ where: { cartId: cart.id, productId } });
    if (!item) return res.status(404).json({ message: "Produit non trouvé dans le panier" });

    await item.destroy();

    return res.status(200).json({ message: "Produit supprimé du panier" });

  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Erreur serveur" });
  }
});


// ✅ 5. Vider complètement le panier
router.delete('/', authMiddleware, async (req, res) => {
  try {
    const userId = req.user.id;

    const cart = await Cart.findOne({ where: { userId } });
    if (!cart) return res.status(404).json({ message: "Panier introuvable" });

    await CartItem.destroy({ where: { cartId: cart.id } });

    return res.status(200).json({ message: "Panier vidé" });

  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Erreur serveur" });
  }
});


module.exports = router;


