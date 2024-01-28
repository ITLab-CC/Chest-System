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
        <h1
          style={{ fontSize: '3.125em', color: 'red', marginBottom: '0.25em' }}
        >
          {itemJoined.name}
        </h1>
        <p>{itemJoined.description}</p>
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
              {kiste.anzahl}x | {kiste.kiste_name}
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
