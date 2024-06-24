'use client';
import Image from 'next/image';
import styles from './page.module.css';
import { useState, useEffect } from 'react';
import { apiURL } from '../utils/constants';
import KistenList from '../components/KistenList';
import ItemList from '../components/ItemList';
import { Loader } from '../components/loader';

export default function Home() {
  const [items, setItems] = useState([]);
  const [kisten, setKisten] = useState([]);
  const [nameGegenstand, setNameGegenstand] = useState('');
  const [descriptionGegenstand, setDescriptionGegenstand] = useState('');
  const [nameKiste, setNameKiste] = useState('');
  const [locationKiste, setLocationKiste] = useState('');
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState(''); //Suche möglich
  const [searchChestTerm, setSearchChestTerm] = useState(''); //Suche Kisten möglich

  const [scrollToEnd, setScrollToEnd] = useState(false);

  const [offset, setOffset] = useState(0);

  useEffect(() => {
      const onScroll = () => setOffset(window.scrollY);
      // clean up code
      window.removeEventListener('scroll', onScroll);
      window.addEventListener('scroll', onScroll, { passive: true });
      return () => window.removeEventListener('scroll', onScroll);
  }, []);

  async function getData() {
    setLoading(true);
    const resKisten = await fetch(apiURL + '/chests');
    const kisten = await resKisten.json();
    setKisten(kisten);
    const res = await fetch(apiURL + '/items');
    const data = await res.json();
    setItems(data);
    setLoading(false);
    console.log(data);
    console.log(kisten);
  }

  useEffect(() => {
    getData();
  }, []);

  if (loading) {
    return <Loader />;
  }

  const filteredItems = items.filter((item) =>
    item.name.toLowerCase().includes(searchTerm.toLowerCase())
  );
  const filteredKisten = kisten.filter((kiste) =>
    kiste.name.toLowerCase().includes(searchChestTerm.toLowerCase())
  );

  return (
    <div>
      <nav className='menu menu-1'>
        <ul>
          <li>
            <a href='/'>Home</a>
          </li>
        </ul>
      </nav>

      <div style={{ display: 'flex', justifyContent: 'space-evenly' }}>
        <div
          style={{
            width: 'fit-content',
            height: 'fit-content',
            textAlign: 'center',
          }}
        >
          <h1 style={{ fontSize: '2.5em', color: '#19e619' }}>Chests</h1>

          <input
            placeholder='Search chests...'
            style={{ padding: '0.625em 1.25em', marginBottom: '1.25em' }}
            type='text'
            value={searchChestTerm}
            onChange={(e) => setSearchChestTerm(e.target.value)}
          />
          <KistenList kisten={filteredKisten} />

          <input
            placeholder='chestname'
            style={{ padding: '0.625em 1.25em' }}
            type='text'
            value={nameKiste}
            onChange={(e) => setNameKiste(e.target.value)}
          />
          <input
            placeholder='chestLocation'
            style={{ padding: '0.625em 1.25em' }}
            type='text'
            value={locationKiste}
            onChange={(e) => setLocationKiste(e.target.value)}
          />
          <button
            style={{
              color: 'black',
              padding: '0.625em 1.25em',
              marginBottom: '3.125em',
            }}
            onClick={async () => {
              // Post to /chests with { name: nameKiste}
              await fetch(apiURL + '/chests', {
                method: 'POST',
                body: JSON.stringify({
                  name: nameKiste,
                  location: locationKiste,
                }),
                headers: {
                  'Content-Type': 'application/json',
                },
              });
              setNameKiste('');
              getData();
            }}
          >
            Add Chests
          </button>
        </div>
        <div
          style={{
            width: 'fit-content',
            height: 'fit-content',
            textAlign: 'center',
          }}
        >
          <h1 style={{ fontSize: '2.5em', color: 'red' }}>Items</h1>

          <input
            placeholder='Search items...'
            style={{ padding: '0.625em 1.25em', marginBottom: '1.25em' }}
            type='text'
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
          <ItemList items={filteredItems} />

          <input
            placeholder='itemname'
            style={{ padding: '0.625em 1.25em' }}
            type='text'
            value={nameGegenstand}
            onChange={(e) => setNameGegenstand(e.target.value)}
          />
          <input
            placeholder='descriptionGegenstand'
            style={{ padding: '0.625em 1.25em' }}
            type='text'
            value={descriptionGegenstand}
            onChange={(e) => setDescriptionGegenstand(e.target.value)}
          />
          <button
            style={{ color: 'black', padding: '0.625em 1.25em' }}
            onClick={async () => {
              await fetch(apiURL + '/items', {
                method: 'POST',
                body: JSON.stringify({
                  name: nameGegenstand,
                  description: descriptionGegenstand,
                }),
                headers: {
                  'Content-Type': 'application/json',
                },
              });
              setNameGegenstand('');
              setDescriptionGegenstand('');
              getData();
            }}
          >
            Add Item
          </button>
          <button
            style={{
              position: 'fixed',
              bottom: '20px',
              right: '20px',
              padding: '0.625em 1.25em',
              backgroundColor: '#19e619',
              color: 'white',
            }}
            onClick={() => {
              if(window.innerHeight + window.scrollY>= document.body.scrollHeight - 70) {
                window.scrollTo(0, 0);
              } else {
                window.scrollTo(0, document.body.scrollHeight);
              }
            }}
          >
            
            {(document.body.scrollHeight - 70 >= window.innerHeight + offset || offset == 0) ? "Scroll To End" : "Scroll To Top"}
          </button>
        </div>
      </div>
      <div className='centered-container'>
        <div className='content'>
          <h2>How to use the website:</h2>
          <h3>Chests:</h3>
          <ul>
            <li>
              {' '}
              Use the search bar above to find chests by name. Type in the chest
              name, and the list will automatically filter.
            </li>
            <li>
              To add a new chest, enter the chest name in the input field and
              click the "Add Chests" button. The chest will be added to the
              list.
            </li>
          </ul>
          <h3>Items:</h3>
          <ul>
            <li>
              Use the search bar above to find items by name. Type in the item
              name, and the list will automatically filter.
            </li>
            <li>
              To add a new item, enter the item name and item description in the
              respective input fields, and click the "Add Item" button. The item
              will be added to the list.
            </li>
          </ul>
          <h3>Navigation:</h3>
          <ul>
            <li>
              Use the menu bar at the top to navigate between different sections
              of the website.
            </li>
          </ul>
        </div>
      </div>
    </div>
  );
}
