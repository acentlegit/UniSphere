"use client";

import { motion } from "framer-motion";
import { Cpu, Menu, X, ChevronDown } from "lucide-react";
import Link from "next/link";
import { useState } from "react";

export function Navbar() {
    const [isMenuOpen, setIsMenuOpen] = useState(false);

    return (
        <nav className="fixed top-0 w-full z-50 glass-nav">
            <div className="max-w-7xl mx-auto px-6 py-4.5 flex justify-between items-center">
                {/* Logo - Chip Icon */}
                <Link href="/" className="flex items-center gap-3 cursor-pointer group">
                    <div className="w-10 h-10 rounded-lg border-2 border-cyan-400/80 bg-slate-900/40 flex items-center justify-center group-hover:border-purple-400 transition-colors">
                        <Cpu className="w-6 h-6 text-cyan-400 group-hover:text-purple-400 transition-colors" />
                    </div>
                    <span className="text-xl font-bold tracking-tight">
                        UniSphere <span className="text-cyan-400">AI</span>
                    </span>
                </Link>

                {/* Desktop Navigation - ALWAYS VISIBLE ON DESKTOP */}
                <div className="flex items-center gap-8 text-sm font-medium">
                    <a
                        href="#solutions"
                        className="text-slate-300 no-underline hover:text-white transition-colors flex items-center gap-1"
                    >
                        Solutions <ChevronDown className="w-3 h-3" />
                    </a>
                    <a href="#coaching" className="text-slate-300 no-underline hover:text-white transition-colors">
                        For Coaching
                    </a>
                    <a href="#researchers" className="text-slate-300 no-underline hover:text-white transition-colors">
                        For Researchers
                    </a>
                    <a href="#resources" className="text-slate-300 no-underline hover:text-white transition-colors">
                        Resources
                    </a>
                </div>

                {/* CTA Button - PROMINENT GRADIENT BUTTON */}
                <div className="flex items-center gap-4">
                    <Link href="/signup">
                        <button className="px-6 py-2.5 rounded-full btn-gradient text-white text-sm font-semibold shadow-lg">
                            Get Started
                        </button>
                    </Link>
                    <button
                        className="hidden text-slate-300 text-xl"
                        onClick={() => setIsMenuOpen(!isMenuOpen)}
                    >
                        {isMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
                    </button>
                </div>
            </div>

            {/* Mobile Menu */}
            {isMenuOpen && (
                <motion.div
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="md:hidden stats-card mx-6 mb-4 rounded-2xl p-6"
                >
                    <div className="flex flex-col gap-4">
                        <a href="#solutions" className="text-slate-300 hover:text-white transition-colors py-2">Solutions</a>
                        <a href="#coaching" className="text-slate-300 hover:text-white transition-colors py-2">For Coaching</a>
                        <a href="#researchers" className="text-slate-300 hover:text-white transition-colors py-2">For Researchers</a>
                        <a href="#resources" className="text-slate-300 hover:text-white transition-colors py-2">Resources</a>
                        <Link href="/signup" className="mt-4">
                            <button className="w-full px-6 py-3 rounded-full btn-gradient text-white font-semibold">
                                Get Started
                            </button>
                        </Link>
                    </div>
                </motion.div>
            )}
        </nav>
    );
}
