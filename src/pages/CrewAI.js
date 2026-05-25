import React, { useEffect, useState } from 'react';

const COLORS = ['#1a1aff', '#ff3c8e', '#00c2a8', '#f59e0b', '#8b5cf6', '#ef4444', '#10b981', '#3b82f6', '#f97316', '#ec4899'];
const getInitials = (name) => name.split(' ').map(n => n[0]).join('').toUpperCase();

export default function CrewAI() {
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    fetch('https://jsonplaceholder.typicode.com/users')
      .then(res => res.json())
      .then(data => { setUsers(data); setLoading(false); })
      .catch(() => setLoading(false));
  }, []);

  const filtered = users.filter(u =>
    u.name.toLowerCase().includes(search.toLowerCase()) ||
    u.email.toLowerCase().includes(search.toLowerCase()) ||
    u.company.name.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div style={S.root}>
      <header style={S.header}>
        <button style={S.back} onClick={() => navigate('/')}>← Back</button>
        <div style={S.logo}>CrewAI</div>
        <span style={S.badge}>{filtered.length} Users</span>
      </header>
      <div style={S.searchWrap}>
        <input style={S.search} placeholder="🔍  Search by name, email or company..." value={search} onChange={e => setSearch(e.target.value)} />
      </div>
      {loading ? (
        <div style={S.loading}><div style={S.spinner} /><span>Loading...</span></div>
      ) : (
        <div style={S.grid}>
          {filtered.map((user, i) => (
            <div key={user.id} style={S.card}
              onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-4px)'}
              onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
              <div style={S.avatarRow}>
                <div style={{ ...S.avatar, background: COLORS[i % COLORS.length] }}>{getInitials(user.name)}</div>
                <div>
                  <div style={S.name}>{user.name}</div>
                  <div style={S.username}>@{user.username}</div>
                </div>
              </div>
              <div style={S.divider} />
              <div style={S.infoRow}><span>✉</span>{user.email}</div>
              <div style={S.infoRow}><span>📞</span>{user.phone}</div>
              <div style={S.infoRow}><span>🌐</span>{user.website}</div>
              <div style={S.infoRow}><span>📍</span>{user.address.city}</div>
              <div style={S.tag}>🏢 {user.company.name}</div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

const S = {
  root: { fontFamily: "'Inter', sans-serif", background: '#f0f4ff', minHeight: '100vh' },
  header: { background: '#1a1aff', padding: '20px 40px', display: 'flex', alignItems: 'center', justifyContent: 'space-between' },
  back: { background: 'rgba(255,255,255,0.2)', border: 'none', color: '#fff', padding: '7px 16px', borderRadius: '8px', cursor: 'pointer', fontSize: '0.85rem' },
  logo: { fontSize: '1.4rem', fontWeight: 800, color: '#fff' },
  badge: { background: 'rgba(255,255,255,0.2)', color: '#fff', borderRadius: '20px', padding: '4px 14px', fontSize: '0.78rem' },
  searchWrap: { padding: '20px 40px', background: '#1a1aff' },
  search: { width: '100%', padding: '12px 18px', borderRadius: '8px', border: 'none', background: 'rgba(255,255,255,0.15)', color: '#fff', fontSize: '0.95rem', outline: 'none' },
  grid: { display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '16px', padding: '30px 40px' },
  card: { background: '#fff', borderRadius: '14px', padding: '22px', boxShadow: '0 2px 12px rgba(26,26,255,0.06)', border: '1px solid #e8edff', transition: 'transform 0.2s' },
  avatarRow: { display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '14px' },
  avatar: { width: '44px', height: '44px', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 800, fontSize: '1rem', color: '#fff', flexShrink: 0 },
  name: { fontWeight: 700, fontSize: '0.95rem', color: '#0a0a2e' },
  username: { fontSize: '0.78rem', color: '#8888bb' },
  divider: { height: '1px', background: '#f0f0ff', margin: '12px 0' },
  infoRow: { display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.82rem', color: '#555', marginBottom: '6px' },
  tag: { display: 'inline-block', background: '#eef0ff', color: '#1a1aff', borderRadius: '6px', padding: '3px 10px', fontSize: '0.75rem', fontWeight: 600, marginTop: '8px' },
  loading: { display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', height: '60vh', gap: '16px', color: '#8888bb' },
  spinner: { width: '36px', height: '36px', border: '3px solid #e8edff', borderTop: '3px solid #1a1aff', borderRadius: '50%', animation: 'spin 0.8s linear infinite' },
};
