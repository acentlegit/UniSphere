"use client";

import { motion } from "framer-motion";
import { Rocket, Play, Users, BookOpen, Award } from "lucide-react";
import { UniSphereModel } from "@/components/landing/UniSphereModel";

export function HeroSection() {
    return (
        <section className="relative min-h-screen pt-40 pb-20 px-6 overflow-hidden text-white">
            <div className="absolute inset-0 hero-bg" />
            <div className="absolute inset-0 hero-vignette" />

            <div className="relative z-10 max-w-7xl mx-auto">
                {/* Two-Column Grid Layout */}
                <div className="grid grid-cols-2 gap-12 lg:gap-16 items-center mb-10">

                    {/* LEFT COLUMN - Content */}
                    <div className="max-w-2xl order-1 relative z-10">
                        {/* Main Heading */}
                        <motion.h1
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.2, duration: 0.8 }}
                            className="text-5xl md:text-6xl xl:text-7xl font-bold leading-tight mb-6 tracking-tight"
                        >
                            Unlock Your Potential
                            <br />
                            with <span className="text-gradient">UniSphere AI</span>
                        </motion.h1>

                        {/* Subheading - MUST BE PRESENT */}
                        <motion.p
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.3, duration: 0.8 }}
                            className="text-base lg:text-lg text-slate-300 mb-8 leading-relaxed max-w-xl"
                        >
                            The premier AI-powered platform for personalized learning, advanced coaching, and groundbreaking research. Experience the future of education.
                        </motion.p>

                        {/* CTA Buttons - HORIZONTAL LAYOUT */}
                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.4 }}
                            className="flex flex-row flex-wrap gap-4 mb-2"
                        >
                            {/* Primary Button - Gradient */}
                            <button className="px-8 py-4 rounded-full btn-gradient-soft text-white font-semibold text-base inline-flex items-center justify-center gap-2 shadow-lg whitespace-nowrap">
                                Get Started Now <Rocket className="w-5 h-5" />
                            </button>

                            {/* Secondary Button - Glass Style */}
                            <button className="px-8 py-4 rounded-full glass-pill hover:bg-slate-600/40 text-white font-medium text-base inline-flex items-center justify-center gap-2 whitespace-nowrap">
                                <Play className="w-5 h-5" /> See It in Action
                            </button>
                        </motion.div>

                        {/* Stats Banner - Compact Glass Panel */}
                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.5 }}
                            className="bg-slate-800/35 backdrop-blur-md border border-slate-700/50 rounded-2xl p-6 max-w-xl"
                        >
                            <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
                                {/* Stat 1 - Active Learners */}
                                <div className="flex items-center gap-4">
                                    <div className="w-12 h-12 rounded-full bg-slate-700/40 flex items-center justify-center flex-shrink-0 border border-slate-600/40">
                                        <Users className="w-6 h-6 text-white" />
                                    </div>
                                    <div>
                                        <div className="text-2xl font-bold text-white">12,500+</div>
                                        <div className="text-xs text-slate-400">Active Learners &<br />Researchers</div>
                                    </div>
                                </div>

                                {/* Stat 2 - AI Courses */}
                                <div className="flex items-center gap-4">
                                    <div className="w-12 h-12 rounded-full bg-slate-700/40 flex items-center justify-center flex-shrink-0 border border-slate-600/40">
                                        <BookOpen className="w-6 h-6 text-white" />
                                    </div>
                                    <div>
                                        <div className="text-2xl font-bold text-white">450+</div>
                                        <div className="text-xs text-slate-400">AI-Enhanced<br />Courses</div>
                                    </div>
                                </div>

                                {/* Stat 3 - Success Rate */}
                                <div className="flex items-center gap-4">
                                    <div className="w-12 h-12 rounded-full bg-slate-700/40 flex items-center justify-center flex-shrink-0 border border-slate-600/40">
                                        <Award className="w-6 h-6 text-white" />
                                    </div>
                                    <div>
                                        <div className="text-2xl font-bold text-white">98%</div>
                                        <div className="text-xs text-slate-400">Goal Achievement<br />Rate</div>
                                    </div>
                                </div>
                            </div>
                        </motion.div>
                    </div>

                    {/* RIGHT COLUMN - 3D Illustration */}
                    <motion.div
                        initial={{ opacity: 0, x: 20 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: 0.6, duration: 1 }}
                        className="relative order-2"
                    >
                        <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
                            <div className="h-72 w-72 rounded-full bg-purple-600/30 blur-[110px]" />
                        </div>
                        <div className="relative md:pl-4">
                            <UniSphereModel />
                        </div>
                    </motion.div>
                </div>

            </div>
        </section>
    );
}
