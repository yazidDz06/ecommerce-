module.exports = (sequelize, DataTypes) => {
  const Product = sequelize.define("Product", {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    price: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
    },
    stock: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
    imageUrl: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    isActive: {
      type: DataTypes.BOOLEAN,
      defaultValue: true,
    },
  }, {
    timestamps: true,
  });

  // Relations
  Product.associate = (models) => {
    Product.belongsTo(models.Category, { foreignKey: "categoryId", as: "category" });
    Product.hasMany(models.CartItem, {foreignKey:"productId", as: "cartItems"});
    Product.hasMany(models.OrderItem, { foreignKey: "productId", as: "orderItems" });
  };

  return Product;
};

