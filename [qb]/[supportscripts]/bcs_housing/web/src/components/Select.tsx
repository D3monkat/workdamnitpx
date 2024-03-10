import React from 'react';
import { Listbox } from '@headlessui/react';
import classNames from 'classnames';
import { Check } from '@styled-icons/bootstrap/Check';
import { Selector } from '@styled-icons/heroicons-outline/Selector';

interface SelectProps {
  label?: string;
  id: string;
  value: string;
  list: {
    name: string;
  }[];
  handleSelect: (value: string, key: string) => void;
}

const Select: React.FC<SelectProps> = ({
  label,
  value,
  list,
  id,
  handleSelect,
}) => {
  return (
    <Listbox value={value} onChange={(value) => handleSelect(value, id)}>
      <div className="relative bg-white shadow-9dp rounded-md p-2 text-grey-darker flex gap-2">
        <div className="grow-0 rounded-full m-auto bg-ocean-blue w-9 h-9"></div>
        <div className="grow h-10">
          {label && (
            <Listbox.Label className="block text-sm font-semibold">
              {label}
            </Listbox.Label>
          )}
          <Listbox.Button className="w-full relative cursor-default text-left text-sm">
            <span className="block truncate">{value}</span>
            <span className="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
              <Selector className="w-5 h-5 text-gray-400" aria-hidden="true" />
            </span>
          </Listbox.Button>
        </div>
        <Listbox.Options className="absolute z-10 top-14 left-0 w-full max-h-60 shadow-9dp overflow-auto text-sm bg-white text-black rounded-md">
          {list.map((row, index) => (
            <Listbox.Option
              key={index}
              value={row.name}
              className={({ active }) =>
                classNames(
                  active ? 'bg-ocean-blue-light' : 'text-gray-900',
                  'cursor-default select-none relative py-2 pl-6 pr-4 rounded-md'
                )
              }
            >
              {({ selected, active }) => (
                <>
                  <span
                    className={`block truncate ${
                      selected ? 'font-medium' : 'font-normal'
                    }`}
                  >
                    {row.name}
                  </span>
                  {selected ? (
                    <span className="absolute inset-y-0 left-0 flex items-center pl-1 text-emerald-600">
                      <Check className="w-5 h-5" aria-hidden="true" />
                    </span>
                  ) : null}
                </>
              )}
            </Listbox.Option>
          ))}
        </Listbox.Options>
      </div>
    </Listbox>
  );
};

export const SelectOnly: React.FC<SelectProps> = ({
  label,
  value,
  list,
  id,
  handleSelect,
}) => {
  return (
    <Listbox value={value} onChange={(value) => handleSelect(value, id)}>
      <div className="relative bg-ocean-blue-dark shadow-9dp rounded-sm pl-2 text-white flex w-24 gap-2 h-6">
        <Listbox.Button className="flex cursor-default text-left text-sm justify-between items-center w-full">
          <span className="block truncate">{value}</span>
          <span className="flex items-center pointer-events-none">
            <Selector className="w-5 h-5" aria-hidden="true" />
          </span>
        </Listbox.Button>
        <Listbox.Options className="absolute z-10 top-6 left-0 max-h-60 shadow-md overflow-auto text-sm bg-ocean-blue-dark text-white rounded-sm min-w-[6rem]">
          {list.map((row, index) => (
            <Listbox.Option
              key={index}
              value={row.name}
              className={({ active }) =>
                classNames(
                  active ? 'text-grey-darker bg-ocean-blue' : 'text-white',
                  'cursor-default select-none relative py-1 pl-6 pr-4 rounded-sm'
                )
              }
            >
              {({ selected, active }) => (
                <>
                  <span
                    className={`block truncate ${
                      selected ? 'font-medium' : 'font-normal'
                    }`}
                  >
                    {row.name}
                  </span>
                  {selected ? (
                    <span
                      className={classNames(
                        'absolute inset-y-0 left-0 flex items-center pl-1',
                        active ? 'text-emerald-600' : 'text-emerald-400'
                      )}
                    >
                      <Check className="w-5 h-5" aria-hidden="true" />
                    </span>
                  ) : null}
                </>
              )}
            </Listbox.Option>
          ))}
        </Listbox.Options>
      </div>
    </Listbox>
  );
};

export default Select;
