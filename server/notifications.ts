import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);

export async function sendOrderNotification(orderDetails: {
  orderId: number;
  mainItem?: string;
  mainQuantity?: number;
  dessertItem?: string;
  dessertQuantity?: number;
  pickupDate: string;
  totalPrice: number;
}) {
  if (!process.env.RESEND_API_KEY || !process.env.NOTIFICATION_EMAIL) {
    console.log('Email notifications not configured - skipping');
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

  try {
    await resend.emails.send({
      from: 'Food Prep Orders <orders@resend.dev>',
      to: process.env.NOTIFICATION_EMAIL,
      subject: `🔔 New Order #${orderId} - £${(totalPrice / 100).toFixed(2)}`,
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2 style="color: #2563eb;">New Order Received! 🎉</h2>
          
          <div style="background: #f3f4f6; padding: 20px; border-radius: 8px; margin: 20px 0;">
            <p style="margin: 5px 0;"><strong>Order ID:</strong> #${orderId}</p>
            <p style="margin: 5px 0;"><strong>Pickup Date:</strong> ${pickupDate}</p>
            <p style="margin: 5px 0;"><strong>Total:</strong> £${(totalPrice / 100).toFixed(2)}</p>
          </div>

          <h3 style="color: #374151;">Order Items:</h3>
          <ul style="list-style: none; padding: 0;">
            ${items.map(item => `<li style="padding: 8px; background: #f9fafb; margin: 5px 0; border-left: 3px solid #2563eb;">📦 ${item}</li>`).join('')}
          </ul>

          <p style="color: #6b7280; font-size: 14px; margin-top: 30px;">
            This notification was sent from your Food Prep Orders app.
          </p>
        </div>
      `,
    });
    
    console.log(`✓ Order notification sent for order #${orderId}`);
  } catch (error) {
    console.error('Failed to send order notification:', error);
  }
}
