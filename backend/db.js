require("dotenv").config();
const { Sequelize } = require("sequelize");

const sequelize = new Sequelize(process.env.DATABASE_URL, {
  dialect: "postgres",
  protocol: "postgres",
  dialectOptions: {
    ssl: { rejectUnauthorized: false }, // nécessaire si Render exige SSL
  },
});

(async () => {
  try {
 
    await sequelize.sync({ alter: true });   //sync permet la creation auto
    console.log('Connexion à PostgreSQL réussie !');
  } catch (error) {
    console.error('Impossible de se connecter à la base :', error);
  }
})();

module.exports = sequelize;
