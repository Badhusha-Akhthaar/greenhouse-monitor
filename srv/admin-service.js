const cds = require("@sap/cds");

module.exports = cds.service.impl(async (service) => {
	const db = await cds.connect.to("db");
	const { Greenhouse } = service.entities;;
});