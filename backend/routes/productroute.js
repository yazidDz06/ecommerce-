const express = require("express");
const db = require("../models");
const Product = db.Product;
const Category = db.Category;

const router = express.Router();

// ➕ Créer un produit avec une catégorie principale
router.post("/", async (req, res) => {
  try {
    const { name, description, price, stock, imageUrl, categoryName } = req.body;

    const category = await Category.findOne({ where: { name: categoryName } });
    if (!category) return res.status(404).json({ error: "Category not found" });

    const product = await Product.create({
      name,
      description,
      price,
      stock,
      imageUrl,
      categoryId: category.id,
    });

    res.status(201).json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 📋 Lister tous les produits avec leur catégorie principale
router.get("/", async (req, res) => {
  try {
    const products = await Product.findAll({
      include: [{ model: Category, as: "category" }],
    });
  
    res.json( products );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { name, description, price, stock, imageUrl, categoryName } = req.body;

    const product = await Product.findByPk(id);
    if (!product) {
      return res.status(404).json({ error: "Produit non trouvé" });
    }

    // 🔥 si tu envoies categoryName, il faut d'abord retrouver la catégorie
    let category = null;
    if (categoryName) {
      category = await Category.findOne({ where: { name: categoryName } });
      if (!category) {
        return res.status(400).json({ error: "Catégorie non trouvée" });
      }
    }

    await product.update({
      name,
      description,
      price,
      stock,
      imageUrl,
      categoryId: category ? category.id : product.categoryId,
    });

    res.json({ message: "Produit mis à jour avec succès", product });
  } catch (err) {
    console.error(err);
     res.status(500).json({ error: "Erreur serveur" });
  }
});
//recuperer un produit via son id
router.get("/:id",async(req,res)=>{try{
  const product = await 
  Product.findByPk(req.params.id);
  if(!product){
    return
    res.status(404).json({message : "Produit introuvable"})
  }
  res.json(product);
}
catch(err){res.status(500).json({message : "erreur serveur",error :err.message});}
});

//  Supprimer un produit par ID
router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findByPk(id);
    if (!product) return res.status(404).json({ error: "Product not found" });

    await product.destroy();
    res.json({ message: "Product deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;



