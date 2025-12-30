import { Link } from "wouter";
import { motion } from "framer-motion";
import { Button } from "@/components/ui-button";

export default function Landing() {
  return (
    <div className="min-h-screen bg-black text-white flex flex-col items-center justify-center relative overflow-hidden">
      {/* Background Ambience */}
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-zinc-900 via-black to-black opacity-50 pointer-events-none" />
      
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8, ease: "easeOut" }}
        className="z-10 text-center space-y-8 p-6 w-full max-w-md"
      >
        <div className="space-y-4">
          <h1 className="text-6xl font-display font-bold tracking-tighter leading-tight italic">
            king's<br />prep
          </h1>
          <p className="text-zinc-400 text-lg tracking-widest uppercase font-sans text-xs">
            Eat Like a King
          </p>
        </div>

        <div className="pt-12">
          <Link href="/menu">
            <Button variant="secondary" className="w-full bg-zinc-900 border border-zinc-800 hover:bg-zinc-800 text-zinc-300 uppercase tracking-widest text-xs py-6">
              View
            </Button>
          </Link>
        </div>
      </motion.div>
      
      <div className="absolute bottom-8 text-zinc-800 text-[10px] uppercase tracking-widest">
        Est. 2024
      </div>
    </div>
  );
}
