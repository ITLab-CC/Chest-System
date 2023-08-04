'use client';
import Image from 'next/image';
import styles from './page.module.css';
import { useState, useEffect } from 'react';
import { apiURL } from '../utils/constants';
import KistenList from '../components/KistenList';
import ItemList from '../components/ItemList';
export default function Home() {
  const [items, setItems] = useState([]);
  const [kisten, setKisten] = useState([]);
  const [nameGegenstand, setNameGegenstand] = useState('');
  const [descriptionGegenstand, setDescriptionGegenstand] = useState('');
  const [nameKiste, setNameKiste] = useState('');

  async function getData() {
    const resKisten = await fetch(apiURL + '/kisten');
    const kisten = await resKisten.json();
    setKisten(kisten);
    const res = await fetch(apiURL + '/items');
    const data = await res.json();
    setItems(data);
  }
  useEffect(() => {
    getData();
  }, []);

  return (
    <div>
      <h1>--Kisten--</h1>
      <KistenList kisten={kisten} />
      <input style={{padding:"10px 20px",}}
        type='text'
        value={nameKiste}
        onChange={(e) => setNameKiste(e.target.value)}
      />
      <button style={{color: "black",
            padding:"10px 20px",}}

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
        Add Kiste
      </button>
      <h1>--Gegenstände--</h1>
      <ItemList items={items} />
      <input style={{padding:"10px 20px",}}
        type='text'
        value={nameGegenstand}
        onChange={(e) => setNameGegenstand(e.target.value)}
      />
      <input style={{padding:"10px 20px",}}
        type='text'
        value={descriptionGegenstand}
        onChange={(e) => setDescriptionGegenstand(e.target.value)}
      />
      <button style={{color: "black", 
                      padding:"10px 20px",}}
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
        Add Gegenstand
      </button>
    </div>
  );

  return (
    <main className={styles.main}>
      <div className={styles.description}>
        <p>
          Get started by editing&nbsp;
          <code className={styles.code}>app/page.js</code>
        </p>
        <div>
          <a
            href='https://vercel.com?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app'
            target='_blank'
            rel='noopener noreferrer'
          >
            By{' '}
            <Image
              src='/vercel.svg'
              alt='Vercel Logo'
              className={styles.vercelLogo}
              width={100}
              height={24}
              priority
            />
          </a>
        </div>
      </div>

      <div className={styles.center}>
        <Image
          className={styles.logo}
          src='/next.svg'
          alt='Next.js Logo'
          width={180}
          height={37}
          priority
        />
      </div>

      <div className={styles.grid}>
        <a
          href='https://nextjs.org/docs?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app'
          className={styles.card}
          target='_blank'
          rel='noopener noreferrer'
        >
          <h2>
            Docs <span>-&gt;</span>
          </h2>
          <p>Find in-depth information about Next.js features and API.</p>
        </a>

        <a
          href='https://nextjs.org/learn?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app'
          className={styles.card}
          target='_blank'
          rel='noopener noreferrer'
        >
          <h2>
            Learn <span>-&gt;</span>
          </h2>
          <p>Learn about Next.js in an interactive course with&nbsp;quizzes!</p>
        </a>

        <a
          href='https://vercel.com/templates?framework=next.js&utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app'
          className={styles.card}
          target='_blank'
          rel='noopener noreferrer'
        >
          <h2>
            Templates <span>-&gt;</span>
          </h2>
          <p>Explore the Next.js 13 playground.</p>
        </a>

        <a
          href='https://vercel.com/new?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app'
          className={styles.card}
          target='_blank'
          rel='noopener noreferrer'
        >
          <h2>
            Deploy <span>-&gt;</span>
          </h2>
          <p>
            Instantly deploy your Next.js site to a shareable URL with Vercel.
          </p>
        </a>
      </div>
    </main>
  );
}
