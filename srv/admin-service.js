const cds = require("@sap/cds");
const iotClientSDK = require('@aws-sdk/client-iot')

module.exports = async (srv) => {
	const db = await cds.connect.to("db");
	const { Greenhouse, Sensors } = srv.entities;
	console.log('Custom handler loaded');

	
	// async function createThing(sensorId) {
	// 	return new Promise(async (resolve, reject) => {

	// 		try {
	// 			let input = { thingName: sensorId }
	// 			let command = new iotClientSDK.CreateThingCommand(input)
	// 			let response = await awsIoTClient.send(command)
	// 			resolve(response)
	// 		} catch (error) {
	// 			reject(error)
	// 		}

	// 	});
	// }
	// function createCertificate() {
	// 	return new Promise(async (resolve, reject) => {

	// 		try {
	// 			let input = { setAsActive: true }
	// 			let command = new iotClientSDK.CreateKeysAndCertificateCommand(input)
	// 			let response = await awsIoTClient.send(command)
	// 			resolve(response)
	// 		} catch (error) {
	// 			reject(error)
	// 		}

	// 	});
	// }
	// function attachCertificate2Thing(sensorId, certificateARN) {
	// 	return new Promise(async (resolve, reject) => {

	// 		try {
	// 			let input = { thingName: sensorId,principal: certificateARN }
	// 			let command = new iotClientSDK.AttachThingPrincipalCommand(input)
	// 			let response = await awsIoTClient.send(command)
	// 			resolve(response)
	// 		} catch (error) {
	// 			reject(error)
	// 		}

	// 	});
	// }
	// function attachCertificate2Policy(policyName, certificateARN) {
	// 	return new Promise(async (resolve, reject) => {

	// 		try {
	// 			let input = { policyName,target: certificateARN }
	// 			let command = new iotClientSDK.AttachPolicyCommand(input)
	// 			let response = await awsIoTClient.send(command)
	// 			resolve(response)
	// 		} catch (error) {
	// 			reject(error)
	// 		}

	// 	});
	// }


	// srv.after('UPDATE', ['Sensors.drafts','Sensors'], async (data,req) => {
	// 	console.log("$$$$$$$$$$$$$$$$")
	// 	console.log(data)
	// 	console.log(req)
	// })
}

// 	async init() {
// 		const db = await cds.connect.to("db");
// 		const { Greenhouse, Sensors } = this.entities;
// 		console.log("Handler Loaded")

// 		this.after([CREATE,UPDATE],'*',async (req)=>{
// 			console.log('******************************************************************************')
// 			console.log(JSON.stringify(req.data))
// 		})
// 		await super.init();
// 	}
// }

// module.exports = GreenhouseService