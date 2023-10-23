import {onDocumentCreated} from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";
import * as serviceAccount from "./serviceAccountKey.json";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

const appointmentConfirmed = onDocumentCreated(
  "appointments/{docId}",
  (event) => {
    const snapshot = event.data;
    if (!snapshot) {
      console.log("No data associated with the event");
      return;
    }
    const data = snapshot.data();

    const appointment = data.title;

    const payload = {
      notification: {
        title: "Appointment Confirmed",
        body: `Your appointment for ${appointment} has been confirmed!`,
      },
    };

    admin.messaging().sendToTopic("appointments", payload);
  }
);

export {appointmentConfirmed};
