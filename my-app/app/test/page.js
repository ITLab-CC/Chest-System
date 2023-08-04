"use client";
import { useState, useEffect } from "react";

export default function Page() {
  const [kisten, setKisten] = useState([]);

  async function getKisten() {
    const res = await fetch("http://localhost:8000/kisten%22");
    const kisten = await res.json();
    setKisten(kisten);
  }

  useEffect(() => {
    getKisten();
  }, []);

  return (
    <div>
      <h2>Seite 2</h2>
      {kisten.map((kiste) => (
        <div key={kiste.KID}>
          <h3>{kiste.KID}</h3>
          <p>{kiste.Name}</p>
          <button style={{color: "black",
                  padding:"10px 20px",}}
            onClick={() => {
              fetch("http://localhost:8000/kisten/delete/" + kiste.KID);
              getKisten();
            }}
          >
            Delete
          </button>
        </div>
      ))}
    </div>
  );
}