const { firestore } = require("firebase-admin");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore, doc, collection, query, where, getDocs } = require("firebase-admin/firestore");
const { onDocumentCreated } = require("firebase-functions/v2/firestore");

initializeApp();

exports.checkAppointmentAvailability = onDocumentCreated('/appointments/{documentId}', async (event) => {
  // Get the newly created appointment document
  const appointment = event.data();

  // Define the time period for the appointment
  const startTime = appointment.startTime.toDate();
  const endTime = appointment.endTime.toDate();

  // Initialize Firestore
  const db = getFirestore();

  // Get a reference to the salon document
  const salonRef = collection('appointments').doc(appointment.salon);

  // Create a query to check for overlapping appointments in the same salon
  const appointmentQuery = query(collection(db, 'appointments'),
    where('salon', '==', salonRef),
    where('endTime', '>', firestore.Timestamp.fromDate(startTime)),
    where('startTime', '<', firestore.Timestamp.fromDate(endTime))
  );

  // Execute the query
  const querySnapshot = await getDocs(appointmentQuery);

  // Check if there are any overlapping appointments
  if (!querySnapshot.empty) {
    // There is an overlapping appointment, handle the conflict (e.g., reject the appointment)
    console.log('Appointment conflict: Another appointment exists in the same time slot.');
    return null; // You can return an error or take appropriate action here
  } else {
    // No overlapping appointments, the appointment is available
    console.log('Appointment is available.');
    return event.data.ref.delete({appointment}); // You can take further action here
  }
});
