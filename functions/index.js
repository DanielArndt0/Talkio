const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

exports.sendNotificationOnMessage = onDocumentCreated(
  {
    region: "southamerica-east1",
    document: "chats/{chatId}/messages/{messageId}",
  },
  async (event) => {
    const message = event.data?.data();
    if (!message) return;

    const senderId = message.userId;
    const senderDoc = await db.collection("users").doc(senderId).get();
    const senderName = senderDoc.data()?.name || "Someone";

    const chatId = event.params.chatId;
    const chatSnap = await db.collection("chats").doc(chatId).get();
    const users = chatSnap.data()?.users;
    if (!users || users.length !== 2) return;

    const recipientId = users.find((uid) => uid !== senderId);
    const recipientDoc = await db.collection("users").doc(recipientId).get();
    const tokens = recipientDoc.data()?.tokensFCM || [];

    if (!Array.isArray(tokens) || tokens.length === 0) return;

    const response = await messaging.sendEachForMulticast({
      tokens,
      notification: {
        title: `${senderName}`,
        body: message.text,
      },
    });

    const invalidTokens = [];
    response.responses.forEach((res, index) => {
      const error = res.error;
      if (
        error &&
        (error.code === "messaging/invalid-registration-token" ||
          error.code === "messaging/registration-token-not-registered")
      ) {
        invalidTokens.push(tokens[index]);
      }
    });

    if (invalidTokens.length > 0) {
      await db
        .collection("users")
        .doc(recipientId)
        .update({
          tokensFCM: admin.firestore.FieldValue.arrayRemove(...invalidTokens),
        });
    }
  }
);
