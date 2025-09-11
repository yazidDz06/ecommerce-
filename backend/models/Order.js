
module.exports = (sequelize, DataTypes) => {
  const Order = sequelize.define("Order", {
        id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
     city: {
      type: DataTypes.STRING,
      allowNull: false,
       validate: {
    notEmpty: true, // empêche aussi les chaînes vides
  },  // car obligatoire
    },
    street: {
      type: DataTypes.STRING,
      allowNull: false,
       validate: {
    notEmpty: true, // empêche aussi les chaînes vides
  },
    },
    statutCom : {
   type : DataTypes.ENUM("pending", "shipped", "completed", "cancelled"),
   defaultValue: "pending",
    },
      total: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,

    },

  });

  // Relations
  Order.associate = (models) => {
   Order.belongsTo(models.User , { foreignKey: "userId", as: "user" });
   Order.hasMany(models.OrderItem, {foreignKey :"orderId",as:"items"});
  };

  return Order;
};
