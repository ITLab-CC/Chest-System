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
      <nav className='menu menu-1'>
        <ul>
          <li>
            <a href='/'>Home</a>
          </li>
        </ul>
      </nav>
      <div style={{ textAlign: 'center' }}>
        <h1
          style={{ fontSize: '3.125em', color: 'red', marginBottom: '0.25em' }}
        >
          {item.name}
        </h1>
        <p>{item.description}</p>
        <h1
          style={{
            fontSize: '1.875em',
            color: '#19e619',
            marginBottom: '0.25em',
          }}
        >
          In Chests
        </h1>
        <ul>
          {kisten.map((kiste) => (
            <li key={kiste.id}>
              {kiste.anzahl}x | {kiste.name}
            </li>
          ))}
        </ul>
        <button
          style={{
            color: 'black',
            padding: '0.625em 1.25em',
            marginBottom: '3.125em',
            marginTop: '1.25em',
          }}
          onClick={() => {
            setShowKisteOverlay(true);
          }}
        >
          Add or remove Item to Chest
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
    </div>
  );
}
