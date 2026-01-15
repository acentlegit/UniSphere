
"use client";

import { useEffect, useState } from "react";

type CoachFlags = {
  pending: number;
};

const defaultFlags: CoachFlags = {
  pending: 3,
};

export default function CoachDashboard() {
  const [data, setData] = useState<CoachFlags>(defaultFlags);

  useEffect(() => {
    let isMounted = true;
    fetch("http://localhost:8000/coach/flags", { cache: "no-store" })
      .then((res) => (res.ok ? res.json() : null))
      .then((json) => {
        if (isMounted && json?.pending != null) {
          setData({ pending: json.pending });
        }
      })
      .catch(() => {
        // Keep defaults when backend is unavailable in static hosting.
      });
    return () => {
      isMounted = false;
    };
  }, []);

  return (
    <div>
      <h1>Coach Dashboard</h1>
      <p>Pending AI Reviews: {data.pending}</p>
      <button>Review Flags</button>
    </div>
  );
}
