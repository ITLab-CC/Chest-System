'use client';
import { useState, useEffect } from 'react';

async function getItem(itemID) {
  const res = await fetch('http://localhost:8000/api/v1/items/' + itemID);
  const data = await res.json();
  return data;
}

export default function Page({ params }) {
  const [item, setItem] = useState(null);
  useEffect(() => {
    getItem(params.id).then((item) => {
      console.log(item);
      setItem(item);
    });
  }, [params.id]);

  if (!item) {
    return <div>Loading...</div>;
  }
  return (
    <div>
      <h1>{item.name}</h1>
      <p>{item.description}</p>
    </div>
  );
}
