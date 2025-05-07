const cds = require("@sap/cds");
const iotClientSDK = require('@aws-sdk/client-iot')

module.exports = cds.service.impl(async (srv) => {
	const db = await cds.connect.to("db");
	const { Greenhouse, Sensors } = srv.entities;

	const awsIoTClient = new iotClientSDK.IoTClient({
		region: 'us-east-1',
		credentials: { accessKeyId: 'AKIAWESZ4I5YDD5IAWF7', secretAccessKey: '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' },
	})

	async function createThing(sensorId) {
		return new Promise(async (resolve, reject) => {

			try {
				let input = { thingName: sensorId }
				let command = new iotClientSDK.CreateThingCommand(input)
				let response = await awsIoTClient.send(command)
				resolve(response)
			} catch (error) {
				reject(error)
			}

		});
	}
	function createCertificate() {
		return new Promise(async (resolve, reject) => {

			try {
				let input = { setAsActive: true }
				let command = new iotClientSDK.CreateKeysAndCertificateCommand(input)
				let response = await awsIoTClient.send(command)
				resolve(response)
			} catch (error) {
				reject(error)
			}

		});
	}
	function attachCertificate2Thing(sensorId, certificateARN) {
		return new Promise(async (resolve, reject) => {

			try {
				let input = { thingName: sensorId,principal: certificateARN }
				let command = new iotClientSDK.AttachThingPrincipalCommand(input)
				let response = await awsIoTClient.send(command)
				resolve(response)
			} catch (error) {
				reject(error)
			}

		});
	}
	function attachCertificate2Policy(policyName, certificateARN) {
		return new Promise(async (resolve, reject) => {

			try {
				let input = { policyName,target: certificateARN }
				let command = new iotClientSDK.AttachPolicyCommand(input)
				let response = await awsIoTClient.send(command)
				resolve(response)
			} catch (error) {
				reject(error)
			}

		});
	}


	srv.after('CREATE', Sensors.drafts, async (data,req) => {
		console.log(data)
		console.log(req)
	})
});