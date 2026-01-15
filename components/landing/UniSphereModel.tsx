"use client";

import { useState } from "react";
import Spline from "@splinetool/react-spline";

export function UniSphereModel() {
  const [isLoading, setIsLoading] = useState(true);

  return (
    <div className="relative w-full min-h-[400px] lg:min-h-[520px]">
      {isLoading && (
        <div className="absolute inset-0 flex items-center justify-center">
          <div className="h-56 w-56 rounded-full bg-gradient-to-tr from-purple-900/70 to-black/70 blur-[1px] animate-pulse" />
        </div>
      )}
      <Spline
        scene="https://prod.spline.design/Nmx4Vyeze9wJ-9zm/scene.splinecode"
        onLoad={() => setIsLoading(false)}
        className="w-full h-full"
      />
    </div>
  );
}
