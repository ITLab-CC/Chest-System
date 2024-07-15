'use client';
import { useState, useEffect } from 'react';
import ProductSelectionOverlay from '../../../components/ProductSelectionOverlay';
import { Loader } from '../../../components/loader';
import { apiURL } from '../../../utils/constants';
import { PlusOrMinusButton } from '../../../components/PlusOrMinusButton';

async function getKistenJoinedWithItems(kistenID) {
  const res = await fetch(apiURL + '/chests/' + kistenID + '/items');
  const data = await res.json();
  return data;
}

export default function Page({ params }) {
  const [kisteWithItems, setKisteWithItems] = useState(null);
  const [showProductOverlay, setShowProductOverlay] = useState(false);
  const [loading, setLoading] = useState(true);
  const [editMode, setEditMode] = useState(false);

  async function loadData() {
    setLoading(true);
    getKistenJoinedWithItems(params.id).then((item) => {
      console.log(item);
      setKisteWithItems(item);
    });
    setLoading(false);
  }

  useEffect(() => {
    loadData();
  }, [params.id]);

  if (!kisteWithItems) {
    return <Loader />;
  }

  function updateItemAnzahlAfterButtonClick(item, plus = false) {
    let newKisteWithItems = {
      ...kisteWithItems,
      items: kisteWithItems.items.map((i) => {
        if (i.item_id === item.item_id) {
          if (plus) {
            i.anzahl = i.anzahl + 1;
          } else {
            i.anzahl = i.anzahl - 1;
          }
        }
        return i;
      }),
    };
    setKisteWithItems(newKisteWithItems);
  }

  return (
    <div>
      <div>
        <nav className='menu menu-1'>
          <ul>
            <li>
              <a href='/'>Home</a>
            </li>
            <li>
              <a href='/cupboards'>Cupboards</a>
            </li>
          </ul>
        </nav>
      </div>
      <div style={{ textAlign: 'center' }}>
        <section style={{ textAlign: 'center' }}>
          {editMode === false ? (
            <div>
              <h1 style={{ fontSize: '1.75em' }}>{kisteWithItems.name}</h1>
              <h2 style={{ color: 'grey', marginBottom: '1em' }}>
                {kisteWithItems.location}
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
                value={kisteWithItems.name}
                onChange={(e) => {
                  setKisteWithItems({
                    ...kisteWithItems,
                    name: e.target.value,
                  });
                }}
              />
              <input
                style={{
                  padding: '0.625em 1.25em',
                  marginBottom: '1.25em',
                }}
                type='text'
                value={kisteWithItems.location}
                onChange={(e) => {
                  setKisteWithItems({
                    ...kisteWithItems,
                    location: e.target.value,
                  });
                }}
              />
            </div>
          )}
        </section>
        <button
          style={{
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
              await fetch(apiURL + '/chests/' + kisteWithItems.id, {
                method: 'PUT',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                  name: kisteWithItems.name,
                  location: kisteWithItems.location,
                }),
              }).then((res) => {
                if (res.status !== 200) {
                  alert('Error updating chest');
                  return;
                }
                loadData();
              });
            }
          }}
        >
          {editMode === false ? 'Edit' : 'Save'}
        </button>

        {/* <h1 style={{ fontSize: '1.75em' }}>{kisteWithItems.name}</h1>
        <h2 style={{ color: 'grey', marginBottom: '1em' }}>
          {kisteWithItems.location}
        </h2> */}

        <h1
          style={{
            fontSize: '1.5em',
            color: '#19e619',
            marginBottom: '0.25em',
          }}
        >
          Items in Chest
        </h1>
        <ul>
          {kisteWithItems.items.map((item) => (
            <li style={{ padding: '0.3125em' }} key={item.item_id}>
              <PlusOrMinusButton
                chestId={kisteWithItems.id}
                itemId={item.item_id}
                plus={false}
                callback={() => {
                  updateItemAnzahlAfterButtonClick(item, false);
                }}
              />
               <a className='chest-item-link' href={"/items/" + item.item_id}>{item.item_name}</a>: {item.anzahl}x
              <PlusOrMinusButton
                chestId={kisteWithItems.id}
                itemId={item.item_id}
                plus={true}
                callback={() => {
                  updateItemAnzahlAfterButtonClick(item, true);
                }}
              />
            </li>
          ))}
        </ul>
        <details>
          <summary
            style={{ margin: 'auto', marginTop: '1.25em' }}
            onClick={() => {
              setShowProductOverlay(true);
            }}
          >
            Add or remove product
          </summary>

          <br></br>
          {showProductOverlay && (
            <ProductSelectionOverlay
              kiste={kisteWithItems}
              setShowProductOverlay={setShowProductOverlay}
              loadData={loadData}
            />
          )}
        </details>
      </div>
    </div>
  );
}
