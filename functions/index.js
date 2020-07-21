const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.myFunction = functions.firestore
  .document('Products/{product}')
  .onUpdate((change, context) => {
    const newValue = change.after.data();
    const offer = newValue.offType;
    if (offer == "Top Offer") {
      return admin.messaging().sendToTopic('user', {
        notification: {
          title: "New On Top Offer, Hurry to catch",
          body: newValue.title,
          clickAction: 'FLUTTER_NOTIFICATION_CLICK',
        },
      });
    }return null;
  });
