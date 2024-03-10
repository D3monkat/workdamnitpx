import React from 'react';
import { TriangleDown } from '@styled-icons/entypo/TriangleDown';

interface TextProps {
  id: string;
  name: string;
  type: string;
  handleChange: (
    evt: React.FormEvent<
      HTMLSelectElement | HTMLInputElement | HTMLTextAreaElement
    >,
    key: string
  ) => void;
  className?: string;
  max?: number;
  label?: string;
  disabled?: boolean;
  value?: string;
  setValue?: string | number;
}

interface TextPrefixProps extends TextProps {
  prefix: string;
}

export const InputOnly: React.FC<TextProps> = ({
  id,
  name,
  type,
  handleChange,
  value,
  max,
  disabled,
  setValue,
  className,
}) => (
  <input
    type={type}
    name={name}
    id={id}
    onChange={(evt) => handleChange(evt, name)}
    disabled={disabled ? true : false}
    value={setValue}
    max={max}
    placeholder={value ? value : ''}
    className={className}
  />
);

export const TextBox: React.FC<TextProps> = ({
  id,
  name,
  type,
  handleChange,
  label,
  value,
  max,
  disabled,
  setValue,
}) => {
  return (
    <div className="bg-white rounded-md h-fit p-2 text-grey-darker flex shadow-9dp gap-2">
      <div className="grow-0 m-auto rounded-full bg-ocean-blue w-9 h-9"></div>
      <div className="grow">
        {label ? (
          <label htmlFor={name} className="block text-sm font-semibold">
            {label}
          </label>
        ) : null}
        <InputOnly
          type={type}
          name={name}
          id={id}
          handleChange={handleChange}
          disabled={disabled ? true : false}
          setValue={setValue}
          max={max}
          value={value}
          className="appearance-none focus:outline-none block w-full sm:text-sm bg-transparent text-grey-dark"
        />
      </div>
    </div>
  );
};

export const InputPrefix: React.FC<TextPrefixProps> = ({
  prefix,
  name,
  type,
  handleChange,
  id,
  className,
  setValue,
  value,
}) => (
  <div className={`${className} flex text-grey-dark sm:text-sm`}>
    <div className="inset-y-0 left-0 flex items-center">
      <span>{prefix}</span>
    </div>
    <input
      type={type}
      name={name}
      id={id}
      onChange={(evt) => handleChange(evt, name)}
      value={setValue}
      placeholder={value ? value : ''}
      className="appearance-none focus:outline-none block w-full bg-transparent ml-1"
    />
  </div>
);

export const TextBoxPrefix: React.FC<TextPrefixProps> = ({
  id,
  name,
  type,
  handleChange,
  label,
  value,
  prefix,
}) => {
  return (
    <div className="bg-white shadow-9dp rounded-md h-fit p-2 text-grey-darker flex gap-2 items-start">
      <div className="grow-0 rounded-full bg-ocean-blue w-9 h-9"></div>
      <div className="grow">
        <label htmlFor={name} className="block text-sm font-semibold">
          {label}
        </label>
        <InputPrefix
          id={id}
          name={name}
          type={type}
          handleChange={handleChange}
          value={value}
          prefix={prefix}
        />
      </div>
    </div>
  );
};
