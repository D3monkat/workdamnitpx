import React, { useState } from 'react';
import { useNuiEvent } from '../hooks/useNuiEvent';
import { SelectionBoxes, SelectionProps } from '../types';
import { debugData } from '../utils/debugData';
import { fetchNui } from '../utils/fetchNui';

// debugData([
//   {
//     action: 'setSelection',
//     data: {
//       title: 'Home Menu',
//       subtitle: 'House Manager Menu',
//       boxes: [
//         {
//           text: {
//             title: 'Furnish House',
//             body: 'Add your house furniture here',
//           },
//           event: 'Housing:furnish',
//           icon: 'fa-solid fa-house',
//         },
//         {
//           text: {
//             title: 'Furnish House',
//             body: 'Add your house furniture here',
//           },
//           event: 'Housing:furnish',
//           icon: 'fa-solid fa-house',
//         },

//         {
//           text: {
//             title: 'Pay Home Mortgage awdwa awdwa adw ad awd awd',
//             body: 'Pay your monthly bill here',
//           },
//           icon: 'fa-solid fa-tag',
//           event: 'Housing:payMortgage',
//         },
//       ],
//     },
//   },
// ]);

const Selection = ({ handleClose }: { handleClose: () => void }) => {
  const [boxes, setBoxes] = useState<SelectionBoxes[]>([]);
  const [data, setData] = useState({
    title: '',
    subtitle: '',
  });

  useNuiEvent<SelectionProps>('setSelection', (data) => {
    setData({
      title: data.title,
      subtitle: data.subtitle,
    });
    setBoxes(data.boxes);
  });

  const handleClick = (box: SelectionBoxes) => {
    fetchNui('boxClick', box);
    handleClose();
  };

  return (
    <div className="px-4 py-6 ring-2 ring-white m-auto rounded-lg w-[40rem]">
      <div className="m-auto w-full grid grid-cols-[40%_60%] items-center bg-white-dark rounded-lg p-6 h-96 gap-2">
        <div className="text-center">
          <div className="font-bold text-4xl text-ocean-blue">{data.title}</div>
          <div className="text-xl text-grey-dark">{data.subtitle}</div>
        </div>
        <div className="flex flex-col gap-4 overflow-auto h-full">
          {boxes.map((box, index) => (
            <button
              onClick={() => handleClick(box)}
              className="gap-5 max-w-6xl rounded-lg bg-white flex justify-between items-center px-4 py-2 shadow-md hover:bg-ocean-blue-darker hover:text-white duration-150 ease-in"
            >
              <i className={`${box.icon} text-grey-dark text-4xl`}></i>
              <div className="grow text-left flex flex-col">
                <span className="text-ocean-blue text-xl font-bold">
                  {box.text.title}
                </span>
                <span>{box.text.body}</span>
              </div>
            </button>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Selection;
