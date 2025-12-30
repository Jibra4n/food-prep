import { Link } from "wouter";
import { ArrowLeft } from "lucide-react";

interface LayoutProps {
  children: React.ReactNode;
  title?: string;
  showBack?: boolean;
  backTo?: string;
}

export function Layout({ children, title, showBack, backTo = "/" }: LayoutProps) {
  return (
    <div className="min-h-screen bg-black text-white selection:bg-white selection:text-black">
      <div className="max-w-md mx-auto min-h-screen flex flex-col relative bg-zinc-950/30">
        
        {/* Header */}
        {(title || showBack) && (
          <header className="sticky top-0 z-50 backdrop-blur-xl bg-black/50 border-b border-white/5 px-6 py-4 flex items-center justify-between">
            <div className="flex items-center gap-4">
              {showBack && (
                <Link href={backTo} className="p-2 -ml-2 rounded-full hover:bg-white/10 transition-colors">
                  <ArrowLeft className="w-5 h-5" />
                </Link>
              )}
              {title && <h1 className="text-xl font-display font-medium tracking-wide">{title}</h1>}
            </div>
          </header>
        )}

        {/* Content */}
        <main className="flex-1 flex flex-col p-6 safe-bottom">
          {children}
        </main>
      </div>
    </div>
  );
}
