// ItemList Component

import React from 'react';
import { apiURL } from '../utils/constants';

export default function ItemList({ items }) {
  return (
    <div>
      {items.map((item) => (
        <div key={item.id}>
          <a href={'/items/' + item.id}>
            <h3>{item.id}</h3>
            <p>{item.name}</p>
          </a>

          <button
            style={{ color: 'black', padding: '10px 20px' }}
            onClick={async () => {
              fetch(apiURL + '/items/' + item.id, {
                method: 'DELETE',
              })
                .then((res) => {
                  if (res.status === 409) {
                    alert('Error deleting item. Probably still in a kiste.');
                    return;
                  }
                  window.location.reload();
                })
                .catch((err) => {
                  alert('Error deleting item. Probably still in a kiste.');
                });
            }}
          >
            Delete
          </button>
        </div>
      ))}
    </div>
  );
}
