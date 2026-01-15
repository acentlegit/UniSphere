"use client";

import { Navbar } from "@/components/landing/Navbar";
import { HeroSection } from "@/components/landing/HeroSection";
// Landing page intentionally mirrors the approved hero-only design.

export default function LandingPage() {
  return (
    <div className="min-h-screen text-white font-sans selection:bg-cyan-500/30">
      <Navbar />
      <HeroSection />
    </div>
  );
}
