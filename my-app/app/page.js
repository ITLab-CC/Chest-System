"use client";
import Image from "next/image";
import styles from "./page.module.css";
import { useState, useEffect } from "react";

export default function Home() {
  const [gegenstaende, setGegenstaende] = useState([]);
  const [nameGegenstand, setNameGegenstand] = useState("");
  const [nameKiste, setNameKiste] = useState("");

  async function getGegenstaende() {
    const res = await fetch("http://localhost:8000/gegenstaende");
    const data = await res.json();
    setGegenstaende(data);
  }
  useEffect(() => {
    getGegenstaende();
  }, []);

  return (
    <div>
      {gegenstaende.map((gegenstand) => (
        <div key={gegenstand.GID}>
          <h1>{gegenstand.GID}</h1>
          <p>{gegenstand.Name}</p>
          <button
            onClick={() => {
              fetch(
                "http://localhost:8000/gegenstaende/delete/" + gegenstand.GID
              );
              getGegenstaende();
            }}
          >
            Delete
          </button>
        </div>
      ))}

      <input
        type="text"
        value={nameGegenstand}
        onChange={(e) => setNameGegenstand(e.target.value)}
      />
      <button
        onClick={() => {
          fetch("http://localhost:8000/gegenstaende/add/" + nameGegenstand);
          setNameGegenstand("");
          getGegenstaende();
        }}
      >
        Add Gegenstand
      </button>
      <input
        type="text"
        value={nameKiste}
        onChange={(e) => setNameKiste(e.target.value)}
      />
      <button
        onClick={() => {
          fetch("http://localhost:8000/kisten/add/" + nameKiste);
          setNameKiste("");
        }}
      >
        Add Kiste
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
            href="https://vercel.com?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"
            target="_blank"
            rel="noopener noreferrer"
          >
            By{" "}
            <Image
              src="/vercel.svg"
              alt="Vercel Logo"
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
          src="/next.svg"
          alt="Next.js Logo"
          width={180}
          height={37}
          priority
        />
      </div>

      <div className={styles.grid}>
        <a
          href="https://nextjs.org/docs?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"
          className={styles.card}
          target="_blank"
          rel="noopener noreferrer"
        >
          <h2>
            Docs <span>-&gt;</span>
          </h2>
          <p>Find in-depth information about Next.js features and API.</p>
        </a>

        <a
          href="https://nextjs.org/learn?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"
          className={styles.card}
          target="_blank"
          rel="noopener noreferrer"
        >
          <h2>
            Learn <span>-&gt;</span>
          </h2>
          <p>Learn about Next.js in an interactive course with&nbsp;quizzes!</p>
        </a>

        <a
          href="https://vercel.com/templates?framework=next.js&utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"
          className={styles.card}
          target="_blank"
          rel="noopener noreferrer"
        >
          <h2>
            Templates <span>-&gt;</span>
          </h2>
          <p>Explore the Next.js 13 playground.</p>
        </a>

        <a
          href="https://vercel.com/new?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"
          className={styles.card}
          target="_blank"
          rel="noopener noreferrer"
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
