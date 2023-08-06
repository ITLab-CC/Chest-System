'use client';
import { useState, useEffect } from 'react';
import KisteSelectionOverlay from '../../../components/KisteSelectionOverlay';
import { Loader } from '../../../components/loader';
import { apiURL } from '../../../utils/constants';

async function getItem(itemID) {
  const res = await fetch(apiURL + '/items/' + itemID);
  const data = await res.json();
  return data;
}

async function getItemsInKiste(itemID) {
  const res = await fetch(apiURL + '/items/' + itemID + '/kisten');
  const data = await res.json();
  return data;
}

export default function Page({ params }) {
  const [item, setItem] = useState(null);
  const [kisten, setKisten] = useState([]);
  const [showKisteOverlay, setShowKisteOverlay] = useState(false);
  const [loading, setLoading] = useState(true);

  async function loadData() {
    setLoading(true);
    getItem(params.id).then((item) => {
      console.log(item);
      setItem(item);
    });
    getItemsInKiste(params.id).then((kisten) => {
      console.log(kisten);
      setKisten(kisten);
    });
    setLoading(false);
  }
  useEffect(() => {
    loadData();
  }, [params.id]);

  if (!item) {
    return <Loader />;
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
