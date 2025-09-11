const bcrypt = require("bcrypt");

(async () => {
  const password = "yazidadmin"; // le mot de passe en clair que tu veux donner
  const saltRounds = 10;       // coût de hachage
  const hashed = await bcrypt.hash(password, saltRounds);

  console.log("Mot de passe en clair :", password);
  console.log("Mot de passe haché :", hashed);
})();
