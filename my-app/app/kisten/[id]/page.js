'use client';
import { useState, useEffect } from 'react';
import ProductSelectionOverlay from '../../../components/ProductSelectionOverlay';

async function getKiste(kistenID) {
  const res = await fetch('http://localhost:8000/api/v1/kisten/' + kistenID);
  const data = await res.json();
  return data;
}

async function getItemsInKiste(kistenID) {
  const res = await fetch(
    'http://localhost:8000/api/v1/kisten/' + kistenID + '/items'
  );
  const data = await res.json();
  return data;
}

export default function Page({ params }) {
  const [kiste, setKiste] = useState(null);
  const [itemsInKiste, setItemsInKiste] = useState([]);
  const [showProductOverlay, setShowProductOverlay] = useState(false);

  async function loadData() {
    getKiste(params.id).then((item) => {
      console.log(item);
      setKiste(item);
    });
    getItemsInKiste(params.id).then((items) => {
      console.log(items);
      setItemsInKiste(items);
    });
  }

  useEffect(() => {
    loadData();
  }, [params.id]);

  if (!kiste) {
    return <div>Loading...</div>;
  }
  return (
    <div>
      <h1>{kiste.id}</h1>
      <p>{kiste.name}</p>
      <h2>--Items in Kiste--</h2>
      <ul>
        {itemsInKiste.map((item) => (
          <li key={item.id}>
            {item.name}: {item.anzahl}x
          </li>
        ))}
      </ul>
      <button
        onClick={() => {
          setShowProductOverlay(true);
        }}
      >
        Add Item
      </button>
      <br></br>
      {showProductOverlay && (
        <ProductSelectionOverlay
          kiste={kiste}
          setShowProductOverlay={setShowProductOverlay}
          loadData={loadData}
        />
      )}
    </div>
  );
}
