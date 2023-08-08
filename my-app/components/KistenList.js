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
          </a>
          <button
            style={{ color: 'black', padding: '10px 20px', marginBottom: '20px' }}
            onClick={async () => {
              fetch(apiURL + '/kisten/' + kiste.id, {
                method: 'DELETE',
              })
                .then((res) => {
                  if (res.status === 409) {
                    alert(
                      'Error deleting chest. Probably still has items in it.'
                    );
                    return;
                  }
                  window.location.reload();
                })
                .catch((err) => {
                  alert(
                    'Error deleting chest. Probably still has items in it.'
                  );
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
