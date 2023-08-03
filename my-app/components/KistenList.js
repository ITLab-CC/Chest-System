// KistenList Component

import React from 'react';
import { apiURL } from '../utils/constants';

export default function KistenList({ kisten }) {
  return (
    <div>
      {kisten.map((kiste) => (
        <div key={kiste.id}>
          <a href={'/kisten/' + kiste.id}>
            <h3>{kiste.id}</h3>
            <p>{kiste.name}</p>
            <button
              onClick={() => {
                fetch(apiURL + '/kisten/' + kiste.id, {
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
