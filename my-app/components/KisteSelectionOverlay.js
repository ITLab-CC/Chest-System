import { useState, useEffect } from 'react';
import { apiURL } from '@/utils/constants';

// async function getProducts() {
//   const res = await fetch(apiURL + '/items');
//   const data = await res.json();
//   return data;
// }

async function getKisten() {
  const res = await fetch(apiURL + '/kisten');
  const data = await res.json();
  return data;
}

async function addProductToKiste(kisteId, productId, anzahl) {
  await fetch(
    apiURL +
      '/kisten/' +
      kisteId +
      '/items?' +
      new URLSearchParams({ item_id: productId, anzahl: anzahl }),
    {
      method: 'POST',
    }
  );
}

export default function KisteSelectionOverlay({
  item,
  setShowKisteOverlay,
  loadData,
}) {
  const [kisten, setKisten] = useState([]);
  const [selectedKiste, setSelectedKiste] = useState(null);
  const [anzahl, setAnzahl] = useState(1);

  useEffect(() => {
    getKisten().then((products) => {
      setKisten(products);
    });
  }, []);

  return (
    <div>
      <h2 style={{ fontSize: "1.875em", color: "#19e619", marginBottom: '0.25em' }}>Select Chest</h2>
      <ul>
        {kisten.map((product) => (
          <li
            key={product.id}
            onClick={() => {
              setSelectedKiste(product);
            }}
            style={{
              marginBottom: '0.25em',
              backgroundColor:
                selectedKiste && selectedKiste.id === product.id
                  ? 'green'
                  : 'transparent',
            }}
          >
            {product.name}
          </li>
        ))}
      </ul>
      <h2>Amount</h2>
      <input
        placeholder='amount'
        style={{padding: '0.625em 1.25em' , marginTop: '1.25em'}}
        type='number'
        value={anzahl}
        onChange={(e) => {
          setAnzahl(e.target.value);
        }}
      />
      <button
        style={{ color: 'black', padding: '0.625em 1.25em', marginBottom: '1.25em' }}
        onClick={() => {
          if (selectedKiste) {
            addProductToKiste(selectedKiste.id, item.id, anzahl).then(() => {
              loadData();
              setShowKisteOverlay(false);
            });
          } else {
            window.alert('Please select a Chest');
          }
        }}
      >
        Add or remove Item
      </button>
    </div>
  );
}
