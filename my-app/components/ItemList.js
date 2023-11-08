// ItemList Component

import React from 'react';
import { apiURL } from '../utils/constants';

export default function ItemList({ items }) {
  return (
    <div>
      {items.map((item) => (
        <div
          key={item.id}
          style={{ display: 'flex', justifyContent: 'center' }}
        >
          <div style={{ marginRight: '1.25em', paddingTop: '0.4em'  }}>
            <a href={'/items/' + item.id}>
              <p>{item.name}</p>
              <p>{item.description}</p>
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
                  'Are you sure you want to delete ' + item.name + '?'
                )
              ) {
                return;
              }
              fetch(apiURL + '/items/' + item.id, {
                method: 'DELETE',
              })
                .then((res) => {
                  if (res.status === 409) {
                    alert('Error deleting item. Probably still in a chest.');
                    return;
                  }
                  window.location.reload();
                })
                .catch((err) => {
                  alert('Error deleting item. Probably still in a chest.');
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
