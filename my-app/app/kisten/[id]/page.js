"use client";
import { useState, useEffect } from "react";
import ProductSelectionOverlay from "../../../components/ProductSelectionOverlay";
import { Loader } from "../../../components/loader";
import { apiURL } from "../../../utils/constants";

async function getKiste(kistenID) {
  const res = await fetch(apiURL + "/kisten/" + kistenID);
  const data = await res.json();
  return data;
}

async function getItemsInKiste(kistenID) {
  const res = await fetch(apiURL + "/kisten/" + kistenID + "/items");
  const data = await res.json();
  return data;
}

export default function Page({ params }) {
  const [kiste, setKiste] = useState(null);
  const [itemsInKiste, setItemsInKiste] = useState([]);
  const [showProductOverlay, setShowProductOverlay] = useState(false);
  const [loading, setLoading] = useState(true);

  async function loadData() {
    setLoading(true);
    getKiste(params.id).then((item) => {
      console.log(item);
      setKiste(item);
    });
    getItemsInKiste(params.id).then((items) => {
      console.log(items);
      setItemsInKiste(items);
    });
    setLoading(false);
  }

  useEffect(() => {
    loadData();
  }, [params.id]);

  if (!kiste) {
    return <Loader />;
  }
  return (
    <div>
      <div>
        <nav class="menu menu-1">
        <ul>
          <li><a href="/">Home</a></li>
        </ul>
        </nav>
      </div>
      <div style={{ textAlign: "center" }}>
        <h1>{kiste.id}</h1>
        <p>{kiste.name}</p>
        <h1
          style={{ fontSize: "1.875em", color: "#19e619", marginBottom: "0.25em" }}
        >
          Items in Chest
        </h1>
        <ul>
          {itemsInKiste.map((item) => (
            <li style={{ padding: "0.3125em" }} key={item.id}>
              {item.name}: {item.anzahl}x
            </li>
          ))}
        </ul>
        <button
          style={{ color: "black", padding: "0.625em 1.25em", marginBottom: "1.25em" }}
          onClick={() => {
            setShowProductOverlay(true);
          }}
        >
          Add Item
        </button>
        <br></br>
        {showProductOverlay && (
          <ProductSelectionOverlay
            kiste={kiste}
            setShowProductOverlay={setShowProductOverlay}
            loadData={loadData}
          />
        )}
      </div>
    </div>
  );
}
