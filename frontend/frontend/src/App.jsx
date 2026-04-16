import { Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import Detalle from './pages/Detalle';

import { useState, useEffect } from 'react';

function App() {
  const [darkMode, setDarkMode] = useState(false);

  useEffect(() => {
    const saved = localStorage.getItem('darkMode');
    if (saved === 'true') setDarkMode(true);
  }, []);

  useEffect(() => {
    localStorage.setItem('darkMode', darkMode);
    document.body.className = darkMode ? 'dark' : '';
  }, [darkMode]);

  return (
    <>
      {/* pasa prop a Home */}
      <Routes>
        <Route path="/" element={<Home darkMode={darkMode} setDarkMode={setDarkMode} />} />
        <Route path="/expediente/:id" element={<Detalle />} />
      </Routes>
    </>
  );
}

export default App;