'use client';
import { useState, useEffect } from 'react';
import KisteSelectionOverlay from '../../../components/KisteSelectionOverlay';
import { Loader } from '../../../components/loader';
import { apiURL } from '../../../utils/constants';
import { PlusOrMinusButton } from '../../../components/PlusOrMinusButton';

async function getItemsJoinedWithKiste(itemID) {
  const res = await fetch(apiURL + '/items/' + itemID + '/chests');
  const data = await res.json();
  return data;
}

export default function Page({ params }) {
  const [itemJoined, setItemJoined] = useState(null);
  // const [kisten, setKisten] = useState([]);
  const [showKisteOverlay, setShowKisteOverlay] = useState(false);
  const [loading, setLoading] = useState(true);
  const [editMode, setEditMode] = useState(false);

  async function loadData() {
    setLoading(true);
    getItemsJoinedWithKiste(params.id).then((item) => {
      console.log(item);
      setItemJoined(item);
    });
    setLoading(false);
  }
  useEffect(() => {
    loadData();
  }, [params.id]);

  if (!itemJoined || loading) {
    return <Loader />;
  }

  function updateItemAnzahlAfterButtonClick(item, plus = false) {
    let newItemJoined = {
      ...itemJoined,
      chests: itemJoined.chests.map((i) => {
        if (i.kiste_id === item.kiste_id) {
          if (plus) {
            i.anzahl = i.anzahl + 1;
          } else {
            i.anzahl = i.anzahl - 1;
          }
        }
        return i;
      }),
    };
    setItemJoined(newItemJoined);
  }

  return (
    <div>
      <nav className='menu menu-1'>
        <ul>
          <li>
            <a href='/'>Home</a>
          </li>
        </ul>
      </nav>
      <div style={{ textAlign: 'center' }}>
        <section style={{ textAlign: 'center' }}>
          {editMode === false ? (
            <div>
              <h1 style={{ fontSize: '3.125em', color: 'red' }}>
                {itemJoined.name}
              </h1>
              <h2 style={{ color: 'grey', marginBottom: '1em' }}>
                {itemJoined.description}
              </h2>
            </div>
          ) : (
            <div>
              <input
                style={{
                  padding: '0.625em 1.25em',
                  marginBottom: '1.25em',
                }}
                type='text'
                value={itemJoined.name}
                onChange={(e) => {
                  setItemJoined({ ...itemJoined, name: e.target.value });
                }}
              />
              <input
                style={{
                  padding: '0.625em 1.25em',
                  marginBottom: '1.25em',
                }}
                type='text'
                value={itemJoined.description}
                onChange={(e) => {
                  setItemJoined({ ...itemJoined, description: e.target.value });
                }}
              />
            </div>
          )}
          {/* Edit Mode Button */}
          <button
            style={{
              color: 'black',
              padding: '0.625em 1.25em',
              marginBottom: '1.25em',
            }}
            onClick={async () => {
              if (editMode === false) {
                setEditMode(true);
              }
              if (editMode === true) {
                setEditMode(false);
                // Save changes
                await fetch(apiURL + '/items/' + itemJoined.id, {
                  method: 'PUT',
                  headers: {
                    'Content-Type': 'application/json',
                  },
                  body: JSON.stringify(itemJoined),
                }).then((res) => {
                  if (res.status !== 200) {
                    alert('Error updating item.');
                    return;
                  }
                  loadData();
                });
              }
            }}
          >
            {editMode === false ? 'Edit' : 'Save'}
          </button>
        </section>
        <h1
          style={{
            fontSize: '1.875em',
            color: '#19e619',
            marginBottom: '0.25em',
          }}
        >
          In Chests
        </h1>
        <ul>
          {itemJoined.chests.map((kiste) => (
            <li key={kiste.kiste_id}>
              <PlusOrMinusButton
                itemId={itemJoined.id}
                chestId={kiste.kiste_id} 
                plus={false}
                callback={() => {
                  updateItemAnzahlAfterButtonClick(kiste, false);
                }}
              /> 
              {kiste.anzahl}x | <a className='chest-item-link' href={"/kisten/" + kiste.kiste_id}>{kiste.kiste_name}</a>
              <PlusOrMinusButton
                itemId={itemJoined.id}
                chestId={kiste.kiste_id}
                plus={true}
                callback={() => {
                  updateItemAnzahlAfterButtonClick(kiste, true);
                }}
              />
            </li>
          ))}
        </ul>
        <details>
          <summary
            style={{ margin: 'auto', marginTop: '1.25em' }}
            onClick={() => {
              setShowKisteOverlay(true);
            }}
          >
            Add or remove product
          </summary>

          <br></br>
          {showKisteOverlay && (
            <KisteSelectionOverlay
              item={itemJoined}
              setShowKisteOverlay={setShowKisteOverlay}
              loadData={loadData}
            />
          )}
        </details>
      </div>
    </div>
  );
}
