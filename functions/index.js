const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.addAppointment = functions.https.onRequest(async (request, response) => {
  const db = admin.firestore();

  // Parse the new appointment data from the request body
  const newAppointment = request.body;

  if (!newAppointment) {
    response.status(400).json({ error: 'Appointment data is missing in the request body' });
    return;
  }

  const overlappingQuerySnapshot = await db.collection('appointments')
    .where('salon', '==', newAppointment.salon)
    .where('service', '==', newAppointment.service)
    .where('status', '==', 'confirmed')
    .where('startTime', '<', newAppointment.endTime)
    .where('endTime', '>', newAppointment.startTime)
    .get();

  if (overlappingQuerySnapshot.empty) {
    // No overlapping appointments found, add the new appointment
    const appointmentRef = await db.collection('appointments').add(newAppointment);
    response.status(200).json({ message: 'New appointment added', id: appointmentRef.id });
  } else {
    // Overlapping appointments found, handle accordingly
    response.status(400).json({ error: 'Appointment overlaps with existing appointments' });
  }
});
