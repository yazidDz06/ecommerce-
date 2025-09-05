const express = require('express');
const cookieParser = require("cookie-parser");
const app = express();
const cors = require('cors');
require("dotenv").config();
const PORT = 5000;
const { sequelize } = require('./models'); 
const authRoutes = require('./routes/userident');
const productRoutes = require("./routes/productroute");
const categRoutes = require("./routes/categoryroute");
 
app.use(cors({
  origin: 'http://localhost:3000', // autorise seulement ton frontend
  credentials: true,               // si tu envoies des cookies
}));

// Middleware pour lire le JSON
app.use(express.json());
app.use(cookieParser());
app.use('/api', authRoutes);
app.use('/api/products', productRoutes);
app.use('/api/categories',categRoutes);
console.log("SECRET:", process.env.JWT_SECRET);
// Route test
app.get('/', (req, res) => {
  res.send('Hello Express + Sequelize + PostgreSQL !');
});
// Synchronisation Sequelize + lancement serveur
sequelize.sync({ alter: true }) 
  .then(() => {
    console.log("✅ Base de données synchronisée avec les modèles");
    app.listen(PORT, () => {
      console.log(`✅ Serveur démarré sur http://localhost:${PORT}`);
    });
  })
  .catch((err) => {
    console.error("❌ Erreur de synchronisation :", err);
  });
