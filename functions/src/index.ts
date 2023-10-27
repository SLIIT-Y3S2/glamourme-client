import {onDocumentCreated} from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";
import * as serviceAccount from "./serviceAccountKey.json";
import {MessagingPayload} from "firebase-admin/lib/messaging/messaging-api";
import {Timestamp} from "firebase-admin/firestore";

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

const appointmentPlaced = onDocumentCreated(
  "appointments/{docId}",
  (event) => {
    const snapshot = event.data;
    if (!snapshot) {
      console.log("No data associated with the event");
      return;
    }
    const data = snapshot.data();

    const appointment = data.title;
    const startTime = (data.startTime as Timestamp)
      .toDate()
      .toLocaleTimeString();

    const payload:MessagingPayload = {
      notification: {
        title: "Appointment Place",
        body: `New appointment placed for ${appointment} 
        on ${startTime}`,
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    };

    admin.messaging().sendToTopic("appointmentPlaced", payload);
  }
);

export {appointmentConfirmed, appointmentPlaced};
