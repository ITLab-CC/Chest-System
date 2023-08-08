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
      <h2 style={{ fontSize: "30px", color: "#19e619", marginBottom: '20px' }}>Select Chest</h2>
      <ul>
        {kisten.map((product) => (
          <li
            key={product.id}
            onClick={() => {
              setSelectedKiste(product);
            }}
            style={{
              marginBottom: '20px',
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
        style={{padding: '10px 20px' , marginTop: '20px'}}
        type='number'
        value={anzahl}
        onChange={(e) => {
          setAnzahl(e.target.value);
        }}
      />
      <button
        style={{ color: 'black', padding: '10px 20px' }}
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
