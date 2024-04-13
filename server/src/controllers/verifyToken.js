const jwt = require("jsonwebtoken");

function verifyToken(req, res, next){

    const token = req.headers['authorization'];

    if(!token) res.send("No existe un token");

    const decodificado = jwt.verify(token, "TextoSecreto");

    req.idUser = decodificado.id;

    next();
}

module.exports = verifyToken;