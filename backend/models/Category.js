module.exports = (sequelize, DataTypes) => {
  const Category = sequelize.define(
    "Category",
    {
      id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
      },
      name: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
      },
    },
    {
      timestamps: true,
    }
  );

  // 🔗 Définition des relations
  Category.associate = (models) => {
    Category.hasMany(models.Product, { foreignKey: "categoryId", as: "products" });
  };

  return Category;
};
