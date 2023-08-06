'use client';
import { useState, useEffect } from 'react';
import KisteSelectionOverlay from '../../../components/KisteSelectionOverlay';
async function getItem(itemID) {
  const res = await fetch('http://localhost:8000/api/v1/items/' + itemID);
  const data = await res.json();
  return data;
}

async function getItemsInKiste(itemID) {
  const res = await fetch(
    'http://localhost:8000/api/v1/items/' + itemID + '/kisten'
  );
  const data = await res.json();
  return data;
}

export default function Page({ params }) {
  const [item, setItem] = useState(null);
  const [kisten, setKisten] = useState([]);
  const [showKisteOverlay, setShowKisteOverlay] = useState(false);

  async function loadData() {
    getItem(params.id).then((item) => {
      console.log(item);
      setItem(item);
    });
    getItemsInKiste(params.id).then((kisten) => {
      console.log(kisten);
      setKisten(kisten);
    });
  }
  useEffect(() => {
    loadData();
  }, [params.id]);

  if (!item) {
    return <div>Loading...</div>;
  }
  return (
    <div>
      <h1>{item.name}</h1>
      <p>{item.description}</p>
      <h2>--In Kisten--</h2>
      <ul>
        {kisten.map((kiste) => (
          <li key={kiste.id}>
            {kiste.name} {kiste.anzahl}x
          </li>
        ))}
      </ul>
      <button
        onClick={() => {
          setShowKisteOverlay(true);
        }}
      >
        Add Item to Kiste
      </button>
      <br></br>
      {showKisteOverlay && (
        <KisteSelectionOverlay
          item={item}
          setShowKisteOverlay={setShowKisteOverlay}
          loadData={loadData}
        />
      )}
    </div>
  );
}
