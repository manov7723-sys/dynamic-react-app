import React from 'react';
import { useNavigate } from 'react-router-dom';

const workspaces = [
  {
    name: 'TechneuralAI',
    path: '/app1',
    description: 'Browse and filter live products from our store',
    icon: '🛍️',
    color: '#ff3c00',
    bg: 'rgba(255,60,0,0.08)',
    border: 'rgba(255,60,0,0.3)',
  },
  {
    name: 'CrewAI',
    path: '/app2',
    description: 'Explore and search through our user directory',
    icon: '👥',
    color: '#1a1aff',
    bg: 'rgba(26,26,255,0.08)',
    border: 'rgba(26,26,255,0.3)',
  },
  {
    name: 'LurobenceAI',
    path: '/app3',
    description: 'Monitor live stats, tasks and team performance',
    icon: '📊',
    color: '#00e5ff',
    bg: 'rgba(0,229,255,0.08)',
    border: 'rgba(0,229,255,0.3)',
  },
];

export default function Home() {
  const navigate = useNavigate();

  return (
    <div style={S.root}>
      <div style={S.hero}>
        <div style={S.tag}>SINGLE APPLICATION</div>
        <h1 style={S.title}>Welcome to Dynamic App</h1>
        <p style={S.subtitle}>
          One application, multiple workspaces — all connected to the same backend
        </p>
      </div>

      <div style={S.grid}>
        {workspaces.map((ws) => (
          <div
            key={ws.name}
            style={{ ...S.card, background: ws.bg, border: `1px solid ${ws.border}` }}
            onClick={() => navigate(ws.path)}
            onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-6px)'}
            onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}
          >
            <div style={{ ...S.icon, color: ws.color }}>{ws.icon}</div>
            <h2 style={{ ...S.cardTitle, color: ws.color }}>{ws.name}</h2>
            <p style={S.cardDesc}>{ws.description}</p>
            <div style={{ ...S.btn, background: ws.color }}>
              Open Workspace →
            </div>
          </div>
        ))}
      </div>

      <div style={S.footer}>
        <div style={S.footerItem}>✅ Single React App</div>
        <div style={S.footerItem}>✅ Single Backend API</div>
        <div style={S.footerItem}>✅ Single Nginx Server</div>
        <div style={S.footerItem}>✅ Path Based Routing</div>
      </div>
    </div>
  );
}

const S = {
  root: {
    fontFamily: "'Inter', sans-serif",
    background: '#07090f',
    minHeight: '100vh',
    color: '#fff',
    margin: 0,
    padding: 0,
  },
  hero: {
    textAlign: 'center',
    padding: '80px 40px 40px',
  },
  tag: {
    display: 'inline-block',
    background: 'rgba(255,255,255,0.05)',
    border: '1px solid rgba(255,255,255,0.1)',
    borderRadius: '20px',
    padding: '6px 18px',
    fontSize: '0.75rem',
    letterSpacing: '2px',
    color: '#888',
    marginBottom: '20px',
  },
  title: {
    fontSize: '3rem',
    fontWeight: 800,
    margin: '0 0 16px',
    background: 'linear-gradient(135deg, #fff 0%, #888 100%)',
    WebkitBackgroundClip: 'text',
    WebkitTextFillColor: 'transparent',
  },
  subtitle: {
    fontSize: '1.1rem',
    color: '#666',
    maxWidth: '500px',
    margin: '0 auto',
    lineHeight: 1.6,
  },
  grid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
    gap: '24px',
    padding: '40px 60px',
    maxWidth: '1100px',
    margin: '0 auto',
  },
  card: {
    borderRadius: '16px',
    padding: '32px',
    cursor: 'pointer',
    transition: 'transform 0.25s ease',
    display: 'flex',
    flexDirection: 'column',
    gap: '12px',
  },
  icon: {
    fontSize: '2.5rem',
  },
  cardTitle: {
    fontSize: '1.4rem',
    fontWeight: 700,
    margin: 0,
  },
  cardDesc: {
    fontSize: '0.9rem',
    color: '#888',
    lineHeight: 1.6,
    margin: 0,
    flexGrow: 1,
  },
  btn: {
    marginTop: '8px',
    padding: '10px 20px',
    borderRadius: '8px',
    color: '#fff',
    fontWeight: 600,
    fontSize: '0.85rem',
    textAlign: 'center',
    cursor: 'pointer',
  },
  footer: {
    display: 'flex',
    justifyContent: 'center',
    gap: '32px',
    padding: '40px',
    flexWrap: 'wrap',
    borderTop: '1px solid #111',
  },
  footerItem: {
    fontSize: '0.85rem',
    color: '#444',
    fontWeight: 500,
  },
};
