import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const CATEGORIES = ['all', "men's clothing", "women's clothing", 'electronics', 'jewelery'];

export default function TechneuralAI() {
  const [products, setProducts] = useState([]);
  const [filtered, setFiltered] = useState([]);
  const [activeCategory, setActiveCategory] = useState('all');
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    fetch('https://fakestoreapi.com/products')
      .then(res => res.json())
      .then(data => { setProducts(data); setFiltered(data); setLoading(false); })
      .catch(() => setLoading(false));
  }, []);

  const handleFilter = (cat) => {
    setActiveCategory(cat);
    setFiltered(cat === 'all' ? products : products.filter(p => p.category === cat));
  };

  const stars = (r) => '★'.repeat(Math.round(r)) + '☆'.repeat(5 - Math.round(r));

  return (
    <div style={S.root}>
      <header style={S.header}>
        <button style={S.back} onClick={() => navigate('/')}>← Back</button>
        <div style={S.logo}>TechneuralAI</div>
        <span style={S.badge}>{filtered.length} Products</span>
      </header>
      <div style={S.filterBar}>
        {CATEGORIES.map(cat => (
          <button key={cat} style={S.filterBtn(activeCategory === cat)} onClick={() => handleFilter(cat)}>
            {cat}
          </button>
        ))}
      </div>
      {loading ? (
        <div style={S.loading}><div style={S.spinner} /><span>Loading...</span></div>
      ) : (
        <div style={S.grid}>
          {filtered.map(p => (
            <div key={p.id} style={S.card}
              onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-4px)'}
              onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
              <div style={S.imgWrap}><img src={p.image} alt={p.title} style={S.img} /></div>
              <div style={S.cardBody}>
                <div style={S.category}>{p.category}</div>
                <div style={S.title}>{p.title}</div>
                <div style={S.footer}>
                  <div style={S.price}>${p.price}</div>
                  <div style={S.rating}><span style={S.stars}>{stars(p.rating.rate)}</span><br />({p.rating.count})</div>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

const S = {
  root: { fontFamily: "'Inter', sans-serif", background: '#0a0a0a', minHeight: '100vh', color: '#fff' },
  header: { borderBottom: '1px solid #222', padding: '20px 40px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', position: 'sticky', top: 0, background: '#0a0a0a', zIndex: 100 },
  back: { background: 'transparent', border: '1px solid #333', color: '#888', padding: '7px 16px', borderRadius: '8px', cursor: 'pointer', fontSize: '0.85rem' },
  logo: { fontFamily: 'sans-serif', fontSize: '1.4rem', fontWeight: 800, color: '#ff3c00', letterSpacing: '1px' },
  badge: { background: '#ff3c00', color: '#fff', borderRadius: '20px', padding: '4px 14px', fontSize: '0.78rem' },
  filterBar: { padding: '16px 40px', display: 'flex', gap: '10px', flexWrap: 'wrap', borderBottom: '1px solid #1a1a1a' },
  filterBtn: (a) => ({ padding: '7px 18px', borderRadius: '20px', border: a ? '1px solid #ff3c00' : '1px solid #333', background: a ? '#ff3c00' : 'transparent', color: a ? '#fff' : '#888', cursor: 'pointer', fontSize: '0.82rem', textTransform: 'capitalize' }),
  grid: { display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '20px', padding: '30px 40px' },
  card: { background: '#111', border: '1px solid #1e1e1e', borderRadius: '12px', overflow: 'hidden', transition: 'transform 0.2s', cursor: 'pointer' },
  imgWrap: { background: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', height: '180px', padding: '16px' },
  img: { maxHeight: '150px', maxWidth: '100%', objectFit: 'contain' },
  cardBody: { padding: '14px' },
  category: { fontSize: '0.7rem', color: '#ff3c00', textTransform: 'uppercase', letterSpacing: '1.5px', marginBottom: '6px', fontWeight: 600 },
  title: { fontSize: '0.85rem', color: '#e0e0e0', marginBottom: '10px', lineHeight: 1.4, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' },
  footer: { display: 'flex', justifyContent: 'space-between', alignItems: 'center' },
  price: { fontSize: '1.2rem', fontWeight: 800, color: '#fff' },
  rating: { fontSize: '0.75rem', color: '#666', textAlign: 'right' },
  stars: { color: '#f5c518' },
  loading: { display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', height: '60vh', gap: '16px', color: '#444' },
  spinner: { width: '36px', height: '36px', border: '3px solid #222', borderTop: '3px solid #ff3c00', borderRadius: '50%', animation: 'spin 0.8s linear infinite' },
};
