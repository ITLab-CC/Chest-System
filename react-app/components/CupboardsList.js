// CupboardsList Component

import React from 'react';
import { apiURL } from '../utils/constants';


export default function CupboardsList({ cupboards }) {
  return (
    <div>
      {cupboards.map((cupboard) => (
        <div
          key={cupboard.id}
          style={{ display: 'flex', justifyContent: 'center' }}
        >
          <div style={{ marginRight: '1.25em', paddingTop: '0.4em' }}>
            <a href={'/cupboards/' + cupboard.id}>
              <p>{cupboard.cupboard_name}</p>
              <small style={{ color: 'grey' }}>{cupboard.location}</small>
            </a>
          </div>
          <button
            style={{
              color: 'black',
              padding: '0.625em 1.25em',
              marginBottom: '1.25em',
            }}
            onClick={async () => {
              if (
                !window.confirm(
                  'Are you sure you want to delete ' + cupboard.cupboard_name + '?'
                )
              ) {
                return;
              }
              fetch(apiURL + '/cupboards/' + cupboard.id, {
                method: 'DELETE',
              })
                .then((res) => {
                  if (res.status !== 204) {
                    alert(
                      'Error deleting cupboard. Probably still has items in it.'
                    );
                    return;
                  }
                  window.location.reload();
                })
                .catch((err) => {
                  alert(
                    'Error deleting cupboard. Probably still has items in it.'
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
