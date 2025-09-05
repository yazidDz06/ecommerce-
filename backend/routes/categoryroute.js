const express = require("express");
const db = require("../models");
const Category = db.Category;

const router = express.Router();

// ➕ Ajouter une catégorie (uniquement principale)
router.post("/", async (req, res) => {
  try {
    const { name } = req.body;
    const category = await Category.create({ name });
    res.status(201).json(category);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 📋 Lister toutes les catégories principales
router.get("/", async (req, res) => {
  try {
    const categories = await Category.findAll();
    // ✅ renvoyer un objet avec la clé "categories"
    res.json( categories );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// ❌ Supprimer une catégorie
router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const category = await Category.findByPk(id);
    if (!category) return res.status(404).json({ error: "Category not found" });

    await category.destroy();
    res.json({ message: "Category deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;



