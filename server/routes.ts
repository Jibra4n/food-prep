import type { Express } from "express";
import type { Server } from "http";
import { storage } from "./storage";
import { api } from "@shared/routes";
import { z } from "zod";
import { sendOrderNotification } from "./notifications";

export async function registerRoutes(
  httpServer: Server,
  app: Express
): Promise<Server> {
  // Seed data on startup
  await storage.seedMenuItems();

  app.get(api.menu.list.path, async (req, res) => {
    const items = await storage.getMenuItems();
    res.json(items);
  });

  app.get(api.menu.get.path, async (req, res) => {
    const item = await storage.getMenuItem(Number(req.params.id));
    if (!item) {
      return res.status(404).json({ message: "Item not found" });
    }
    res.json(item);
  });

  app.post(api.orders.create.path, async (req, res) => {
    try {
      const input = api.orders.create.input.parse(req.body);
      const order = await storage.createOrder(input);
      
      // Get menu item details for notification
      const mainItem = order.mainItemId ? await storage.getMenuItem(order.mainItemId) : undefined;
      const dessertItem = order.dessertItemId ? await storage.getMenuItem(order.dessertItemId) : undefined;
      
      // Send notification (async, don't wait for it)
      sendOrderNotification({
        orderId: order.id,
        mainItem: mainItem?.name,
        mainQuantity: order.mainQuantity || 0,
        dessertItem: dessertItem?.name,
        dessertQuantity: order.dessertQuantity || 0,
        pickupDate: order.pickupDate,
        totalPrice: order.totalPrice,
      }).catch(err => console.error('Notification error:', err));
      
      res.status(201).json(order);
    } catch (err) {
      if (err instanceof z.ZodError) {
        return res.status(400).json({
          message: err.errors[0].message,
          field: err.errors[0].path.join('.'),
        });
      }
      throw err;
    }
  });

  return httpServer;
}
