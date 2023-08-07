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
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState(''); //Suche möglich
  const [searchChestTerm, setSearchChestTerm] = useState(''); //Suche Kisten möglich


  async function getData() {
    setLoading(true);
    const resKisten = await fetch(apiURL + '/kisten');
    const kisten = await resKisten.json();
    setKisten(kisten);
    const res = await fetch(apiURL + '/items');
    const data = await res.json();
    setItems(data);
    setLoading(false);
  }

  useEffect(() => {
    getData();
  }, []);

  if (loading) {
    return <Loader />;
  }

  const filteredItems = items.filter(item =>
    item.name.toLowerCase().includes(searchTerm.toLowerCase())
  );
  const filteredKisten = kisten.filter(kiste =>
    kiste.name.toLowerCase().includes(searchChestTerm.toLowerCase())
  );

  return (
    <div>
      {/* Menu Bar */}
      <div style={{ backgroundColor: 'black', color: 'white', padding: '10px 0', textAlign: 'center' }}>
        <a href="#">Main</a> |
        <a href="#">Chests</a> |
        <a href="#">Items</a>
      </div>
    <div style={{ width: 'fit-content', height: 'fit-content', textAlign: 'center' }}>
      <h1 style={{fontSize: "40px", color: "green"}}>Chests</h1>
      <input
      placeholder='Search chests...'
      style={{ padding: '10px 20px', marginBottom: '20px' }}
      type='text'
      value={searchChestTerm}
      onChange={(e) => setSearchChestTerm(e.target.value)}
      />
      <KistenList kisten={filteredKisten} />
      <input
        placeholder='chestname'
        style={{ padding: '10px 20px' }}
        type='text'
        value={nameKiste}
        onChange={(e) => setNameKiste(e.target.value)}
      />
      <button
        style={{ color: 'black', padding: '10px 20px' , marginBottom: '50px'}}
        onClick={async () => {
          // Post to /kisten with query params
          await fetch(
            apiURL + '/kisten?' + new URLSearchParams({ name: nameKiste }),
            {
              method: 'POST', 
            }
          );
          setNameKiste('');
          getData();
        }}
      >
        Add Chests
      </button>
    </div>

    <div style={{textAlign: 'center'}}> 
      <h1 style={{fontSize: "40px", color: "red"}}>Items</h1>

       <input
        placeholder='Search items...'
        style={{ padding: '10px 20px', marginBottom: '20px'}}
        type='text'
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
      />
      <ItemList items={filteredItems} />

      <input
        placeholder='itemname'
        style={{ padding: '10px 20px'}}
        type='text'
        value={nameGegenstand}
        onChange={(e) => setNameGegenstand(e.target.value)}
      />
      <input
        placeholder='item-id'
        style={{ padding: '10px 20px' }}
        type='text'
        value={descriptionGegenstand}
        onChange={(e) => setDescriptionGegenstand(e.target.value)}
      />
      <button
        style={{ color: 'black', padding: '10px 20px' }}
        onClick={async () => {
          await fetch(
            apiURL +
              '/items?' +
              new URLSearchParams({
                name: nameGegenstand,
                description: descriptionGegenstand,
              }),
            {
              method: 'POST',
            }
          );
          setNameGegenstand('');
          setDescriptionGegenstand('');
          getData();
        }}
      >
        Add Item
        
      </button> 
    </div>
    <div style={{textAlign: 'center',  marginTop: '150px'}}>
  <h2>How to use the website:</h2>
  <h3>Chests:</h3>
  <ul>
    <li> Use the search bar above to find chests by name. Type in the chest name, and the list will automatically filter.</li>
    <li>To add a new chest, enter the chest name in the input field and click the "Add Chests" button. The chest will be added to the list.</li>
  </ul>
  <h3>Items:</h3>
  <ul>
    <li>Use the search bar above to find items by name. Type in the item name, and the list will automatically filter.</li>
    <li>To add a new item, enter the item name and item description in the respective input fields, and click the "Add Item" button. The item will be added to the list.</li>
  </ul>
  <h3>Navigation:</h3>
  <ul>
    <li>Use the menu bar at the top to navigate between different sections of the website.</li>
  </ul>
</div>
    </div>
  );
}
