import Push from 'pushover-notifications';

export async function sendOrderNotification(orderDetails: {
  orderId: number;
  mainItem?: string;
  mainQuantity?: number;
  dessertItem?: string;
  dessertQuantity?: number;
  pickupDate: string;
  totalPrice: number;
}) {
  if (!process.env.PUSHOVER_USER_KEY || !process.env.PUSHOVER_API_TOKEN) {
    console.log('Push notifications not configured - skipping');
    return;
  }

  const { orderId, mainItem, mainQuantity, dessertItem, dessertQuantity, pickupDate, totalPrice } = orderDetails;
  
  const items = [];
  if (mainItem && mainQuantity) {
    items.push(`${mainQuantity}x ${mainItem}`);
  }
  if (dessertItem && dessertQuantity) {
    items.push(`${dessertQuantity}x ${dessertItem}`);
  }

  const push = new Push({
    user: process.env.PUSHOVER_USER_KEY,
    token: process.env.PUSHOVER_API_TOKEN,
  });

  const message = {
    message: `${items.join(', ')}\nPickup: ${pickupDate}`,
    title: `🔔 New Order #${orderId} - £${(totalPrice / 100).toFixed(2)}`,
    sound: 'cashregister',
    priority: 1,
  };

  try {
    await new Promise((resolve, reject) => {
      push.send(message, (err: any, result: any) => {
        if (err) reject(err);
        else resolve(result);
      });
    });
    
    console.log(`✓ Push notification sent for order #${orderId}`);
  } catch (error) {
    console.error('Failed to send push notification:', error);
  }
}
