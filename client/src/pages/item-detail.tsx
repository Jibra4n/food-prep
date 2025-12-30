import { useParams, Link } from "wouter";
import { useMenuItem } from "@/hooks/use-menu";
import { Layout } from "@/components/layout";
import { Button } from "@/components/ui-button";
import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";

export default function ItemDetail() {
  const params = useParams();
  const id = parseInt(params.id || "0");
  const { data: item, isLoading } = useMenuItem(id);

  if (isLoading) return <DetailSkeleton />;
  if (!item) return <div>Item not found</div>;

  const price = (item.price / 100).toFixed(2);

  return (
    <Layout showBack backTo="/menu">
      <div className="space-y-8 pb-32">
        {/* Hero Image */}
        <motion.div 
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          className="aspect-square w-full overflow-hidden rounded-3xl border border-white/5 relative group"
        >
          <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent z-10" />
          <img 
            src={item.imageUrl} 
            alt={item.name} 
            className="w-full h-full object-cover"
          />
          <div className="absolute bottom-6 left-6 right-6 z-20 flex justify-between items-end">
             <h1 className="text-3xl font-display font-bold leading-none max-w-[70%]">{item.name}</h1>
             <span className="text-xl font-mono">£{price}</span>
          </div>
        </motion.div>

        {/* Info Sections */}
        <motion.div 
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="space-y-8"
        >
          <div className="space-y-2">
            <h3 className="text-xs uppercase tracking-widest text-zinc-500 font-bold">Ingredients</h3>
            <p className="text-zinc-300 leading-relaxed font-light text-sm">
              {item.description}
            </p>
          </div>

          <div className="space-y-2">
            <h3 className="text-xs uppercase tracking-widest text-zinc-500 font-bold">Nutritional Info</h3>
            <div className="p-4 rounded-xl bg-zinc-900/50 border border-white/5 font-mono text-xs text-zinc-400 whitespace-pre-line">
              {item.nutritionalInfo || "No nutritional info available."}
            </div>
          </div>
        </motion.div>
      </div>

      {/* Action Buttons */}
      <div className="fixed bottom-0 left-0 right-0 p-6 bg-gradient-to-t from-black via-black to-transparent z-40">
        <div className="max-w-md mx-auto grid grid-cols-2 gap-4">
          <Link href="/menu">
            <Button variant="secondary" className="w-full">
              Back
            </Button>
          </Link>
          <Link href="/order">
            <Button className="w-full">
              Order
            </Button>
          </Link>
        </div>
      </div>
    </Layout>
  );
}

function DetailSkeleton() {
  return (
    <Layout showBack backTo="/menu">
      <div className="space-y-8">
        <Skeleton className="aspect-square w-full rounded-3xl bg-zinc-900" />
        <div className="space-y-4">
          <Skeleton className="h-4 w-32 bg-zinc-900" />
          <Skeleton className="h-24 w-full bg-zinc-900" />
        </div>
      </div>
    </Layout>
  );
}
