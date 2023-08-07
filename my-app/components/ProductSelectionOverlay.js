import { useState, useEffect } from 'react';
import { apiURL } from '@/utils/constants';

async function getProducts() {
  const res = await fetch(apiURL + '/items');
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

export default function ProductSelectionOverlay({
  kiste,
  setShowProductOverlay,
  loadData,
}) {
  const [products, setProducts] = useState([]);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [anzahl, setAnzahl] = useState(1);

  useEffect(() => {
    getProducts().then((products) => {
      setProducts(products);
    });
  }, []);

  return (
    <div>
      <h2 style={{ fontSize: "30px", color: "orange" }}>Select Product</h2>
      <ul>
        {products.map((product) => (
          <li
            key={product.id}
            onClick={() => {
              setSelectedProduct(product);
            }}
            style={{
              backgroundColor:
                selectedProduct && selectedProduct.id === product.id
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
        style={{padding: "10px 20px" }}
        type='number'
        value={anzahl}
        onChange={(e) => {
          setAnzahl(e.target.value);
        }}
      />
      <button
        style={{ color: "black", padding: "10px 20px" }}
        onClick={() => {
          if (selectedProduct) {
            addProductToKiste(kiste.id, selectedProduct.id, anzahl).then(() => {
              loadData();
              setShowProductOverlay(false);
            });
          } else {
            alert('Please select a product');
          }
        }}
      >
        Add Product
      </button>
    </div>
  );
}
