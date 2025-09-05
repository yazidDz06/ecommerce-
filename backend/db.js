require("dotenv").config();
const { Sequelize } = require("sequelize");

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASS,
  {
    host: process.env.DB_HOST,
    dialect: "mysql",
  }
);


(async () => {
  try {
 
    await sequelize.sync({ alter: true });   //sync permet la creation auto
    console.log('Connexion à PostgreSQL réussie !');
  } catch (error) {
    console.error('Impossible de se connecter à la base :', error);
  }
})();

module.exports = sequelize;
