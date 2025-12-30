import { pgTable, text, serial, integer, boolean, timestamp } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod";

export const menuItems = pgTable("menu_items", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description").notNull(), // Ingredients/Details
  price: integer("price").notNull(), // In cents/pence (e.g., 650 for £6.50)
  category: text("category").notNull(), // 'main' | 'dessert'
  imageUrl: text("image_url").notNull(),
  nutritionalInfo: text("nutritional_info"), // text representation
});

export const orders = pgTable("orders", {
  id: serial("id").primaryKey(),
  mainItemId: integer("main_item_id").references(() => menuItems.id),
  mainQuantity: integer("main_quantity").default(0),
  dessertItemId: integer("dessert_item_id").references(() => menuItems.id),
  dessertQuantity: integer("dessert_quantity").default(0),
  pickupDate: text("pickup_date").notNull(),
  totalPrice: integer("total_price").notNull(),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertMenuItemSchema = createInsertSchema(menuItems).omit({ id: true });
export const insertOrderSchema = createInsertSchema(orders).omit({ id: true, createdAt: true });

export type MenuItem = typeof menuItems.$inferSelect;
export type InsertMenuItem = z.infer<typeof insertMenuItemSchema>;
export type Order = typeof orders.$inferSelect;
export type InsertOrder = z.infer<typeof insertOrderSchema>;
