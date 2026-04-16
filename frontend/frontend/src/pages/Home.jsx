import { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import './Home.css';

function Home({darkMode, setDarkMode}) {
  const [expedientes, setExpedientes] = useState([]);
  const [busqueda, setBusqueda] = useState('');
  const [filtroEstado, setFiltroEstado] = useState('Todos');
 
  const navigate = useNavigate();

  useEffect(() => {
    axios.get('http://localhost:3000/expedientes/full')
      .then(res => setExpedientes(res.data))
      .catch(err => console.error(err));
  }, []);

  const calcularEstado = (exp) => {
    const ultimaFase = exp.fases[exp.fases.length - 1];
    return ultimaFase?.nombre === 'Resolución';
  };

  // 📊 STATS
  const total = expedientes.length;
  const finalizados = expedientes.filter(calcularEstado).length;
  const enProceso = total - finalizados;

  // 🔍 FILTRO
  const filtrados = expedientes.filter(exp => {
    const finalizado = calcularEstado(exp);

    const coincideBusqueda =
      exp.numero.toString().includes(busqueda) ||
      exp.tipo.toLowerCase().includes(busqueda.toLowerCase());

    const coincideEstado =
      filtroEstado === 'Todos' ||
      (filtroEstado === 'Finalizado' && finalizado) ||
      (filtroEstado === 'En proceso' && !finalizado);

    return coincideBusqueda && coincideEstado;
  });

  return (
    <div className={`home-container ${darkMode ? 'dark' : ''}`}>

      {/* HEADER */}
      <div className="header">
        <h1>📁 Sistema de Expedientes</h1>

        <div className="acciones">
          <button onClick={() => setDarkMode(!darkMode)}>
            {darkMode ? '☀️' : '🌙'}
          </button>
        </div>
      </div>

      {/* 📊 STATS */}
      <div className="stats">
        <div className="stat-card">
          <h3>{total}</h3>
          <p>Total</p>
        </div>
        <div className="stat-card yellow">
          <h3>{enProceso}</h3>
          <p>En proceso</p>
        </div>
        <div className="stat-card green">
          <h3>{finalizados}</h3>
          <p>Finalizados</p>
        </div>
      </div>

      {/* 🎯 FILTROS */}
      <div className="filtros">

        <input
          type="text"
          placeholder="Buscar por tipo(ordinario, especial, etc) ó por numero ..."
          value={busqueda}
          onChange={(e) => setBusqueda(e.target.value)}
        />

        <div className="chips">
          {['Todos', 'En proceso', 'Finalizado'].map(f => (
            <button
              key={f}
              className={filtroEstado === f ? 'chip active' : 'chip'}
              onClick={() => setFiltroEstado(f)}
            >
              {f}
            </button>
          ))}
        </div>
      </div>

      {/* CARDS */}
      <div className="cards-container">
        {filtrados.map(exp => {
          const finalizado = calcularEstado(exp);
          const ultimaFase = exp.fases[exp.fases.length - 1];

          return (
            <div
              key={exp.id}
              className={`card ${finalizado ? 'finalizado' : 'proceso'}`}
              onClick={() => navigate(`/expediente/${exp.id}`)}
            >
              <div className="card-header">
                <h3>#{exp.numero}/{exp.anio}</h3>
                <span className={`badge ${finalizado ? 'green' : 'yellow'}`}>
                  {finalizado ? 'Finalizado' : 'En proceso'}
                </span>
              </div>

              <p className="tipo">{exp.tipo}</p>
              <p className="accion">{exp.accion_principal}</p>

              <div className="card-footer">
                <p className="fase">{ultimaFase?.nombre}</p>
                <p className="resolucion">
                  {finalizado ? exp.resolucion : 'Pendiente'}
                </p>
              </div>
            </div>
          );
        })}
      </div>

    </div>
  );
}

export default Home;