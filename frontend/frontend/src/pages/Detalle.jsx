import { useEffect, useState } from 'react';
import axios from 'axios';
import { useParams, useNavigate } from 'react-router-dom';
import './Detalle.css';

function Detalle() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [expediente, setExpediente] = useState(null);

  useEffect(() => {
    axios.get('http://localhost:3000/expedientes/full')
      .then(res => {
        const encontrado = res.data.find(e => e.id == id);
        setExpediente(encontrado);
      })
      .catch(err => console.error(err));
  }, [id]);

  if (!expediente) return <p>Cargando...</p>;

  const fasesOrdenadas = [...expediente.fases].sort(
    (a, b) => new Date(a.fecha) - new Date(b.fecha)
  );

  const ultimaFase = fasesOrdenadas[fasesOrdenadas.length - 1];
  const finalizado = ultimaFase?.nombre === 'Resolución';

  return (
    <div className="detalle-container">

      {/* 🔙 HEADER */}
      <div className="detalle-header">
        <button className="btn-back" onClick={() => navigate(-1)}>
          ← Volver
        </button>

        <div>
          <h1>Expediente #{expediente.numero}/{expediente.anio}</h1>
          <span className={`badge ${finalizado ? 'green' : 'yellow'}`}>
            {finalizado ? 'Finalizado' : 'En proceso'}
          </span>
        </div>
      </div>

      {/* 🔥 TIMELINE LIMPIO */}
      <div className="timeline-container">

        <div className="timeline">
          {fasesOrdenadas.map((fase, index) => {
            const esActual = fase.id === ultimaFase.id;
            const completado = new Date(fase.fecha) <= new Date(ultimaFase.fecha);

            return (
              <div key={fase.id} className="step">
                <div className={`dot ${completado ? 'done' : ''} ${esActual ? 'active' : ''}`} />
                <span>{fase.nombre}</span>
              </div>
            );
          })}
        </div>

        <p className="estado-texto">
          Estado actual: <strong>{ultimaFase.nombre}</strong>
        </p>

      </div>

      {/* INFO */}
      <div className="grid">

        <div className="card">
          <h2>Información General</h2>
          <p><strong>Tipo:</strong> {expediente.tipo}</p>
          <p><strong>Acción:</strong> {expediente.accion_principal}</p>
          <p>
            <strong>Resolución:</strong>{' '}
            {finalizado ? expediente.resolucion : 'Pendiente'}
          </p>
        </div>

        <div className="card">
          <h2>Audiencia</h2>
          <p>
            {expediente.sala || 'Por asignar'} - {expediente.fecha} {expediente.hora}
          </p>
          <p><strong>Juez:</strong> {expediente.juez || 'Por asignar'}</p>
          <p><strong>Especialista:</strong> {expediente.especialista || 'Por asignar'}</p>
        </div>

        <div className="card">
          <h2>Involucrados</h2>
          <p><strong>Actores:</strong> {expediente.actores.join(', ')}</p>
          <p><strong>Demandados:</strong> {expediente.demandados.join(', ')}</p>
          <p><strong>Defensores:</strong> {expediente.defensores.join(', ')}</p>
          <p>
            <strong>Representantes:</strong>{' '}
            {expediente.representantes.length
              ? expediente.representantes.join(', ')
              : 'N/A'}
          </p>
        </div>

        <div className="card">
          <h2>Seguimiento</h2>
          <ul>
            {fasesOrdenadas.map(f => (
              <li key={f.id}>
                {f.fecha} - {f.nombre}
              </li>
            ))}
          </ul>
        </div>

      </div>

    </div>
  );
}

export default Detalle;