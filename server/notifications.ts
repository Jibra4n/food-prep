export async function sendOrderNotification(orderDetails: {
  orderId: number;
  mainItem?: string;
  mainQuantity?: number;
  dessertItem?: string;
  dessertQuantity?: number;
  pickupDate: string;
  totalPrice: number;
}) {
  if (!process.env.NTFY_TOPIC) {
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

  const title = `🔔 New Order #${orderId} - £${(totalPrice / 100).toFixed(2)}`;
  const message = `${items.join(', ')}\nPickup: ${pickupDate}`;

  try {
    const response = await fetch(`https://ntfy.sh/${process.env.NTFY_TOPIC}`, {
      method: 'POST',
      headers: {
        'Title': title,
        'Priority': '4',
        'Tags': 'shopping_cart,money_with_wings',
      },
      body: message,
    });

    if (!response.ok) {
      throw new Error(`ntfy returned ${response.status}`);
    }
    
    console.log(`✓ Push notification sent for order #${orderId}`);
  } catch (error) {
    console.error('Failed to send push notification:', error);
  }
}
