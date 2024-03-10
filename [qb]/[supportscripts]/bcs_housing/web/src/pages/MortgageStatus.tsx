import React, { useState } from 'react';
import { InputOnly, TextBox } from '../components/TextBox';
import { formatter } from '../utils/misc';
import { PlanProps } from '../types';
import { useNuiEvent } from '../hooks/useNuiEvent';
import { fetchNui } from '../utils/fetchNui';

import { CloseOutline } from '@styled-icons/evaicons-outline/CloseOutline';
import { locale } from '../store/locale';

const MortgageStatus = ({ handleClose }: { handleClose: () => void }) => {
  const [identifier, setIdentifier] = useState('');
  const [plan, setPlan] = useState<PlanProps>({
    interest: 10,
    duration: 6,
    result: 10000,
    type: 'Weeks',
  });
  const [data, setData] = useState({
    remaining: 10000,
    lastPayment: '00/00/0000',
    nextPayment: '00/00/0000',
  });

  useNuiEvent('setMortgage', (data) => {
    setPlan(data.plan);
    setData(data.data);
    setIdentifier(data.identifier);
  });

  const payMortgage = (all: boolean) => {
    fetchNui('payMortgage', {
      type: all,
      identifier: identifier,
    });
    handleClose();
  };

  const handleChange = () => {};

  return (
    <div className="px-4 py-6 ring-2 ring-white m-auto rounded-lg h-[28rem]">
      <div className="relative overflow-clip bg-white-dark w-[40rem] h-full m-auto rounded-lg text-grey-darker px-6 flex flex-col justify-center">
        <button
          onClick={handleClose}
          className="absolute top-2 right-2 rounded-full w-5 h-5 text-white bg-ocean-blue-darker z-10 flex justify-center items-center transition-colors hover:text-ocean-blue-dark hover:bg-white"
        >
          <CloseOutline />
        </button>
        <div className="w-36 h-36 bg-ocean-blue-light rounded-2xl absolute -right-9 -rotate-12 -top-9"></div>
        <div className="w-32 h-32 bg-ocean-blue rounded-2xl absolute -right-10 -rotate-12 -top-10"></div>
        <div className="w-36 h-36 bg-ocean-blue-light rounded-2xl absolute -left-9 -rotate-12 -bottom-9"></div>
        <div className="w-32 h-32 bg-ocean-blue rounded-2xl absolute -left-10 -rotate-12 -bottom-10"></div>
        <div className="font-bold text-2xl text-center mb-2">
          {locale['mortgage_status']}
        </div>
        <div className="grid grid-cols-[60%_40%] gap-4 w-2/3 mx-auto">
          <div className="bg-white px-2 py-1 rounded-md h-fit w-fit inline-flex gap-1 items-center shadow-9dp">
            <span className="input-ocean-blue-dark px-2">{plan.interest}%</span>
            {`interest for`}
            <span className="input-ocean-blue-dark px-2">
              {plan.duration} {plan.type}
            </span>
          </div>
          <InputOnly
            id="result"
            type="text"
            name="result"
            setValue={`${formatter(locale['currency']).format(plan.result)}/${
              plan.type
            }`}
            disabled={true}
            handleChange={handleChange}
            className="bg-white p-2 rounded-lg text-center shadow-9dp h-fit"
          />
          <div className=" bg-white p-2 rounded-lg text-center shadow-9dp w-fit h-fit">
            {locale['remaining_payments']}
          </div>
          <InputOnly
            id="result"
            type="text"
            name="result"
            setValue={`${formatter(locale['currency']).format(data.remaining)}`}
            disabled={true}
            handleChange={handleChange}
            className="bg-white p-2 rounded-lg text-center shadow-9dp h-fit"
          />
          <div className="">{locale['last_payment']}</div>
          <div className="input-ocean-blue-dark px-2 py-1 rounded-md h-fit text-center w-full">
            {data.lastPayment}
          </div>
          <div className="">{locale['next_payment']}</div>
          <div className="input-ocean-blue-dark px-2 py-1 rounded-md h-fit text-center w-full">
            {data.nextPayment}
          </div>
        </div>
        <div className="inline-flex w-full justify-center mt-4">
          <button
            className="py-1 px-5 rounded-md bg-ocean-blue-light hover:bg-green-600 duration-150 ease-linear font-bold mr-4"
            onClick={() => payMortgage(false)}
          >
            {locale['pay']}
          </button>
          <button
            className="py-1 px-5 rounded-md bg-ocean-blue-dark hover:bg-red-600 duration-150 ease-linear font-bold"
            onClick={() => payMortgage(true)}
          >
            {locale['pay_all']}
          </button>
        </div>
      </div>
    </div>
  );
};

export default MortgageStatus;
