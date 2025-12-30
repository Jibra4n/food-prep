import { ButtonHTMLAttributes, forwardRef } from "react";
import { cn } from "@/lib/utils";

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "outline" | "ghost";
  size?: "sm" | "md" | "lg" | "icon";
}

export const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = "primary", size = "md", ...props }, ref) => {
    const variants = {
      primary: "bg-white text-black hover:bg-gray-200 shadow-lg shadow-white/5",
      secondary: "bg-zinc-800 text-white hover:bg-zinc-700",
      outline: "border border-zinc-700 bg-transparent hover:bg-zinc-900 text-zinc-300",
      ghost: "bg-transparent hover:bg-white/5 text-zinc-400 hover:text-white",
    };

    const sizes = {
      sm: "h-9 px-4 text-xs rounded-full",
      md: "h-12 px-6 text-sm rounded-full",
      lg: "h-14 px-8 text-base rounded-full",
      icon: "h-10 w-10 p-2 rounded-full",
    };

    return (
      <button
        ref={ref}
        className={cn(
          "inline-flex items-center justify-center font-medium transition-all duration-300 disabled:opacity-50 disabled:pointer-events-none active:scale-95",
          variants[variant],
          sizes[size],
          className
        )}
        {...props}
      />
    );
  }
);

Button.displayName = "Button";
