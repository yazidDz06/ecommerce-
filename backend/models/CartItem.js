module.exports = (sequelize, DataTypes) => {
  const CartItem = sequelize.define("CartItem", {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    }, 
    quantity : {
        type :DataTypes.INTEGER,
        allowNull :false,
        validate:{
            min: 1
        }
    }
  }, {
    timestamps: true,
  });
  //definition des relation
  CartItem.associate =(models)=>{
  CartItem.belongsTo(models.Cart, { foreignKey: "cartId", as: "cart" });
  CartItem.belongsTo(models.Product,{foreignKey :"productId", as: "product" } )
  }

  return CartItem;
};