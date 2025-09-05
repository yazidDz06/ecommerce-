const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const db = require("../models"); // index.js
const User = db.User; // ton modèle Sequelize
const jwt = require("jsonwebtoken");
const authMiddleware = require("../middlewares/authmw"); 

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


   const token = jwt.sign(
 { id: user.id, username: user.username, role: user.role }, 
  process.env.JWT_SECRET, 
  { expiresIn: "10m" }
);
res.cookie("jwt", token, {
  httpOnly: true,
  secure: false, // mettre true si https
  sameSite: "lax"
});

    res.json({ message: "Connexion réussie", user });
}catch (error) {
    res.status(500).json({ error: error.message });
  }
});
router.get("/me", authMiddleware, async (req, res) => {
  try {
    const user = await User.findByPk(req.user.id, {
      attributes: ["id", "username", "email"] 
    });

    if (!user) {
      return res.status(404).json({ message: "Utilisateur introuvable" });
    }

    res.json(user); // renvoie { id, username, email }
  } catch (error) {
    console.error("Erreur /me:", error);
    res.status(500).json({ message: "Erreur serveur" });
  }
});
router.post("/logout", (req, res) => {
  res.cookie("jwt", "", { maxAge: 0, path: "/" });
  res.json({ message: "Déconnecté" });
});

module.exports = router;

