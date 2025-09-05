module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define("User", {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    username: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
      role: { 
    type: DataTypes.STRING, 
    allowNull: false, 
    defaultValue: "client" // par défaut tous sont clients
  },
  }, {
    timestamps: true,
  });

  return User;
};

