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
            <button style={{color: "black",
                            padding:"10px 20px",}}
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
