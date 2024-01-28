import { addProductToKiste } from '@/utils/api.js';
export function PlusOrMinusButton({ chestId, itemId, plus, callback }) {
  return (
    <button
      style={{
        borderRadius: '50%',
        fontSize: '1em',
        width: '2.8125em',
      }}
      onClick={() => {
        addProductToKiste(chestId, itemId, plus ? 1 : -1).then(() => {
          callback();
        });
        //   .then(() => {
        //     let newKisteWithItems = {
        //       ...kisteWithItems,
        //       items: kisteWithItems.items.map((i) => {
        //         if (i.item_id === item.item_id) {
        //           i.anzahl = i.anzahl + 1;
        //         }
        //         return i;
        //       }),
        //     };
        //     setKisteWithItems(newKisteWithItems);
        //   })
        //   .catch((err) => {
        //     console.log(err);
        //   });
      }}
    >
      {plus ? '+' : '-'}
    </button>
  );
}
