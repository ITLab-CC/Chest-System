import { useState, useEffect } from 'react';
import { addProductToKiste, getProducts } from '@/utils/api';

export default function ProductSelectionOverlay({
  kiste,
  setShowProductOverlay,
  loadData,
}) {
  const [products, setProducts] = useState([]);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [anzahl, setAnzahl] = useState(1);
  const [searchTerm, setSearchTerm] = useState(''); //Suche möglich
  const filteredProducts = products.filter((product) =>
    product.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  useEffect(() => {
    getProducts().then((products) => {
      setProducts(products);
    });
  }, []);

  return (
    <div>
      <h2
        style={{ fontSize: '1.875em', color: 'orange', marginBottom: '0.25em' }}
      >
        Select Product
      </h2>
      <input
        placeholder='Search items...'
        style={{ padding: '0.625em 1.25em', marginBottom: '1.25em' }}
        type='text'
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
      />
      <ul>
        {filteredProducts.map((product) => (
          <li
            key={product.id}
            onClick={() => {
              setSelectedProduct(product);
            }}
            style={{
              marginBottom: '0.9375em',
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
        style={{ padding: '0.625em 1.25em', marginTop: '1.25em' }}
        type='number'
        value={anzahl}
        onChange={(e) => {
          setAnzahl(e.target.value);
        }}
      />
      <button
        style={{
          color: 'black',
          padding: '0.625em 1.25em',
          marginTop: '1.25em',
          marginBottom: '1.25em',
        }}
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
