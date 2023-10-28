import {onDocumentCreated} from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";
import * as serviceAccount from "./serviceAccountKey.json";
import {MessagingPayload} from "firebase-admin/lib/messaging/messaging-api";

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

    const payload:MessagingPayload = {
      notification: {
        title: "Appointment Confirmed",
        body: `Your appointment for ${appointment} has been confirmed!`,
        icon: "https://firebasestorage.googleapis.com/v0/b/glamourme-399217.appspot.com/o/files%2Fapp_icon.png?alt=media&token=c121a05b-58b7-4c4f-a564-9c73f40f03e1",
      },
    };

    const payloadSalon:MessagingPayload = {
      notification: {
        title: "New Appointment Placed",
        body: `New appointment placed for ${appointment}.`,
        icon: "https://firebasestorage.googleapis.com/v0/b/glamourme-399217.appspot.com/o/files%2Fapp_icon.png?alt=media&token=c121a05b-58b7-4c4f-a564-9c73f40f03e1",
      },
    };

    admin.messaging().sendToTopic("appointments", payload);
    admin.messaging().sendToTopic("appointmentPlaced", payloadSalon);
  }
);

export {appointmentConfirmed};
