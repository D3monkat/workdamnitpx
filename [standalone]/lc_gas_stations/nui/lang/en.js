if (Lang == undefined) {
	var Lang = [];
}
Lang['en'] = {
	confim_buy: "Do you really want to buy this gas station? Price: {0}",
	confim_buy_title: "Are you sure?",
	confim_buy_cancel_button: "Cancel",
	confim_buy_confirm_button: "Confirm",
	confim_sell_title: "Are you sure?",
	confim_sell_desc: "Do you really want to sell your gas station? Everything will be deleted and this process cannot be undone.",
	confim_sell_cancel_button: "Cancel",
	confim_sell_confirm_button: "Sell",
	str_low_stock: "Running low on stock will cause you to lose your store!",
	str_stock_capacity: "Inventory capacity (Max: {0})",
	str_gas_price: "Price per liter of fuel",
	btn_apply_price: "Apply price",
	str_liters: "Liters",
	btn_import: "Import",
	btn_export: "Export",
	str_amount: "Amount",
	str_reward: "Salary",
	str_total_cost: "Total cost",
	btn_delete_contract: "Delete contract",
	str_stock_capacity_title: "Inventory capacity",
	str_stock_capacity_desc: "Improve your inventory capacity to get more space to store your products. Your products will only be sold when someone comes to your gas station or when you export them.",
	str_truck_capacity_title: "Truck capacity",
	str_truck_capacity_desc: "Improve your truck's ability to get a better truck to transport a greater amount of products.",
	str_relationship_title: "Relationship",
	str_relationship_desc: "The better your relationship with suppliers, the better the purchase prices. You will receive the discount when starting a new job.",
	str_level: "Level",
	str_units: "units.",
	str_capacity: "capacity.",
	str_discount: "discount.",
	btn_buy: "Buy",
	str_price: "Value",
	str_date: "Date",
	str_fill_field: "Fill this field",
	str_invalid_value: "Invalid value",
	str_more_than: "Must be greater than or equal to {0}",
	str_less_than: "Must be less than or equal to {0}",

	confirmation_modal_fire_player: 'Are you sure you want to fire this player?',

	str_main_page_title_navbar: "Your gas station",
	str_goods_page_title_navbar: "Fuel",
	str_jobs_page_title_navbar: "Refuel",
	str_hire_page_title_navbar: "Hire a driver",
	str_upgrades_page_title_navbar: "Upgrades",
	str_employee_page_title_navbar: "Employees",
	str_bank_page_title_navbar: "Cashier",
	str_sell_page_title_navbar: "Sell gas station",

	str_main_page_title: "Statistics",
	str_main_page_desc: "Gas station statistics",
	str_main_page_money_earned: "Total money earned",
	str_main_page_money_spent: "Total money spent",
	str_main_page_money_spent: "Total money spent",
	str_main_page_goods: "Imported liters",
	str_main_page_goods_sold: "Liters sold",
	str_main_page_distance_traveled: "Distance traveled",
	str_main_page_total_visits: "Total visits",
	str_main_page_customers: "Customers",
	
	str_goods_page_title: "Fuel stock",
	str_goods_page_desc: "Here you can see your fuel storage at your gas station. You can also change the price of a liter of fuel for your gas station.",

	str_jobs_page_title: "Replenishment",
	str_jobs_page_desc: "Refuel your station's tanks by importing fuel.",

	str_hire_page_title: "Hire driver",
	str_hire_page_desc: "Here you can create jobs for drivers to import fuel for their job. It is important to put a high salary to encourage people to take jobs.",
	str_hire_page_form_job_name: "Job name",
	str_hire_page_form_reward: "Reward",
	str_hire_page_form_amount: "Amount",
	btn_hire_page_form: "Create job",

	str_upgrades_page_title: "Upgrades",
	str_upgrades_page_desc: "Use your money to improve your rank and get more profit",

	employees_title: 'Employees',
	employees_desc: 'Hire employees to work on your company',
	button_employee: 'Hire employee',
	button_fire_employee: 'Fire employee',
	button_give_comission: 'Give comission',
	input_give_comission: 'Comission amount',
	hired_date: 'Hired on:',
	jobs_done: 'Jobs done:',
	select_employee: 'Select a player',
	basic_access: 'Basic Access',
	advanced_access: 'Advanced Access',
	full_access: 'Full Access',

	bank_page_title: 'Bank',
	bank_page_desc: "See all your cash flow here. You can deposit and withdraw your money",
	bank_page_withdraw: 'Withdraw money',
	bank_page_deposit: 'Deposit Money',
	bank_page_balance_text: 'Your balance is:',

	bank_page_balance_table_title: 'Income / Expenses',
	bank_page_balance_title: 'Title',
	bank_page_balance_value: 'Value',
	bank_page_balance_date: 'Date',
	bank_page_hidden_balance: "Show Hidden Balance",
	bank_page_hide_balance: "Hide balance",
	bank_page_show_balance: "Show balance",
	bank_page_load_balance: "Load more...",

	bank_page_deposit_modal_title: 'Deposit money',
	bank_page_deposit_modal_desc: 'How much do you want to deposit?',
	bank_page_deposit_modal_submit: 'Deposit money',

	bank_page_withdraw_modal_title: 'Withdraw money',
	bank_page_withdraw_modal_desc: 'How much do you want to withdraw?',
	bank_page_withdraw_modal_submit: 'Withdraw money',
	
	bank_page_modal_placeholder: 'Amount',
	bank_page_modal_money_available: 'Available money: {0}',
	bank_page_modal_cancel: 'Cancel',

	str_rename_store:"Rename gas station",
	str_rename_store_desc:"Choose here the name of your gas station",
	btn_apply_rename:"Apply",
	str_rename_store_name:"Gas station name",
	html_select_colors:`
		<option value="" selected disabled>Pick a color</option>
		<option color_id="1">Red</option>
		<option color_id="3">Blue</option>
		<option color_id="4">White</option>
		<option color_id="5">Yellow</option>
		<option color_id="7">Violet</option>
		<option color_id="8">Pink</option>
		<option color_id="15">Cyan</option>
		<option color_id="22">Grey</option>
		<option color_id="29">Dark Blue</option>
		<option color_id="30">Dark Cyan</option>
		<option color_id="32">Lught Blue</option>
		<option color_id="40">Dark Grey</option>
		<option color_id="41">Pink Red (Default)</option>
		<option color_id="46">Gold</option>
		<option color_id="47">Orange</option>
		<option color_id="83">Purple</option>
	`, // Change only the color names

	html_select_type:`
		<option value="" selected disabled>Pick a type</option>
		<option blip_id="40">Safe House</option>
		<option blip_id="50">Garage</option>
		<option blip_id="51">Drugs</option>
		<option blip_id="52">Market</option>
		<option blip_id="68">Tow truck</option>
		<option blip_id="71">Barber</option>
		<option blip_id="135">Cinema</option>
		<option blip_id="226">Bike</option>
		<option blip_id="227">Car</option>
		<option blip_id="251">Plane</option>
		<option blip_id="273">Dog bone</option>
		<option blip_id="361">Jerry can (Default)</option>
		<option blip_id="357">Dock</option>
	` // Change only the location names
};