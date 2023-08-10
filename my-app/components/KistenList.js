// KistenList Component

import React from 'react';
import { apiURL } from '../utils/constants';

export default function KistenList({ kisten }) {
  return (
    <div>
      {kisten.map((kiste) => (
        <div key={kiste.id} style={{display: 'flex', justifyContent: 'center'}}>
          <div style={{marginRight: '1.25em'}}>
            <a href={'/kisten/' + kiste.id}>
              <h3>{kiste.id}</h3>
              <p>{kiste.name}</p>
            </a>
            </div>
            <button
              style={{ color: 'black', padding: '0.625em 1.25em', marginBottom: '1.25em' }}
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
