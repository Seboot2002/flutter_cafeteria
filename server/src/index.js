require("./database");
const app = require("./app");

app.listen(app.get("port"), (req, res)=>{
    console.log("Server en el puerto:", app.get("port"));
});