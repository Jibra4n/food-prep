import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api, type InsertOrder } from "@shared/routes";

export function useMenu() {
  return useQuery({
    queryKey: [api.menu.list.path],
    queryFn: async () => {
      const res = await fetch(api.menu.list.path);
      if (!res.ok) throw new Error("Failed to fetch menu");
      return api.menu.list.responses[200].parse(await res.json());
    },
  });
}

export function useMenuItem(id: number) {
  return useQuery({
    queryKey: [api.menu.get.path, id],
    queryFn: async () => {
      // Manually construct URL since we don't have buildUrl helper exported in the prompt's context 
      // but in real code we should import buildUrl. Assuming simple replacement here.
      const url = api.menu.get.path.replace(':id', String(id));
      const res = await fetch(url);
      if (!res.ok) throw new Error("Failed to fetch menu item");
      return api.menu.get.responses[200].parse(await res.json());
    },
    enabled: !!id,
  });
}

export function useCreateOrder() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (orderData: InsertOrder) => {
      const res = await fetch(api.orders.create.path, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(orderData),
      });
      
      if (!res.ok) {
        if (res.status === 400) {
          const error = api.orders.create.responses[400].parse(await res.json());
          throw new Error(error.message);
        }
        throw new Error("Failed to place order");
      }
      
      return api.orders.create.responses[201].parse(await res.json());
    },
    onSuccess: () => {
      // In a real app, you might invalidate queries or redirect
      // queryClient.invalidateQueries({ queryKey: [api.orders.list.path] }); 
    },
  });
}
