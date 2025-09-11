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
const cartRoutes = require("./routes/cartRoute");
const orderRoutes = require("./routes/orderRoute");
const routeDashboard = require("./routes/routeDashboard");
 
app.use(cors({
  origin: 'http://localhost:3000', // autorise seulement ton frontend
  credentials: true,               // si tu envoies des cookies
}));

// Middleware pour lire le JSO
app.use(express.json());
app.use(cookieParser());
app.use('/api', authRoutes);
app.use('/api/products', productRoutes);
app.use('/api/categories',categRoutes);
app.use('/api/cart',cartRoutes);
app.use('/api/orders',orderRoutes);
app.use('/api/dashboard', routeDashboard);

app.get('/', (req, res) => {
  res.send('Hello Express + Sequelize + PostgreSQL !');
});

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
