const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const db = require("../models"); // index.js
const User = db.User; // ton modèle Sequelize
const jwt = require("jsonwebtoken");
const authMiddleware = require("../middlewares/authmw"); 
const isAdmin = require("../middlewares/isAdmin");

const SALT_ROUNDS = 10;

// Route Register
router.post('/register', async (req, res) => {
  const { username, email, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);
    const user = await User.create({ username, email, password: hashedPassword });
    res.status(201).json({ message: 'Utilisateur créé !', user });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Route Login
router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ where: { email } });
    if (!user) return res.status(404).json({ error: 'Utilisateur non trouvé' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(401).json({ error: 'Mot de passe incorrect' });
  
    // Générer un token JWT

   const token = jwt.sign(
 { id: user.id, username: user.username, role: user.role }, 
  process.env.JWT_SECRET, 
  { expiresIn: "1d" }
);
res.cookie("jwt", token, { httpOnly: true, sameSite: "strict" });

    res.json({ message: "Connexion réussie", user });
}catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Route pour obtenir les infos de l'utilisateur connecté
router.get("/me", authMiddleware, async (req, res) => {
  try {
    const user = await User.findByPk(req.user.id, { attributes: { exclude: ["password"] } });
    res.json(user);
  } catch (err) {
    res.status(500).json({ message: "Erreur serveur" });
  }
});
router.post('/logout', (req, res) => {
  res.cookie('jwt', '', {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'lax',
    expires: new Date(0) // expire immédiatement
  });
  res.status(200).json({ message: 'Déconnecté' });
});

// Route pour obtenir tous les utilisateurs (admin seulement)
router.get("/", authMiddleware, isAdmin, async (req, res) => {
  try {
    const users = await User.findAll({
      attributes: { exclude: ["password", "role"] },
    });

    if (!users || users.length === 0) {
      return res.status(404).json({ message: "Aucun utilisateur trouvé" });
    }

    return res.status(200).json(users);
  } catch (error) {
    console.error("Erreur GET /users:", error);
    return res.status(500).json({ message: "Erreur serveur", error: error.message });
  }
});




module.exports = router;

