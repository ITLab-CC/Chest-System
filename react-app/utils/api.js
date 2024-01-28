import { apiURL } from './constants';

export async function addProductToKiste(kisteId, productId, anzahl) {
  await fetch(apiURL + '/chests/' + kisteId + '/items', {
    method: 'POST',
    body: JSON.stringify({
      item_id: productId,
      anzahl: anzahl,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  });
}

export async function getKisten() {
  const res = await fetch(apiURL + '/chests');
  const data = await res.json();
  return data;
}

export async function getProducts() {
  const res = await fetch(apiURL + '/items');
  const data = await res.json();
  return data;
}
