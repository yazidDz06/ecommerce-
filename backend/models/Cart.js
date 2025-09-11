module.exports = (sequelize, DataTypes) => {
  const Cart = sequelize.define("Cart", {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    }, 
  }, {
    timestamps: true,
  });
  //definition de la relation
  Cart.associate =(models)=>{
  Cart.belongsTo(models.User, { foreignKey: "userId", as: "user" });
  Cart.hasMany(models.CartItem,{foreignKey:"cartId",as :"items"});
  }

  return Cart;
};

