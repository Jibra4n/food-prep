import { Switch, Route } from "wouter";
import { queryClient } from "./lib/queryClient";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/not-found";
import Landing from "@/pages/landing";
import Menu from "@/pages/menu";
import ItemDetail from "@/pages/item-detail";
import OrderPage from "@/pages/order";

function Router() {
  return (
    <Switch>
      <Route path="/" component={Landing} />
      <Route path="/menu" component={Menu} />
      <Route path="/menu/:id" component={ItemDetail} />
      <Route path="/order" component={OrderPage} />
      <Route component={NotFound} />
    </Switch>
  );
}

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <Toaster />
        <Router />
      </TooltipProvider>
    </QueryClientProvider>
  );
}

export default App;
