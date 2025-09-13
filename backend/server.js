const express = require('express');
const cors = require('cors');
const cookieParser = require("cookie-parser");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 5000;
const { sequelize } = require('./models'); 

// ✅ Config CORS flexible
const allowedOrigins = [
  "https://ecomyazid.vercel.app",   // domaine principal
  "http://localhost:3000"           // dev local
];

app.use(cors({
  origin: function (origin, callback) {
    if (!origin) return callback(null, true); // ex: Postman
    if (allowedOrigins.includes(origin) || origin.endsWith(".vercel.app")) {
      callback(null, true);
    } else {
      callback(new Error("Not allowed by CORS: " + origin));
    }
  },
  credentials: true
}));

// ✅ Middleware globaux
app.use(express.json());
app.use(cookieParser());

// ✅ Routes
const authRoutes = require('./routes/userident');
const productRoutes = require("./routes/productroute");
const categRoutes = require("./routes/categoryroute");
const cartRoutes = require("./routes/cartRoute");
const orderRoutes = require("./routes/orderRoute");
const routeDashboard = require("./routes/routeDashboard");

app.use('/api', authRoutes);
app.use('/api/products', productRoutes);
app.use('/api/categories', categRoutes);
app.use('/api/cart', cartRoutes);
app.use('/api/orders', orderRoutes);
app.use('/api/dashboard', routeDashboard);

// ✅ Test route
app.get('/', (req, res) => {
  res.send('Hello Express + Sequelize + PostgreSQL !');
});

// 
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
