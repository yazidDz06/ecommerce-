function isAdmin(req, res, next) {
  

  if (req.user && req.user.role === "admin") {
    return next();
  }

  return res.status(403).json({ message: "Accès interdit : espace administrateur" });
}
module.exports = isAdmin;