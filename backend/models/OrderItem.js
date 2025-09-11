
module.exports = (sequelize, DataTypes) => {
  const OrderItem = sequelize.define("OrderItem", {
        id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
     productName: DataTypes.STRING,
    productPrice: DataTypes.FLOAT,
    quantity: DataTypes.INTEGER,

  });

  // Relations
   OrderItem.associate = (models) => {
   OrderItem.belongsTo(models.Order , { foreignKey: "orderId", as: "order" });
    OrderItem.belongsTo(models.Product, { foreignKey: "productId", as: "product" }); 
  };

  return OrderItem;
};
