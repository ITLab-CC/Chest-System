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
          </ul>
        </nav>
      </div>
      <div style={{ textAlign: 'center' }}>
        <h1 style={{ fontSize: '1.75em' }}>{kisteWithItems.name}</h1>
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
              {item.item_name}: {item.anzahl}x
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
