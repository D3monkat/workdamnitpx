import React, { useState } from 'react';
import { InputOnly, TextBox } from '../components/TextBox';
import { useNuiEvent } from '../hooks/useNuiEvent';
import { fetchNui } from '../utils/fetchNui';
import { formatter } from '../utils/misc';
import { PlanProps } from '../types';

import { CloseOutline } from '@styled-icons/evaicons-outline/CloseOutline';
import { locale } from '../store/locale';

const BuyHome = ({ handleClose }: { handleClose: () => void }) => {
  const handleChange = () => {};
  const [identifier, setIdentifier] = useState('');
  const [payment, setPayment] = useState('Sale');
  const [name, setName] = useState('');
  const [price, setPrice] = useState(0);
  const [downpayment, setDownpayment] = useState(0);
  const [plans, setPlans] = useState<PlanProps[]>([
    // {
    //   interest: 10,
    //   duration: 6,
    //   type: 'Weeks',
    //   result: 10000,
    // },
  ]);

  const choosePlan = (plan: PlanProps) => {
    fetchNui('choosePlan', {
      identifier: identifier,
      name: name,
      price: price,
      downpayment: downpayment,
      plan: plan,
    });
    handleClose();
  };

  const buyHome = () => {
    fetchNui('buyHome', {
      identifier: identifier,
      name: name,
      price: price,
    });
    handleClose();
  };

  useNuiEvent('setHome', (data) => {
    setIdentifier(data.home.identifier);
    setPayment(data.home.payment);
    setPlans(data.mortgages);
    setName(data.home.name);
    setPrice(data.home.price);
    setDownpayment(data.home.downpayment);
  });

  return (
    <div className="px-4 py-6 ring-2 ring-white m-auto rounded-lg">
      <div className="relative overflow-clip bg-white-dark w-[42rem] min-h-[50%] rounded-lg text-grey-darker py-10 px-6 flex flex-col justify-center">
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
        <div className="font-bold text-3xl mb-2 ml-auto mr-auto">{name}</div>
        <div className="inline-flex items-center justify-between rounded-md bg-white px-2 w-3/4 ml-auto mr-auto">
          <div className="inline-flex gap-2 items-center">
            <div className="grow-0 rounded-full m-auto bg-ocean-blue w-6 h-6"></div>
            {locale['price']}:
            <InputOnly
              id="downpayment"
              type="text"
              name="downpayment"
              setValue={formatter(locale['currency']).format(price)}
              disabled={true}
              handleChange={handleChange}
            />
          </div>
          {payment === 'Sale' ? (
            <button
              className="py-1 px-2 rounded-md font-bold bg-ocean-blue-dark text-white hover:bg-cyan-600 duration-150 ease-linear hover:text-gray-800 my-2"
              onClick={buyHome}
            >
              {locale['buy_now']}
            </button>
          ) : (
            <button
              className="py-1 px-2 rounded-md bg-teal-700 hover:bg-cyan-600 duration-150 ease-linear hover:text-gray-800 my-2"
              onClick={buyHome}
            >
              {locale['rent_now']}
            </button>
          )}
        </div>
        {plans.length > 0 && (
          <div className="w-4/5 flex flex-col ml-auto mr-auto">
            <div className="ml-auto mr-auto py-2 text-lg">
              {locale['payment_options']}
            </div>
            <div className="inline-flex items-center justify-around py-2">
              <div>{locale['downpayment']}</div>
              <InputOnly
                id="downpayment"
                type="text"
                name="downpayment"
                setValue={formatter(locale['currency']).format(downpayment)}
                disabled={true}
                handleChange={handleChange}
                className="input-ocean-blue-dark text-center rounded-md"
              />
            </div>
            {plans.map((val, index) => (
              <div className="inline-flex items-center justify-center gap-2 py-2">
                <div className="bg-white px-2 rounded-md py-1 inline-flex gap-1 items-center">
                  {index + 1}.
                  <span className="input-ocean-blue-dark px-2">
                    {val.interest}%
                  </span>
                  {locale['interest_for']}
                  <span className="input-ocean-blue-dark px-2">
                    {val.duration} {val.type}
                  </span>
                </div>
                <div className="bg-white px-2 rounded-md py-1 inline-flex items-center">
                  <InputOnly
                    id="result"
                    type="text"
                    name="result"
                    setValue={`${formatter(locale['currency']).format(
                      val.result
                    )}/${val.type}`}
                    disabled={true}
                    handleChange={handleChange}
                  />
                  <button
                    className="px-2 py-[3px] rounded-md text-white bg-ocean-blue-dark hover:bg-cyan-600 duration-150 ease-linear hover:text-gray-800"
                    onClick={() => choosePlan(val)}
                  >
                    {locale['choose']}
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default BuyHome;
