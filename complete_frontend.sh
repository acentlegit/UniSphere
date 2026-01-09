#!/bin/bash

set -e

echo "🚀 Completing UniSphere Frontend (Responsive UI)"

cd frontend

####################################
# Install dependencies
####################################
echo "📦 Installing dependencies..."
npm install react-router-dom axios
npm install @livekit/components-react livekit-client
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

####################################
# Tailwind config
####################################
echo "🎨 Configuring Tailwind..."
cat <<EOF > tailwind.config.js
export default {
  content: ["./src/**/*.{js,jsx}"],
  theme: { extend: {} },
  plugins: [],
}
EOF

####################################
# CSS
####################################
cat <<EOF > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

####################################
# App Routing
####################################
cat <<EOF > src/App.js
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from "./pages/Login";
import StudentDashboard from "./pages/StudentDashboard";
import LecturerDashboard from "./pages/LecturerDashboard";
import ResearchDashboard from "./pages/ResearchDashboard";
import VideoRoom from "./pages/VideoRoom";

export default function App() {
  const role = localStorage.getItem("role");

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/video" element={<VideoRoom />} />
        {role === "student" && <Route path="/dashboard" element={<StudentDashboard />} />}
        {role === "lecturer" && <Route path="/dashboard" element={<LecturerDashboard />} />}
        {role === "researcher" && <Route path="/dashboard" element={<ResearchDashboard />} />}
      </Routes>
    </BrowserRouter>
  );
}
EOF

####################################
# Layout Component
####################################
mkdir -p src/components
cat <<EOF > src/components/Layout.js
export default function Layout({ title, children }) {
  return (
    <div className="min-h-screen flex">
      <aside className="hidden md:block w-64 bg-gray-900 text-white p-4">
        <h2 className="font-bold text-xl mb-4">UniSphere AI</h2>
        <nav className="space-y-2">
          <a href="/dashboard">Dashboard</a><br />
          <a href="/video">Live Class</a>
        </nav>
      </aside>
      <main className="flex-1 p-6 bg-gray-50">
        <h1 className="text-2xl font-bold mb-4">{title}</h1>
        {children}
      </main>
    </div>
  );
}
EOF

####################################
# Pages
####################################
mkdir -p src/pages

cat <<EOF > src/pages/Login.js
import axios from "axios";
import { useState } from "react";

export default function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  async function login() {
    const res = await axios.post("http://localhost:8000/auth/login", { email, password });
    localStorage.setItem("token", res.data.token);
    localStorage.setItem("role", res.data.role);
    window.location.href = "/dashboard";
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      <div className="bg-white p-6 rounded w-80">
        <h2 className="text-xl font-bold mb-4">UniSphere Login</h2>
        <input className="border p-2 w-full mb-2" placeholder="Email"
          onChange={e => setEmail(e.target.value)} />
        <input className="border p-2 w-full mb-4" type="password"
          placeholder="Password" onChange={e => setPassword(e.target.value)} />
        <button className="bg-blue-600 text-white w-full p-2 rounded"
          onClick={login}>Login</button>
      </div>
    </div>
  );
}
EOF

cat <<EOF > src/pages/StudentDashboard.js
import Layout from "../components/Layout";
import axios from "axios";
import { useState } from "react";

export default function StudentDashboard() {
  const [q, setQ] = useState("");
  const [answer, setAnswer] = useState("");

  async function ask() {
    const res = await axios.get("http://localhost:8000/learning/ask?q=" + q);
    setAnswer(res.data.answer);
  }

  return (
    <Layout title="Student Dashboard">
      <input className="border p-2 w-full mb-2" placeholder="Ask a question"
        onChange={e => setQ(e.target.value)} />
      <button className="bg-green-600 text-white px-4 py-2 rounded" onClick={ask}>
        Ask AI
      </button>
      <p className="mt-4 whitespace-pre-wrap">{answer}</p>
    </Layout>
  );
}
EOF

cat <<EOF > src/pages/LecturerDashboard.js
import Layout from "../components/Layout";

export default function LecturerDashboard() {
  return (
    <Layout title="Lecturer Dashboard">
      <div className="grid md:grid-cols-3 gap-4">
        <div className="bg-white p-4 shadow rounded">Students: 120</div>
        <div className="bg-white p-4 shadow rounded">Classes: 4</div>
        <div className="bg-white p-4 shadow rounded">Reviews: 18</div>
      </div>
    </Layout>
  );
}
EOF

cat <<EOF > src/pages/ResearchDashboard.js
import Layout from "../components/Layout";

export default function ResearchDashboard() {
  return (
    <Layout title="Research Dashboard">
      <p>Research tools and analytics coming here.</p>
    </Layout>
  );
}
EOF

cat <<EOF > src/pages/VideoRoom.js
import { LiveKitRoom } from "@livekit/components-react";

export default function VideoRoom() {
  const token = localStorage.getItem("livekit_token");

  return (
    <div className="h-screen">
      <LiveKitRoom
        serverUrl="wss://YOUR_LIVEKIT_URL"
        token={token}
        connect
        style={{ height: "100%" }}
      />
    </div>
  );
}
EOF

echo "✅ Frontend completed and responsive!"
echo "👉 Run: npm start"

