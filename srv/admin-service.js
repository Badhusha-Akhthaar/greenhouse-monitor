const cds = require("@sap/cds");
const iotClientSDK = require('@aws-sdk/client-iot')

module.exports = async (srv) => {
	const db = await cds.connect.to("db");
	const { Greenhouse, Sensors } = srv.entities;
	console.log('Custom handler loaded');
	const awsIoTClient = new iotClientSDK.IoTClient({
		region: 'us-east-1',
		credentials: { accessKeyId: 'AKIAWESZ4I5YDD5IAWF7', secretAccessKey: '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' },
	})
	srv.on('activate', async (req) => {
		let greenhouseID = req.params[0]?.ID
		let sensorID = req.params[1]?.ID
		if (!sensorID || !greenhouseID)
			return

		let sensorData = await srv.read(Sensors, sensorID)
		console.log(sensorData)

		if (sensorData["certificate"] !== null || sensorData["private_key"] !== null)
			throw Error("Sensor is already activated")
		try {
			await createThing(sensorData["sensor_id"]);
			let certificateResponse = await createCertificate()
			let certificateARN = certificateResponse["certificateArn"]

			await attachCertificate2Thing(sensorData["sensor_id"],certificateARN)
			await attachCertificate2Policy("IoTDevicePolicy",certificateARN)
			await UPDATE(Greenhouse)
				.set({
					sensors: [{
						ID: sensorID,   // The OrderItem you want to update
						private_key: certificateResponse["keyPair"]["PrivateKey"],
						certificate: certificateResponse["certificatePem"]            // The new value
					}]
				})
				.where({
					ID: greenhouseID        // The root Order ID
				});

			req.info({ message: "Successfully activated the sensor", status: 200 })

		} catch (error) {
			req.error({
				code: 'ACTIVATION_FAILED',
				message: `Failed to activate the sensor ${JSON.stringify(error)}`,
				target: 'some_field',
				status: 500
			})

		}


	})
	srv.after([CREATE, UPDATE], Greenhouse, async (data, req) => {
		console.log(JSON.stringify(data))
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
				let input = { thingName: sensorId, principal: certificateARN }
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
				let input = { policyName, target: certificateARN }
				let command = new iotClientSDK.AttachPolicyCommand(input)
				let response = await awsIoTClient.send(command)
				resolve(response)
			} catch (error) {
				reject(error)
			}

		});
	}
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