import { db } from "./db";
import { eq } from "drizzle-orm";
import {
  menuItems, orders,
  type MenuItem, type InsertMenuItem,
  type Order, type InsertOrder
} from "@shared/schema";

export interface IStorage {
  getMenuItems(): Promise<MenuItem[]>;
  getMenuItem(id: number): Promise<MenuItem | undefined>;
  createOrder(order: InsertOrder): Promise<Order>;
  seedMenuItems(): Promise<void>;
}

export class DatabaseStorage implements IStorage {
  async getMenuItems(): Promise<MenuItem[]> {
    return await db.select().from(menuItems);
  }

  async getMenuItem(id: number): Promise<MenuItem | undefined> {
    const [item] = await db.select().from(menuItems).where(eq(menuItems.id, id));
    return item;
  }

  async createOrder(insertOrder: InsertOrder): Promise<Order> {
    const [order] = await db.insert(orders).values(insertOrder).returning();
    return order;
  }

  async seedMenuItems(): Promise<void> {
    const existing = await this.getMenuItems();
    if (existing.length > 0) return;

    const items: InsertMenuItem[] = [
      {
        name: "Sweet & Sticky Chicken with Rice",
        description: "Tender chicken breast in a sweet and sticky glaze served with fluffy white rice. High protein, low fat.",
        price: 650,
        category: "main",
        imageUrl: "https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?auto=format&fit=crop&w=800&q=80",
        nutritionalInfo: "Calories: 450, Protein: 45g, Carbs: 50g, Fat: 8g",
      },
      {
        name: "Chicken Power Pesto Pasta",
        description: "Whole wheat pasta tossed in fresh basil pesto with grilled chicken strips and pine nuts.",
        price: 650,
        category: "main",
        imageUrl: "https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=800&q=80",
        nutritionalInfo: "Calories: 520, Protein: 40g, Carbs: 60g, Fat: 15g",
      },
      {
        name: "Premium Overnight Protein Oats",
        description: "Rolled oats soaked overnight in almond milk with whey protein, chia seeds, and mixed berries.",
        price: 550,
        category: "dessert",
        imageUrl: "https://images.unsplash.com/photo-1517673400267-0251440c45dc?auto=format&fit=crop&w=800&q=80",
        nutritionalInfo: "Calories: 430, Protein: 34g, Carbs: 46g, Fat: 9g",
      },
      {
        name: "High-Protein Brownie Bites",
        description: "Decadent chocolate brownie bites packed with protein. The perfect guilt-free treat.",
        price: 550,
        category: "dessert",
        imageUrl: "https://images.unsplash.com/photo-1624353365286-3f8d62daad51?auto=format&fit=crop&w=800&q=80",
        nutritionalInfo: "Calories: 250, Protein: 15g, Carbs: 20g, Fat: 12g",
      },
    ];

    await db.insert(menuItems).values(items);
  }
}

export const storage = new DatabaseStorage();
