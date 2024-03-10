import React, { useEffect, useState } from 'react';
import {
	InputOnly,
	InputPrefix,
	TextBox,
	TextBoxPrefix,
} from '../components/TextBox';
import { Switch } from '@headlessui/react';

import { CloseOutline } from '@styled-icons/evaicons-outline/CloseOutline';
import { Plus } from '@styled-icons/boxicons-regular/Plus';
import { Delete } from '@styled-icons/fluentui-system-filled/Delete';

import { fetchNui } from '../utils/fetchNui';
import { formatter } from '../utils/misc';
import Select, { SelectOnly } from '../components/Select';
import { PlanProps } from '../types';
import { locale } from '../store/locale';

// const SHELLS = {
//   ['shell_highend']: 'what',
//   ['shell_highend2']: 'what',
//   ['shell_apartment']: 'what',
// };

const CreateHome = ({ handleClose }: { handleClose: () => void }) => {
	const [shells, setShells] = useState<{ name: string }[]>([]);
	const [ipls, setIpls] = useState<{ name: string; value: string }[]>([]);
	const [home, setHome] = useState({
		homename: '',
		homeprice: 1000,
		hometype: 'Shell',
		homefor: 'Sale',
		homeshell: locale['choose'],
		complex: 'Individual',
		downpayment: 0,
	});
	const [mortgagePlan, setMortgagePlan] = useState<PlanProps[]>([]);
	const [toggles, setToggles] = useState({
		garage: false,
		cctv: false,
		renaming: false,
	});
	const [enabled, setEnabled] = useState(false);
	const [cctv, setCCTV] = useState(false);

	useEffect(() => {
		fetchNui<{ [key: string]: object }>('GetShells').then((data) => {
			let tempArr: { name: string }[] = [];
			Object.keys(data).map((key, index) => {
				tempArr.push({ name: key });
			});
			setShells(tempArr);
		});
		fetchNui<{ name: string; value: string }[]>('GetIPL').then((data) => {
			setIpls(data);
		});
	}, []);

	const handleSubmit = () => {
		if (
			home.homename.length > 0 &&
			((home.hometype === 'Shell' && home.homeshell !== locale['choose']) ||
				home.hometype === 'MLO' ||
				(home.hometype === 'IPL' && home.homeshell !== locale['choose']))
		) {
			fetchNui('createHome', {
				home: home,
				mortgage: mortgagePlan,
				toggles: toggles,
			});
			handleClose();
		} else {
			fetchNui('errorForm', locale['form_unfilled']);
		}
	};
	const addMortgage = () => {
		setMortgagePlan([
			...mortgagePlan,
			{
				interest: 10,
				duration: 6,
				type: 'Weeks',
				result: ((home.homeprice - home.downpayment) * (10 / 100 + 1.0)) / 6,
			},
		]);
	};

	const removeMortgage = () => {
		let tempArr = [...mortgagePlan];
		tempArr.pop();
		setMortgagePlan(tempArr);
	};

	const handleMortgage = (
		evt: React.FormEvent<
			HTMLSelectElement | HTMLInputElement | HTMLTextAreaElement
		>,
		key: string
	) => {
		let index = parseInt(key.slice(-1));
		let prop = key.slice(0, -2);
		let tempArr = [...mortgagePlan];
		switch (prop) {
			case 'interest':
				tempArr[index]['interest'] = parseInt(evt.currentTarget.value);
				tempArr[index]['result'] =
					(home.homeprice * (tempArr[index]['interest'] / 100 + 1.0) -
						home.downpayment) /
					tempArr[index]['duration'];
				break;
			case 'duration':
				tempArr[index]['duration'] = parseInt(evt.currentTarget.value);
				tempArr[index]['result'] =
					(home.homeprice * (tempArr[index]['interest'] / 100 + 1.0) -
						home.downpayment) /
					tempArr[index]['duration'];
				break;
		}
		setMortgagePlan(tempArr);
	};

	const handleMortgageSelect = (value: string, key: string) => {
		let index = parseInt(key.slice(-1));
		let prop = key.slice(0, -2);
		let tempArr = [...mortgagePlan];
		switch (prop) {
			case 'type':
				tempArr[index]['type'] = value;
				break;
		}
		setMortgagePlan(tempArr);
	};

	const handleChange = (
		evt: React.FormEvent<
			HTMLSelectElement | HTMLInputElement | HTMLTextAreaElement
		>,
		key: string
	) => {
		setHome({ ...home, [key]: evt.currentTarget.value });
	};

	const handleSelect = (value: string, key: string) => {
		setHome({ ...home, [key]: value });
	};

	return (
		<div className="px-4 py-6 ring-2 ring-white m-auto rounded-lg">
			<div className="relative w-[52rem] py-12 bg-white-dark rounded-lg text-grey-darker flex justify-center overflow-clip">
				<button
					onClick={handleClose}
					className="absolute top-2 right-2 rounded-full w-5 h-5 text-white bg-ocean-blue-darker z-10 flex justify-center items-center transition-colors hover:text-ocean-blue-dark hover:bg-white"
				>
					<CloseOutline />
				</button>
				<div className="w-40 h-40 bg-ocean-blue-light rounded-2xl absolute -right-9 -rotate-12 -top-9"></div>
				<div className="w-36 h-36 bg-ocean-blue rounded-2xl absolute -right-10 -rotate-12 -top-10"></div>
				<div className="w-40 h-40 bg-ocean-blue-light rounded-2xl absolute -left-9 -rotate-12 -bottom-9"></div>
				<div className="w-36 h-36 bg-ocean-blue rounded-2xl absolute -left-10 -rotate-12 -bottom-10"></div>
				<div className="w-[33.5rem]">
					<div className="flex w-full h-14 text-2xl font-bold justify-center items-center rounded-t-lg">
						{locale['house_creation']}
					</div>
					<div className="grid w-full grid-cols-2 gap-6">
						<TextBox
							id="homename"
							type="text"
							name="homename"
							label={locale['home_name']}
							handleChange={handleChange}
						/>
						<TextBoxPrefix
							prefix="$"
							id="homeprice"
							type="number"
							name="homeprice"
							label={locale['home_price']}
							value="1000.00"
							handleChange={handleChange}
						/>
						<Select
							id="hometype"
							label={locale['home_type']}
							value={home.hometype}
							handleSelect={handleSelect}
							list={[{ name: 'Shell' }, { name: 'MLO' }, { name: 'IPL' }]}
						/>
						{home.hometype == 'Shell' ? (
							<>
								<Select
									id="homeshell"
									label={locale['home_shell']}
									value={home.homeshell}
									handleSelect={handleSelect}
									list={shells}
								/>
								<Select
									id="complex"
									label={locale['complex_type']}
									value={home.complex}
									handleSelect={handleSelect}
									list={[{ name: 'Apartment' }, { name: 'Individual' }]}
								/>
							</>
						) : home.hometype == 'IPL' ? (
							<>
								<Select
									id="homeshell"
									label={locale['home_ipl']}
									value={home.homeshell}
									handleSelect={handleSelect}
									list={ipls}
								/>
								<Select
									id="complex"
									label={locale['complex_type']}
									value={home.complex}
									handleSelect={handleSelect}
									list={[{ name: 'Apartment' }, { name: 'Individual' }]}
								/>
							</>
						) : null}
						<Select
							id="homefor"
							label={locale['home_for']}
							value={home.homefor}
							handleSelect={handleSelect}
							list={[{ name: 'Sale' }, { name: 'Rent' }]}
						/>
					</div>
					<div className="m-4 flex flex-col items-center">
						<div className="inline-flex w-full justify-around">
							<Switch.Group as="div" className="inline-flex mb-4">
								<Switch.Label className="mr-4 font-semibold">
									{locale['enable_garage']}
								</Switch.Label>
								<Switch
									checked={toggles.garage}
									onChange={(val: boolean) =>
										setToggles({ ...toggles, garage: val })
									}
									className={`${
										toggles.garage ? 'bg-emerald-500' : 'bg-red-500'
									}
          relative inline-flex items-center h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus-visible:ring-2  focus-visible:ring-white focus-visible:ring-opacity-75`}
								>
									<span
										aria-hidden="true"
										className={`${
											toggles.garage ? 'translate-x-5' : 'translate-x-0.5'
										}
            pointer-events-none inline-block w-4 h-4 rounded-full bg-white shadow-lg transform ring-0 transition ease-in-out duration-200`}
									/>
								</Switch>
							</Switch.Group>
							<Switch.Group as="div" className="inline-flex mb-4">
								<Switch.Label className="mr-4 font-semibold">
									{locale['enable_cctv']}
								</Switch.Label>
								<Switch
									checked={toggles.cctv}
									onChange={(val: boolean) =>
										setToggles({ ...toggles, cctv: val })
									}
									className={`${toggles.cctv ? 'bg-emerald-500' : 'bg-red-500'}
          relative inline-flex items-center h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus-visible:ring-2  focus-visible:ring-white focus-visible:ring-opacity-75`}
								>
									<span
										aria-hidden="true"
										className={`${
											toggles.cctv ? 'translate-x-5' : 'translate-x-0.5'
										}
            pointer-events-none inline-block w-4 h-4 rounded-full bg-white shadow-lg transform ring-0 transition ease-in-out duration-200`}
									/>
								</Switch>
							</Switch.Group>
							<Switch.Group as="div" className="inline-flex mb-4">
								<Switch.Label className="mr-4 font-semibold">
									{locale['enable_renaming']}
								</Switch.Label>
								<Switch
									checked={toggles.renaming}
									onChange={(val: boolean) =>
										setToggles({ ...toggles, renaming: val })
									}
									className={`${
										toggles.renaming ? 'bg-emerald-500' : 'bg-red-500'
									}
          relative inline-flex items-center h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus-visible:ring-2  focus-visible:ring-white focus-visible:ring-opacity-75`}
								>
									<span
										aria-hidden="true"
										className={`${
											toggles.renaming ? 'translate-x-5' : 'translate-x-0.5'
										}
            pointer-events-none inline-block w-4 h-4 rounded-full bg-white shadow-lg transform ring-0 transition ease-in-out duration-200`}
									/>
								</Switch>
							</Switch.Group>
						</div>

						{mortgagePlan.length > 0 ? (
							<div className="bg-white px-2 rounded-md gap-2 inline-flex w-3/4 items-center text-xs mb-2">
								<div className="grow-0 rounded-full bg-ocean-blue w-6 h-6"></div>
								<div className="flex flex-col">
									<div className="text-sm font-medium">
										{locale['set_downpayment']}
									</div>
									<input
										className="w-30 rounded outline-none"
										type="range"
										min="0"
										value={home.downpayment}
										max={home.homeprice}
										onChange={(evt) => handleChange(evt, 'downpayment')}
									/>
								</div>
								<InputPrefix
									className="ml-auto w-1/4"
									prefix="$"
									type="number"
									name="downpayment"
									id="downpayment"
									handleChange={handleChange}
									setValue={home.downpayment}
								/>
							</div>
						) : null}

						{mortgagePlan.map((mortgage, index) => {
							return (
								<div
									className="inline-flex items-center justify-between w-full my-1 text-xs"
									key={index}
								>
									<div className="bg-white inline-flex items-center gap-1 px-2 py-1 rounded-md">
										<div className="text-sm">{locale['plans']}</div>
										<InputOnly
											type="text"
											name={'duration-' + index}
											id="duration"
											handleChange={handleMortgage}
											value="6"
											className="input-ocean-blue-dark text-center w-6 h-6"
										/>
										<SelectOnly
											id={'type-' + index}
											value={mortgage.type}
											handleSelect={handleMortgageSelect}
											list={[{ name: 'Weeks' }, { name: 'Months' }]}
										/>
									</div>
									<div className="bg-white inline-flex items-center gap-1 px-2 py-1 rounded-md">
										<div className="text-sm">{locale['with']}</div>
										<InputOnly
											type="text"
											name={'interest-' + index}
											id="interest"
											handleChange={handleMortgage}
											value="10"
											className="input-ocean-blue-dark text-center w-6 h-6"
										/>
										<div className="input-ocean-blue-dark text-center h-6">
											%
										</div>
									</div>
									<div className="bg-white inline-flex items-center gap-1 px-2 py-1 rounded-md">
										<div className="text-sm">{locale['interest']}</div>
										<InputOnly
											type="text"
											name={'result-' + index}
											id="result"
											disabled={true}
											handleChange={handleMortgage}
											setValue={`${formatter(locale['currency']).format(
												(home.homeprice * (mortgage.interest / 100 + 1.0) -
													home.downpayment) /
													mortgage.duration
											)}/${mortgage.type}`}
											className="input-ocean-blue-dark text-center h-6 w-32"
										/>
									</div>
								</div>
							);
						})}
						<div className="inline-flex my-4 ml-auto items-center">
							<button
								onClick={handleSubmit}
								className="rounded-md px-2 mr-4 bg-ocean-blue text-ocean-blue-darker hover:text-white hover:bg-ocean-blue-darker transition-all duration-200 flex justify-center items-center col-span-1 ml-4"
							>
								{locale['create_house']}
							</button>
							<div className="text-sm font-semibold mr-2">
								{locale['add_mortgage_plan']}
							</div>
							<button
								onClick={addMortgage}
								className="rounded-md w-6 h-6 bg-ocean-blue text-white hover:text-grey-darker hover:bg-[#6bc223] transition-all duration-200 flex justify-center place-items-center col-span-1 mr-2"
							>
								<Plus size="16" />
							</button>
							<button
								onClick={removeMortgage}
								className="rounded-md w-6 h-6 bg-grey-dark text-white hover:bg-[#FC5C2B] transition-all duration-200 flex justify-center place-items-center col-span-1"
							>
								<Delete size="16" />
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	);
};

export default CreateHome;
