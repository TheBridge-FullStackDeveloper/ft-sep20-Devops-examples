const express = require("express");
const fetch = require("node-fetch");
const cors = require("cors");

const server = express();
server.use(cors());

const PORT = process.env.PORT || 8080

server.get("/", (req, res) => {
	fetch("https://randomuser.me/api?results=5").then(res => res.json()).then(d => {
		res.send(d);
	})
	.catch(e => res.send({error: e.message}));
})

server.listen(PORT, () => console.log("Escuchando en el puerto", PORT));