import React, { useEffect, useState } from 'react';

const COLORS = ['#00e5ff', '#ff4d6d', '#00e5b0', '#f59e0b', '#8b5cf6', '#f97316', '#3b82f6', '#ec4899', '#10b981', '#a78bfa'];

export default function LurobenceAI() {
  const [todos, setTodos] = useState([]);
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      fetch('https://jsonplaceholder.typicode.com/todos?_limit=20').then(r => r.json()),
      fetch('https://jsonplaceholder.typicode.com/users').then(r => r.json()),
    ]).then(([t, u]) => { setTodos(t); setUsers(u); setLoading(false); })
      .catch(() => setLoading(false));
  }, []);

  const completed = todos.filter(t => t.completed).length;
  const pending = todos.length - completed;
  const rate = todos.length ? Math.round((completed / todos.length) * 100) : 0;

  const stats = [
    { label: 'Total Tasks', value: todos.length, color: '#00e5ff' },
    { label: 'Completed', value: completed, color: '#00e5b0' },
    { label: 'Pending', value: pending, color: '#f59e0b' },
    { label: 'Completion Rate', value: `${rate}%`, color: '#8b5cf6' },
  ];

  const categories = [
    { label: 'Frontend', pct: 72, color: '#00e5ff' },
    { label: 'Backend', pct: 58, color: '#8b5cf6' },
    { label: 'DevOps', pct: 85, color: '#00e5b0' },
    { label: 'Design', pct: 43, color: '#f59e0b' },
  ];

  return (
    <div style={S.root}>
      <style>{`@keyframes spin { to { transform: rotate(360deg); } }`}</style>
      <header style={S.header}>
        <div style={S.logo}>LurobenceAI</div>
        <div style={S.live}>● LIVE</div>
      </header>

      {loading ? (
        <div style={S.loading}><div style={S.spinner} /><span>Loading...</span></div>
      ) : (
        <div style={S.main}>
          <div style={S.statsGrid}>
            {stats.map(s => (
              <div key={s.label} style={{ ...S.statCard, borderColor: s.color + '33' }}>
                <div style={{ ...S.statAccent, background: s.color }} />
                <div style={S.statLabel}>{s.label}</div>
                <div style={{ ...S.statValue, color: s.color }}>{s.value}</div>
              </div>
            ))}
          </div>

          <div style={S.twoCol}>
            <div style={S.panel}>
              <div style={S.panelTitle}>Recent Tasks</div>
              {todos.slice(0, 10).map(todo => (
                <div key={todo.id} style={S.todoItem(todo.completed)}>
                  <div style={S.checkbox(todo.completed)}>{todo.completed ? '✓' : ''}</div>
                  <span>{todo.title}</span>
                </div>
              ))}
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
              <div style={S.panel}>
                <div style={S.panelTitle}>Team Progress</div>
                {categories.map(cat => (
                  <div key={cat.label} style={{ marginBottom: '14px' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.8rem', color: '#6b7a99', marginBottom: '6px' }}>
                      <span>{cat.label}</span><span>{cat.pct}%</span>
                    </div>
                    <div style={{ height: '6px', background: '#1e2530', borderRadius: '4px', overflow: 'hidden' }}>
                      <div style={{ height: '100%', width: `${cat.pct}%`, background: cat.color, borderRadius: '4px' }} />
                    </div>
                  </div>
                ))}
              </div>

              <div style={S.panel}>
                <div style={S.panelTitle}>Team Members</div>
                {users.slice(0, 5).map((u, i) => (
                  <div key={u.id} style={{ display: 'flex', alignItems: 'center', gap: '10px', padding: '8px 0', borderBottom: '1px solid #12181f' }}>
                    <div style={{ width: '32px', height: '32px', borderRadius: '50%', background: COLORS[i % COLORS.length], display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.72rem', fontWeight: 800, color: '#07090f', flexShrink: 0 }}>
                      {u.name.split(' ').map(n => n[0]).join('').slice(0, 2)}
                    </div>
                    <div>
                      <div style={{ fontSize: '0.85rem', color: '#c8d6e8', fontWeight: 600 }}>{u.name}</div>
                      <div style={{ fontSize: '0.75rem', color: '#4a5a6c' }}>{u.company.name}</div>
                    </div>
                    <div style={{ marginLeft: 'auto', width: '8px', height: '8px', borderRadius: '50%', background: i % 3 !== 0 ? '#00e5b0' : '#3a4a5c' }} />
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

const S = {
  root: { fontFamily: "'Inter', sans-serif", background: '#07090f', minHeight: '100vh', color: '#e2e8f0' },
  header: { borderBottom: '1px solid #1e2530', padding: '20px 40px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', position: 'sticky', top: 0, background: '#07090f', zIndex: 100 },
  logo: { fontSize: '1.4rem', fontWeight: 800, color: '#00e5ff' },
  live: { color: '#00e5b0', fontSize: '0.8rem', fontWeight: 700, letterSpacing: '1px' },
  main: { padding: '30px 40px' },
  statsGrid: { display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '16px', marginBottom: '24px' },
  statCard: { background: '#0d1117', border: '1px solid', borderRadius: '12px', padding: '20px', position: 'relative', overflow: 'hidden' },
  statAccent: { position: 'absolute', top: 0, left: 0, right: 0, height: '2px' },
  statLabel: { fontSize: '0.75rem', color: '#6b7a99', textTransform: 'uppercase', letterSpacing: '1.5px', marginBottom: '10px', fontWeight: 600 },
  statValue: { fontSize: '1.8rem', fontWeight: 800, lineHeight: 1 },
  twoCol: { display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' },
  panel: { background: '#0d1117', border: '1px solid #1e2530', borderRadius: '12px', padding: '22px' },
  panelTitle: { fontSize: '0.78rem', color: '#00e5ff', letterSpacing: '2px', textTransform: 'uppercase', marginBottom: '16px', fontWeight: 700 },
  todoItem: (done) => ({ display: 'flex', alignItems: 'center', gap: '10px', padding: '8px 0', borderBottom: '1px solid #12181f', fontSize: '0.83rem', color: done ? '#3a4a5c' : '#b0bcd4', textDecoration: done ? 'line-through' : 'none' }),
  checkbox: (done) => ({ width: '16px', height: '16px', borderRadius: '4px', border: done ? 'none' : '1.5px solid #2a3a4c', background: done ? '#00e5b0' : 'transparent', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0, fontSize: '10px', color: '#07090f', fontWeight: 700 }),
  loading: { display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', height: '60vh', gap: '16px', color: '#6b7a99' },
  spinner: { width: '36px', height: '36px', border: '2px solid #1e2530', borderTop: '2px solid #00e5ff', borderRadius: '50%', animation: 'spin 0.8s linear infinite' },
};
