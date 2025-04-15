const cds = require("@sap/cds");
const SequenceHelper = require("./lib/sequence-helper");

module.exports = cds.service.impl(async (service) => {
	const db = await cds.connect.to("db");
	const { Greenhouse } = service.entities;

	service.before("CREATE", Greenhouse, async (context) => {
		// const productId = new SequenceHelper({
		// 	db: db,
		// 	sequence: "GREENHOUSE_ID",
		// 	table: "Greenhouse",
		// 	field: "GREENHOUSE_ID"
		// });
        // console.log(context)
		// context.data.greenhouse_id = await productId.getNextNumber();
	});
});