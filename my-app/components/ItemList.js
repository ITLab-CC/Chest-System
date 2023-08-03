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
            <button
              onClick={() => {
                fetch(apiURL + '/items/' + item.id, {
                  method: 'DELETE',
                });
              }}
            >
              Delete
            </button>
          </a>
        </div>
      ))}
    </div>
  );
}
