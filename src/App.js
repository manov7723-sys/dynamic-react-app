import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import TechneuralAI from './pages/TechneuralAI';
import CrewAI from './pages/CrewAI';
import LurobenceAI from './pages/LurobenceAI';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/app1" element={<TechneuralAI />} />
        <Route path="/app2" element={<CrewAI />} />
        <Route path="/app3" element={<LurobenceAI />} />
      </Routes>
    </BrowserRouter>
  );
}
