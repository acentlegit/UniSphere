"use client";

import { useEffect, useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { BookOpen, UserCheck, MessageSquare } from "lucide-react";

type StudentProgress = {
  completion: number;
  course: string;
};

const defaultProgress: StudentProgress = {
  completion: 75,
  course: "AI Fundamentals",
};

export default function StudentDashboard() {
  const [data, setData] = useState<StudentProgress>(defaultProgress);

  useEffect(() => {
    let isMounted = true;
    fetch("http://localhost:8000/student/progress", { cache: "no-store" })
      .then((res) => (res.ok ? res.json() : null))
      .then((json) => {
        if (isMounted && json?.completion != null && json?.course) {
          setData({ completion: json.completion, course: json.course });
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
    <div className="p-8 space-y-8 bg-slate-50 min-h-screen">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-900">Student Dashboard</h1>
          <p className="text-slate-500">Welcome back, Student!</p>
        </div>
        <div className="flex gap-4">
          <Button variant="outline"><UserCheck className="mr-2 h-4 w-4" /> Profile</Button>
        </div>
      </div>

      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {/* Welcome / Active Course Card */}
        <Card className="col-span-2">
          <CardHeader>
            <CardTitle>Current Course: {data.course}</CardTitle>
            <CardDescription>Continue where you left off.</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="flex items-center justify-between mb-4">
              <span className="text-sm font-medium">Progress</span>
              <span className="text-sm text-muted-foreground">{data.completion}%</span>
            </div>
            <div className="w-full bg-slate-200 rounded-full h-2.5 mb-6">
              <div className="bg-blue-600 h-2.5 rounded-full" style={{ width: `${data.completion}%` }}></div>
            </div>
            <Button className="w-full sm:w-auto">
              <BookOpen className="mr-2 h-4 w-4" /> Resume Learning
            </Button>
          </CardContent>
        </Card>

        {/* AI Coach Card */}
        <Card>
          <CardHeader>
            <CardTitle>AI Coach</CardTitle>
            <CardDescription>Your personal learning assistant.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex items-center p-3 bg-blue-50 rounded-lg text-blue-700 text-sm">
              <MessageSquare className="w-4 h-4 mr-3" />
              <span>Quiz on Neural Networks due tomorrow.</span>
            </div>
            <div className="flex items-center p-3 bg-blue-50 rounded-lg text-blue-700 text-sm">
              <MessageSquare className="w-4 h-4 mr-3" />
              <span>Research Article Review pending.</span>
            </div>
            <Button variant="secondary" className="w-full">Ask Question</Button>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
