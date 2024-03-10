var config;
let role_level_id = 0;

window.addEventListener('message', async function (event) {
	var item = event.data;
	if (item.utils) {
		if (typeof Lang === 'undefined') {
			await Utils.loadLanguageModules(item.utils)
		}
	}
	if (item.resourceName) {
		Utils.setResourceName(item.resourceName)
	}
	if (item.price){
		$('#modal-confirm-title').empty();
		$('#modal-confirm-title').append(Utils.translate('confim_buy_title'));
		$('#modal-confirm-button').empty();
		$('#modal-confirm-button').append(Utils.translate('confim_buy_confirm_button'));
		$('#modal-cancel-button').empty();
		$('#modal-cancel-button').append(Utils.translate('confim_buy_cancel_button'));
		$('#modal-p').empty();
		$('#modal-p').append(Utils.translate('confim_buy').format(Utils.currencyFormat(item.price,2)));
		$("body").css("display", "");
		$(".main").css("display", "none");
		$(document).ready(function(){
			$("#buyModal").modal({show: true});
		});
	} else if (item.showmenu){
		config = item.dados.config;
		role_level_id = item.dados.role;
		let gas_station_jobs = item.dados.gas_station_jobs;
		let gas_station_business = item.dados.gas_station_business;
		let gas_station_balance = item.dados.gas_station_balance;
		let gas_station_employees = item.dados.gas_station_employees;
		let gas_station_users_theme = item.dados.gas_station_users_theme;
		let players = item.dados.players;

		if(item.update != true){
			$(".pages").css("display", "none");
			$("body").css("display", "");
			$(".main").fadeIn(200);
			$(".main-page").css("display", "block");
			$('.sidebar-navigation ul li').removeClass('active');
			$('#sidebar-main').addClass('active');

			$('#css-toggle').prop('checked', gas_station_users_theme.dark_theme).change();
			openPage('main');

			for (const page in config.roles_permissions) {
				if (role_level_id < config.roles_permissions[page]){
					$("#sidebar-"+page).css("display", "none");
				} else {
					$("#sidebar-"+page).css("display", "");
				}
			}
		}

		$('#player-info-stock').text(' '+Utils.numberFormat(gas_station_business.stock,0) + ' ' + Utils.translate('str_liters'));
		$('#player-info-money').text(Utils.currencyFormat(gas_station_business.money,0));

		/*
		* STATISTICS PAGE
		*/
		$('#store-name').empty();
		if (gas_station_business.gas_station_name) {
			$('#store-name').append(Utils.translate('str_rename_store') + ' <small>(' + gas_station_business.gas_station_name + ')</small>');
		} else {
			$('#store-name').append(Utils.translate('str_rename_store'));
		}
		$('#store-name-desc').empty();
		$('#store-name-desc').append(Utils.translate('str_rename_store_desc'));
		$('#form_blip_color').empty();
		$('#form_blip_color').append(Utils.translate('html_select_colors'));
		$('#form_blip_id').empty();
		$('#form_blip_id').append(Utils.translate('html_select_type'));
		$('#apply-rename').empty();
		$('#apply-rename').append(Utils.translate('btn_apply_rename'));
		$('#text-rename').empty();
		$('#text-rename').append(`<input id="form_name" type="text" name="name" class="form-control" placeholder="${Utils.translate('str_rename_store_name')}" required="required" oninput="Utils.invalidMsg(this);"> `);
		
		$('#profile-money-earned').empty();
		$('#profile-money-earned').append(Utils.currencyFormat(gas_station_business.total_money_earned));
		$('#profile-money-spent').empty();
		$('#profile-money-spent').append(Utils.currencyFormat(gas_station_business.total_money_spent));
		$('#profile-goods').empty();
		$('#profile-goods').append(Utils.numberFormat(gas_station_business.gas_bought) + "L");
		$('#profile-goods-sold').empty();
		$('#profile-goods-sold').append(Utils.numberFormat(gas_station_business.gas_sold) + "L");
		$('#profile-distance-traveled').empty();
		$('#profile-distance-traveled').append(Utils.numberFormat(gas_station_business.distance_traveled) + 'km');
		$('#profile-total-visits').empty();
		$('#profile-total-visits').append(Utils.numberFormat(gas_station_business.total_visits));
		$('#profile-customers').empty();
		$('#profile-customers').append(Utils.numberFormat(gas_station_business.customers));
		var stock_capacity = config.gas_station_types.stock_capacity + config.gas_station_types.upgrades.stock.level_reward[gas_station_business.stock_upgrade];
		var stock_capacity_percent = ((gas_station_business.stock * 100)/stock_capacity).toFixed(1);
		$('#profile-stock-1').empty();
		var str_low_stock = '';
		if(config.warning == 1){
			str_low_stock = '<small style="color:red;"><b>' + Utils.translate('str_low_stock') + '</b></small>';
		}
		$('#profile-stock-1').append(stock_capacity_percent + '% ' + str_low_stock);
		$('#profile-stock-2').empty();
		$('#profile-stock-2').append(Utils.translate('str_stock_capacity').format(stock_capacity));
		$('#profile-stock-3').empty();
		$('#profile-stock-3').append('<div class="progress-bar bg-amber accent-4" role="progressbar" style="width: ' + stock_capacity_percent + '%" aria-valuenow="' + stock_capacity_percent + '" aria-valuemin="0" aria-valuemax="100"></div>');
		$('#stock-amount').empty();
		$('#stock-amount').append('(' + gas_station_business.stock_amount + ')');
		$('#stock-products').empty();
		
		/*==================
			FUEL PAGE
		==================*/
		$('#fuel-page').empty();
		$('#fuel-page').append(`
			<div class="col-md-6">
				<div id="fluid-meter-3"></div>
			</div>
			<div class="control-box">
				<div class="slider-content">
					<div class="icon"><i class="fas fa-wallet"></i></div>
					<div class="text">` + Utils.translate('str_gas_price') +`</div>
					<div class="value">` + gas_station_business.price + `</div>
					<button onclick="applyPrice()" class="btn btn-primary mt-5 pl-5 pr-5"><i class="fas fa-check"></i>&nbsp;&nbsp;` + Utils.translate('btn_apply_price') +`</button>
				</div>
				<div class="slider-container">
					<span class="bar"><span class="fill"></span></span>
					<input type="range" id="slider" class="slider" min="` + (config.gas_station_types.min_gas_price*100) + `" max="` + (config.gas_station_types.max_gas_price*100) + `" value="` + gas_station_business.price + `">
				</div>
			</div>
		`);
		
		// Fluid meter
		var fm3 = new FluidMeter();
		fm3.init({
			targetContainer: document.getElementById("fluid-meter-3"),
			fillPercentage: stock_capacity_percent,
			options: {
				fontSize: "70px",
				fontFamily: "Montserrat",
				bubbleAmount: (((gas_station_business.stock * 100)/stock_capacity)*2),
				drawPercentageSign: true,
				drawBubbles: false,
				size: 600,
				borderWidth: 19,
				backgroundColor: gas_station_users_theme.dark_theme ? "#2f2f2f" : "#e2e2e2",
				foregroundColor: gas_station_users_theme.dark_theme ? "#5a5a5a" : "#fafafa",
				fontFillStyle: gas_station_users_theme.dark_theme ? "#e1e1e1" : "white",
				foregroundFluidLayer: {
					fillStyle: "gold",
					angularSpeed: 30,
					maxAmplitude: 15,
					frequency: 70,
					horizontalSpeed: -40
				},
				backgroundFluidLayer: {
					fillStyle: "yellow",
					angularSpeed: 100,
					maxAmplitude: 4,
					frequency: 100,
					horizontalSpeed: 100
				}
			}
		});

		// Input range
		var controlBox = document.getElementsByClassName("control-box")[0];
		var cbSlider = controlBox.querySelector("input.slider");
		var cbFill = controlBox.querySelector(".bar .fill");
		var cbValue = controlBox.querySelector(".value");
		function setBar() {
			var min = parseInt(cbSlider.getAttribute("min"));
			var max = parseInt(cbSlider.getAttribute("max"));
			var value = parseInt(cbSlider.value);
			var percent = ((value -min) / (max - min)) * 100;

			cbFill.style.height = percent + "%";
			cbValue.innerText = Utils.currencyFormat((value/100));

			if (percent > 0) {
				controlBox.classList.add("on");
			} else {
				controlBox.classList.remove("on");
			}
		}
		cbSlider.addEventListener("input",setBar);
		setBar();

		/*
		* JOBS PAGE
		*/
		$('#job-page-list').empty();
		$('#form_product').empty();
		for (const key in config.gas_station_types.ressuply) {
			var ressuply = config.gas_station_types.ressuply[key];
			var amount = (ressuply.liters + Math.floor(ressuply.liters*(config.gas_station_types.upgrades.truck.level_reward[gas_station_business.truck_upgrade]/100)));
			var import_price = ressuply.price_per_liter_to_import*amount - (ressuply.price_per_liter_to_import*amount * config.gas_station_types.upgrades.relationship.level_reward[gas_station_business.relationship_upgrade])/100;
			var export_price = ressuply.price_per_liter_to_export*amount;
			$('#job-page-list').append(`
				<div class="mb-2">
					<div class="card overflow-hidden w-auto">
						<div class="card-content">
							<div class="card-body cleartfix">
								<div class="media align-items-stretch">
									<div class="align-self-center">
										<img class="font-large-2 mr-2 " src="img/` + ressuply.img + `" width="60">
									</div>
									<div class="media-body align-self-center">
										<h4>` + ressuply.name + `</h4>
									</div>
									<div class="d-flex align-self-center align-items-center">
										<h1 class="text-right">` + Utils.numberFormat(amount) + ` ` + Utils.translate('str_liters') + `</h1>
										<button onclick="startContract(1,` + key + `)" class="btn btn-primary ml-3 export-button">` + Utils.translate('btn_import') + ` ` + Utils.currencyFormat(import_price,0) + `</button>
										<button onclick="startContract(2,` + key + `)" class="btn btn-danger ml-3 export-button">` + Utils.translate('btn_export') + ` ` + Utils.currencyFormat(export_price,0) + `</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			`);
		}

		/*
		* CONTRACTS PAGE
		*/
		$('#form_amount').empty();
		$('#form_amount').append(`
			<input type="number" min="1" max="` + config.gas_station_types.ressuply_deliveryman.max_amount + `" name="amount" class="form-control" placeholder="` + Utils.translate('str_amount') + `" required="required" oninput="Utils.invalidMsg(this,1,` + config.gas_station_types.ressuply_deliveryman.max_amount + `);"> 
		`);
		$('#contracts-page-list').empty();
		for (const gas_station_job of gas_station_jobs) {
			var import_price = config.gas_station_types.ressuply_deliveryman.price_per_liter - (config.gas_station_types.ressuply_deliveryman.price_per_liter * config.gas_station_types.upgrades.relationship.level_reward[gas_station_business.relationship_upgrade])/100;
			var total_cost = gas_station_job.reward + import_price*gas_station_job.amount;
			$('#contracts-page-list').append(`
				<li class="d-flex justify-content-between card-theme">
					<div class="d-flex flex-row align-items-center"><img class="font-large-2 mr-2 " src="img/combustivel.png" width="30">
						<div class="ml-2">
							<h6 class="mb-0">` + gas_station_job.name + `</h6>
							<div class="d-flex flex-row mt-1 text-black-50 small">
								<div><i class="fas fa-coins"></i><span class="ml-2">` + Utils.translate('str_reward') + `: ` + Utils.currencyFormat(gas_station_job.reward) + `</span></div>
								<div class="ml-3"><i class="fas fa-coins"></i><span class="ml-2">` + Utils.translate('str_total_cost') + `: ` + Utils.currencyFormat(total_cost) + `</span></div>
								<div class="ml-3"><i class="fas fa-gas-pump"></i><span class="ml-2">` + Utils.translate('str_amount') + `: ` + gas_station_job.amount + `</span></div>
							</div>
						</div>
					</div>
					<div class="d-flex flex-row align-items-center">
						<button onclick="deleteJob(` + gas_station_job.id + `)" class="btn btn-danger">` + Utils.translate('btn_delete_contract') + `</button>
					</div>
				</li>
			`);
		}

		/*
		* EMPLOYEES PAGE
		*/
		if (item.update != true) {
			$('#input-hire-player').empty();
			$('#input-hire-player').append(`<option></option>`);
			for (const player of players) {
				$('#input-hire-player').append(`<option value="${player.identifier}">${player.name}</option>`);
			}
		}

		$('#hired-players-list').empty();
		for (const user of gas_station_employees) {
			let roles = {};
			roles[user.role] = 'selected';
			$('#hired-players-list').append(`
				<li class="d-flex justify-content-between card-theme">
					<div class="d-flex flex-row align-items-center"><img class="font-large-2 mr-2 " src="img/man.png" width="30">
						<div class="ml-2">
							<h6 class="mb-0">${user.name}</h6>
							<div class="d-flex flex-row mt-1 text-black-50 small">
								<div><i class="fas fa-truck-loading"></i><span class="ml-2">${Utils.translate('jobs_done')} ${user.jobs_done}</span></div>
								<div class="ml-3"><i class="fas fa-calendar-alt"></i><span class="ml-2">${Utils.translate('hired_date')} ${Utils.timeConverter(user.timer)}</span></div>
							</div>
						</div>
					</div>
					<div class="d-flex align-self-center">
						<div>
							<select id="change_role" name="role" class="form-control" required="required" style="font-size: 14px;height: 100%;">
								<option user="${user.user_id}" role="1" ${roles[1]??''}>${Utils.translate('basic_access')}</option>
								<option user="${user.user_id}" role="2" ${roles[2]??''}>${Utils.translate('advanced_access')}</option>
								<option user="${user.user_id}" role="3" ${roles[3]??''}>${Utils.translate('full_access')}</option>
							</select>
						</div>
						<div class="d-flex flex-row align-items-center">
							<input style="font-size: 14px;width: 160px;height: 100%;padding: 0px 0px 0px 5px" id="input-give-comission-${user.user_id}" class="input-give-comission form-control ml-3" type="number" min="1" max="9999999" placeholder="${Utils.translate('input_give_comission')}">
							<button onclick="giveComission('${user.user_id}')" class="btn btn-primary ml-3">${Utils.translate('button_give_comission')}</button>
						</div>
						<div class="d-flex flex-row align-items-center">
							<button onclick="firePlayer('${user.user_id}')" class="btn btn-danger ml-3">${Utils.translate('button_fire_employee')}</button>
						</div>
					<div>
				</li>
			`);
		}

		/*
		* UPGRADES PAGE
		*/
		$('#upgrades-page').empty();
		$('#upgrades-page').append(`
			<div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
				<div class="card shadow-sm border-0">
					<div class="card-body card-theme rounded p-4"><img src="https://cdn.discordapp.com/attachments/533398980428693550/804898333192880128/shop.png" alt="" class="img-fluid d-block mx-auto mb-3">
						<h5>${Utils.translate('str_stock_capacity_title')}</h5>
						<p style="height: 65px;" class="small text-muted font-italic">` + Utils.translate('str_stock_capacity_desc') + `</p>
						<ul class="small text-muted font-italic">
							<li> ` + Utils.translate('str_level') + ` 1: +` + config.gas_station_types.upgrades.stock.level_reward[1] + ` ` + Utils.translate('str_units') + `</li>
							<li> ` + Utils.translate('str_level') + ` 2: +` + config.gas_station_types.upgrades.stock.level_reward[2] + ` ` + Utils.translate('str_units') + `</li>
							<li> ` + Utils.translate('str_level') + ` 3: +` + config.gas_station_types.upgrades.stock.level_reward[3] + ` ` + Utils.translate('str_units') + `</li>
							<li> ` + Utils.translate('str_level') + ` 4: +` + config.gas_station_types.upgrades.stock.level_reward[4] + ` ` + Utils.translate('str_units') + `</li>
							<li> ` + Utils.translate('str_level') + ` 5: +` + config.gas_station_types.upgrades.stock.level_reward[5] + ` ` + Utils.translate('str_units') + `</li>
						</ul>
						<ul class="justify-content-center d-flex list-inline small">
							` + getStarsHTML(gas_station_business.stock_upgrade) + `
						</ul>
						<button onclick="buyUpgrade('stock')" class="btn btn-primary btn-block">` + Utils.translate('btn_buy') + ` ` + Utils.currencyFormat(config.gas_station_types.upgrades.stock.price,0) + `</button>
					</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
				<div class="card shadow-sm border-0">
					<div class="card-body card-theme rounded p-4"><img src="https://cdn.discordapp.com/attachments/533398980428693550/804898331159298078/delivery-truck.png" alt="" class="img-fluid d-block mx-auto mb-3">
						<h5>${Utils.translate('str_truck_capacity_title')}</h5>
						<p style="height: 65px;" class="small text-muted font-italic">` + Utils.translate('str_truck_capacity_desc') + `</p>
						<ul class="small text-muted font-italic">
							<li> ` + Utils.translate('str_level') + ` 1: +` + config.gas_station_types.upgrades.truck.level_reward[1] + ` % ` + Utils.translate('str_capacity') + `</li>
							<li> ` + Utils.translate('str_level') + ` 2: +` + config.gas_station_types.upgrades.truck.level_reward[2] + ` % ` + Utils.translate('str_capacity') + `</li>
							<li> ` + Utils.translate('str_level') + ` 3: +` + config.gas_station_types.upgrades.truck.level_reward[3] + ` % ` + Utils.translate('str_capacity') + `</li>
							<li> ` + Utils.translate('str_level') + ` 4: +` + config.gas_station_types.upgrades.truck.level_reward[4] + ` % ` + Utils.translate('str_capacity') + `</li>
							<li> ` + Utils.translate('str_level') + ` 5: +` + config.gas_station_types.upgrades.truck.level_reward[5] + ` % ` + Utils.translate('str_capacity') + `</li>
						</ul>
						<ul class="justify-content-center d-flex list-inline small">
							` + getStarsHTML(gas_station_business.truck_upgrade) + `
						</ul>
						<button onclick="buyUpgrade('truck')" class="btn btn-primary btn-block">` + Utils.translate('btn_buy') + ` ` + Utils.currencyFormat(config.gas_station_types.upgrades.truck.price,0) + `</button>
					</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
				<div class="card shadow-sm border-0">
					<div class="card-body card-theme rounded p-4"><img src="https://cdn.discordapp.com/attachments/533398980428693550/804898332371189780/manager.png" alt="" class="img-fluid d-block mx-auto mb-3">
						<h5>${Utils.translate('str_relationship_title')}</h5>
						<p style="height: 65px;" class="small text-muted font-italic">` + Utils.translate('str_relationship_desc') + `</p>
						<ul class="small text-muted font-italic">
							<li> ` + Utils.translate('str_level') + ` 1: ` + config.gas_station_types.upgrades.relationship.level_reward[1] + `% ` + Utils.translate('str_discount') + `</li>
							<li> ` + Utils.translate('str_level') + ` 2: ` + config.gas_station_types.upgrades.relationship.level_reward[2] + `% ` + Utils.translate('str_discount') + `</li>
							<li> ` + Utils.translate('str_level') + ` 3: ` + config.gas_station_types.upgrades.relationship.level_reward[3] + `% ` + Utils.translate('str_discount') + `</li>
							<li> ` + Utils.translate('str_level') + ` 4: ` + config.gas_station_types.upgrades.relationship.level_reward[4] + `% ` + Utils.translate('str_discount') + `</li>
							<li> ` + Utils.translate('str_level') + ` 5: ` + config.gas_station_types.upgrades.relationship.level_reward[5] + `% ` + Utils.translate('str_discount') + `</li>
						</ul>
						<ul class="justify-content-center d-flex list-inline small">
							` + getStarsHTML(gas_station_business.relationship_upgrade) + `
						</ul>
						<button onclick="buyUpgrade('relationship')" class="btn btn-primary btn-block">` + Utils.translate('btn_buy') + ` ` + Utils.currencyFormat(config.gas_station_types.upgrades.relationship.price,0) + `</button>
					</div>
				</div>
			</div>
		`);

		/*
		* BANK PAGE
		*/
		$('#bank-money').text(Utils.currencyFormat(gas_station_business.money,2));
		
		$('#withdraw-modal-money-available').text(`${Utils.translate('bank_page_modal_money_available').format(Utils.currencyFormat(gas_station_business.money))}`);
		$('#deposit-modal-money-available').text(`${Utils.translate('bank_page_modal_money_available').format(Utils.currencyFormat(item.dados.available_money))}`);

		$('#balance-table-body').empty();
		$('#balance-table-container').css('display', 'none');
		appendBalanceTable(gas_station_balance);

		if(item.update != true){
			/*
			* Lang texts
			*/
			$('#modal-confirm-title-2').empty();
			$('#modal-confirm-title-2').append(Utils.translate('confim_sell_title'));
			$('#modal-p-2').empty();
			$('#modal-p-2').append(Utils.translate('confim_sell_desc'));
			$('#modal-cancel-button-2').empty();
			$('#modal-cancel-button-2').append(Utils.translate('confim_sell_cancel_button'));
			$('#modal-confirm-button-2').empty();
			$('#modal-confirm-button-2').append(Utils.translate('confim_sell_confirm_button'));

			$('#span-main-page').empty();
			$('#span-main-page').append(Utils.translate('str_main_page_title_navbar'));
			$('#span-goods-page').empty();
			$('#span-goods-page').append(Utils.translate('str_goods_page_title_navbar'));
			$('#span-jobs-page').empty();
			$('#span-jobs-page').append(Utils.translate('str_jobs_page_title_navbar'));
			$('#span-hire-page').empty();
			$('#span-hire-page').append(Utils.translate('str_hire_page_title_navbar'));
			$('#span-upgrades-page').empty();
			$('#span-upgrades-page').append(Utils.translate('str_upgrades_page_title_navbar'));
			$('#span-bank-page').empty();
			$('#span-bank-page').append(Utils.translate('str_bank_page_title_navbar'));
			$('#span-employee-page').empty();
			$('#span-employee-page').append(Utils.translate('str_employee_page_title_navbar'));
			$('#span-sell-page').empty();
			$('#span-sell-page').append(Utils.translate('str_sell_page_title_navbar'));

			if (config.disable_rename_business) {
				$("#rename-business-container").css("display", "none");
			}

			$('#main-page-title').empty();
			$('#main-page-title').append(Utils.translate('str_main_page_title'));
			$('#main-page-desc').empty();
			$('#main-page-desc').append(Utils.translate('str_main_page_desc'));
			$('#profile-money-earned-2').empty();
			$('#profile-money-earned-2').append(Utils.translate('str_main_page_money_earned'));
			$('#profile-money-spent-2').empty();
			$('#profile-money-spent-2').append(Utils.translate('str_main_page_money_spent'));
			$('#profile-goods-2').empty();
			$('#profile-goods-2').append(Utils.translate('str_main_page_goods'));
			$('#profile-goods-sold-2').empty();
			$('#profile-goods-sold-2').append(Utils.translate('str_main_page_goods_sold'));
			$('#profile-distance-traveled-2').empty();
			$('#profile-distance-traveled-2').append(Utils.translate('str_main_page_distance_traveled'));
			$('#profile-total-visits-2').empty();
			$('#profile-total-visits-2').append(Utils.translate('str_main_page_total_visits'));
			$('#profile-customers-2').empty();
			$('#profile-customers-2').append(Utils.translate('str_main_page_customers'));

			$('#goods-page-title').empty();
			$('#goods-page-title').append(Utils.translate('str_goods_page_title'));
			$('#goods-page-desc').empty();
			$('#goods-page-desc').append(Utils.translate('str_goods_page_desc'));

			$('#jobs-page-title').empty();
			$('#jobs-page-title').append(Utils.translate('str_jobs_page_title'));
			$('#jobs-page-desc').empty();
			$('#jobs-page-desc').append(Utils.translate('str_jobs_page_desc'));

			$('#hire-page-title').empty();
			$('#hire-page-title').append(Utils.translate('str_hire_page_title'));
			$('#hire-page-desc').empty();
			$('#hire-page-desc').append(Utils.translate('str_hire_page_desc'));
			$('#hire-page-form').empty();
			$('#hire-page-form').append(`
				<div class="col-4">
					<input id="form_name" type="text" name="name" class="form-control" placeholder="` + Utils.translate('str_hire_page_form_job_name') + `" required="required" oninput="Utils.invalidMsg(this);"> 
				</div>
				<div class="col-3">
					<input id="form_reward" type="number" min="1" name="reward" class="form-control" placeholder="` + Utils.translate('str_hire_page_form_reward') + `" required="required" oninput="Utils.invalidMsg(this,1);"> 
				</div>
				<div class="col-3" id="form_amount">
					<input type="number" min="1" max="` + config.gas_station_types.ressuply_deliveryman.max_amount + `" name="amount" class="form-control" placeholder="` + Utils.translate('str_amount') + `" required="required" oninput="Utils.invalidMsg(this,1,` + config.gas_station_types.ressuply_deliveryman.max_amount + `);">
				</div>
				<div class="col-2"> 
					<button class="btn btn-primary btn-block">` + Utils.translate('btn_hire_page_form') + `</button>
				</div>
			`);

			$('#upgrades-page-title').empty();
			$('#upgrades-page-title').append(Utils.translate('str_upgrades_page_title'));
			$('#upgrades-page-desc').empty();
			$('#upgrades-page-desc').append(Utils.translate('str_upgrades_page_desc'));

			$('#employees-title').text(Utils.translate('employees_title'));
			$('#employees-page-desc').text(Utils.translate('employees_desc'));
			$('#button-hire-player').text(Utils.translate('button_employee'));

			// Bank page
			$('#bank-page-title').text(Utils.translate('bank_page_title'));
			$('#bank-page-desc').text(Utils.translate('bank_page_desc'));
			$('#withdraw-money-btn').text(Utils.translate('bank_page_withdraw'));
			$('#deposit-money-btn').text(Utils.translate('bank_page_deposit'));
			$('#bank-balance-text').text(`${Utils.translate('bank_page_balance_text')}`);
			
			$('#balance-table-title').text(`${Utils.translate('bank_page_balance_table_title')}`);
			$('#balance-title').text(`${Utils.translate('bank_page_balance_title')}`);
			$('#balance-value').text(`${Utils.translate('bank_page_balance_value')}`);
			$('#balance-date').text(`${Utils.translate('bank_page_balance_date')}`);
			$('#bank-page-show-hidden').text(Utils.translate('bank_page_hidden_balance'));

			$('#deposit-modal-title').text(`${Utils.translate('bank_page_deposit_modal_title')}`);
			$('#deposit-modal-desc').text(`${Utils.translate('bank_page_deposit_modal_desc')}`);
			$('#deposit-modal-money-amount').attr('placeholder',Utils.translate('bank_page_modal_placeholder'));
			$('#deposit-modal-cancel').text(`${Utils.translate('bank_page_modal_cancel')}`);
			$('#deposit-modal-submit').text(`${Utils.translate('bank_page_deposit_modal_submit')}`);

			$('#withdraw-modal-title').text(`${Utils.translate('bank_page_withdraw_modal_title')}`);
			$('#withdraw-modal-desc').text(`${Utils.translate('bank_page_withdraw_modal_desc')}`);
			$('#withdraw-modal-money-amount').attr('placeholder',Utils.translate('bank_page_modal_placeholder'));
			$('#withdraw-modal-cancel').text(`${Utils.translate('bank_page_modal_cancel')}`);
			$('#withdraw-modal-submit').text(`${Utils.translate('bank_page_withdraw_modal_submit')}`);
		}

		$("form").submit(function(e){
			e.preventDefault();
		});

		$('#change_role').change(function() {
			changeRole($('option:selected', this).attr('user'),$('option:selected', this).attr('role'))
		});

		$(document).ready(function() {
			$('#input-hire-player').select2({
				placeholder: Utils.translate('select_employee')
			});
		});
	}
	if (item.hidemenu){
		$(".main").fadeOut(200);
	}
});


/*=================
	FUNCTIONS
=================*/

function openPage(pageN){
	if (role_level_id >= config.roles_permissions[pageN]){
		$(".pages").css("display", "none");
		$("."+pageN+"-page").css("display", "block");

		var titleHeight = $(`#${pageN}-title-div`).outerHeight(true) ?? 0;
		var footerHeight = $(`#${pageN}-footer-div`).outerHeight(true) ?? 0;
		$(':root').css(`--${pageN}-title-height`, (titleHeight+footerHeight) + 'px');
	}
}

function appendBalanceTable(gas_station_balance) {
	for (const balance of gas_station_balance) {
		let tstyle = '';
		let tclass = '';
		let tbutton = `<button class="btn btn-outline-primary" style="min-width: 200px;" onclick="hideBalance(${balance.id})" >${Utils.translate('bank_page_hide_balance')}</button>`;
		if (balance.hidden == 1) {
			if (!$('#show-hidden-balance').is(":checked")) {
				tstyle = 'style="display: none !important;"';
			}
			tclass = 'hidden-balance';
			tbutton = `<button class="btn btn-outline-success" style="min-width: 200px;" onclick="showBalance(${balance.id})" >${Utils.translate('bank_page_show_balance')}</button>`;
		}

		let tcolor = 'text-success';
		if (balance.income == 1) {
			tcolor = 'text-danger';
		}

		$('#balance-table-body').append(`
			<tr class="${tclass}" ${tstyle}>
				<td>${balance.title}</td>
				<td class="${tcolor}">${Utils.currencyFormat(balance.amount)}</td>
				<td>${Utils.timeConverter(balance.date)}</td>
				<td>${tbutton}</td>
			</tr>
		`);
		$('#balance-table-container').css('display', '');
	}
	if (gas_station_balance.length >= 50) {
		$('#balance-table-body').append(`
			<tr id="load-more-row">
				<td colspan="4">
					<div class="d-flex align-items-center justify-content-center">
						<button class="btn btn-primary" style="min-width: 200px;" onclick="loadBalanceHistory(${gas_station_balance.slice(-1)[0].id})" >${Utils.translate('bank_page_load_balance')}</button>
					</div>
				</td>
			</tr>
		`);
	}
}

function getStarsHTML(value){
	var html = "";
	for (var i = 1; i <= 5; i++) {
		if(i <= value){
			html += '<li class="list-inline-item m-1"><i class="fa-solid fa-star amber accent-4 font-large-1"></i></li>';
		}else{
			html += '<li class="list-inline-item m-1"><i class="fa-regular fa-star amber accent-4 font-large-1"></i></li>';
		}
	}
	return html;
}

$('.sidebar-navigation ul li').on('click', function() {
	$('li').removeClass('active');
	$(this).addClass('active');
});

$('#show-hidden-balance').change(function() {
	if($(this).is(":checked")) {
		$('.hidden-balance').css("display", "");
	} else {
		$('.hidden-balance').css("display", "none");
	}
});

$('#buyModal').on('hidden.bs.modal', function () {
	closeUI();
})

/*=================
	CALLBACKS
=================*/

function closeUI(){
	Utils.post("close","")
}
function startContract(type,ressuply_id){
	Utils.post("startContract",{type:type,ressuply_id:ressuply_id})
}
function loadBalanceHistory(last_balance_id){
	$("#spinner").fadeIn("fast");
	Utils.post("loadBalanceHistory", { last_balance_id }, "loadBalanceHistory", function (gas_station_balance) {
		$("#load-more-row").remove();
		if (gas_station_balance.length > 0) {
			appendBalanceTable(gas_station_balance)
		}
		$("#spinner").fadeOut("fast");
	})
}
$(document).ready( function() {
	$('#css-toggle').on('change', function(){
		if($(this).prop("checked") == false){
			// Light theme
			$('#css-bs-light').prop('disabled', false);
			$('#css-light').prop('disabled', false);
			setTimeout(function() {
				$('#css-bs-dark').prop('disabled', true);
				$('#css-dark').prop('disabled', true);
			}, 5);
			$('#dark-theme-icon').css("display", "");
			$('#light-theme-icon').css("display", "none");
			changeTheme(0)
		} else if($(this).prop("checked") == true){
			// Dark theme
			$('#css-bs-dark').prop('disabled', false);
			$('#css-dark').prop('disabled', false);
			setTimeout(function() {
				$('#css-bs-light').prop('disabled', true);
				$('#css-light').prop('disabled', true);
			}, 5);
			$('#dark-theme-icon').css("display", "none");
			$('#light-theme-icon').css("display", "");
			changeTheme(1)
		}
	});

	$("#contact-form").on('submit', function(e){
		e.preventDefault();
		var form = $('#contact-form').serializeArray();
		Utils.post("createJob",{name:form[0].value,reward:form[1].value,amount:form[2].value})
	});

	$("#rename-form").on('submit', function(e){
		e.preventDefault();
		var form = $('#rename-form').serializeArray();
		var e = document.getElementById("form_blip_color");
		var color_id = e.options[e.selectedIndex].getAttribute('color_id');
		var e = document.getElementById("form_blip_id");
		var blip_id = e.options[e.selectedIndex].getAttribute('blip_id');
		Utils.post("renameMarket",{name:form[0].value,color:color_id,blip:blip_id})
	});

	$("#form-deposit-money").on('submit', function(e){
		e.preventDefault();
		var form = $('#form-deposit-money').serializeArray();
		$('#deposit-modal-money-amount').val(null);
		$("#deposit-modal").modal('hide');
		Utils.post("depositMoney",{amount:form[0].value})
	});

	$("#form-withdraw-money").on('submit', function(e){
		e.preventDefault();
		var form = $('#form-withdraw-money').serializeArray();
		$('#withdraw-modal-money-amount').val(null);
		$("#withdraw-modal").modal('hide');
		Utils.post("withdrawMoney",{amount:form[0].value})
	});
})

function deleteJob(job_id){
	Utils.post("deleteJob",{job_id:job_id})
}
function buyUpgrade(id){
	Utils.post("buyUpgrade",{id:id})
}
function buyMarket(){
	Utils.post("buyMarket",{})
}
function sellMarket(){
	Utils.post("sellMarket",{})
}
function applyPrice(){
	var controlBox = document.getElementsByClassName("control-box")[0];
	var cbSlider = controlBox.querySelector("input.slider");
	var value = parseInt(cbSlider.value);
	Utils.post("applyPrice",{value:value})
}
function hirePlayer() {
	let user = document.getElementById('input-hire-player').value;
	$("#input-hire-player").val($("#input-hire-player option:first").val());
	Utils.post("hirePlayer",{user})
}
function firePlayer(user) {
	Utils.showDefaultDangerModal(() => Utils.post("firePlayer",{user}), Utils.translate('confirmation_modal_fire_player'));
}
function giveComission(user) {
	let amount = document.getElementById('input-give-comission-'+user).value;
	document.getElementById('input-give-comission-'+user).value = null;
	Utils.post("giveComission",{user,amount})
}
function changeRole(user_id,role){
	Utils.post("changeRole",{user_id:user_id,role:role})
}
function hideBalance(balance_id){
	Utils.post("hideBalance",{balance_id:balance_id})
}
function showBalance(balance_id){
	Utils.post("showBalance",{balance_id:balance_id})
}
function changeTheme(dark_theme){
	Utils.post("changeTheme",{dark_theme})
}

/**
 * Javascript Fluid Meter
 * by Angel Arcoraci
 * https://github.com/aarcoraci
 * 
 * MIT License
 */

function FluidMeter() {
var context;
var targetContainer;

var time = null;
var dt = null;

var options = {
	drawShadow: true,
	drawText: true,
	drawPercentageSign: true,
	drawBubbles: true,
	bubbleAmount: 0,
	fontSize: "70px",
	fontFamily: "Arial",
	fontFillStyle: "white",
	size: 300,
	borderWidth: 25,
	backgroundColor: "#e2e2e2",
	foregroundColor: "#fafafa"
};

var currentFillPercentage = 0;
var fillPercentage = 0;

//#region fluid context values
var foregroundFluidLayer = {
	fillStyle: "purple",
	angle: 0,
	horizontalPosition: 0,
	angularSpeed: 0,
	maxAmplitude: 9,
	frequency: 30,
	horizontalSpeed: -150,
	initialHeight: 0
};

var backgroundFluidLayer = {
	fillStyle: "pink",
	angle: 0,
	horizontalPosition: 0,
	angularSpeed: 140,
	maxAmplitude: 12,
	frequency: 40,
	horizontalSpeed: 150,
	initialHeight: 0
};

var bubblesLayer = {
	bubbles: [],
	speed: 20,
	current: 0,
	swing: 0,
	size: 2,
	reset: function (bubble) {
	// calculate the area where to spawn the bubble based on the fluid area
	var meterBottom = (options.size - (options.size - getMeterRadius()) / 2) - options.borderWidth;
	var fluidAmount = currentFillPercentage * (getMeterRadius() - options.borderWidth * 2) / 100;

	bubble.r = random(this.size, this.size * 2) / 2;
	bubble.x = random(0, options.size);
	bubble.y = random(meterBottom, meterBottom - fluidAmount);
	bubble.velX = 0;
	bubble.velY = random(this.speed, this.speed * 2);
	bubble.swing = random(0, 2 * Math.PI);
	},
	init() {
	for (var i = 0; i < options.bubbleAmount; i++) {

		var meterBottom = (options.size - (options.size - getMeterRadius()) / 2) - options.borderWidth;
		var fluidAmount = currentFillPercentage * (getMeterRadius() - options.borderWidth * 2) / 100;
		this.bubbles.push({
		x: random(0, options.size),
		y: random(meterBottom, meterBottom - fluidAmount),
		r: random(this.size, this.size * 2) / 2,
		velX: 0,
		velY: random(this.speed, this.speed * 2)
		});
	}
	}
}
//#endregion

/**
 * initializes and mount the canvas element on the document
 */
function setupCanvas() {
	var canvas = document.createElement('canvas');
	canvas.width = options.size;
	canvas.height = options.size;
	canvas.imageSmoothingEnabled = true;
	context = canvas.getContext("2d");
	targetContainer.appendChild(canvas);

	// shadow is not required  to be on the draw loop
	//#region shadow
	if (options.drawShadow) {
	context.save();
	context.beginPath();
	context.filter = "drop-shadow(0px 4px 6px rgba(0,0,0,0.1))";
	context.arc(options.size / 2, options.size / 2, getMeterRadius() / 2, 0, 2 * Math.PI);
	context.closePath();
	context.fill();
	context.restore();
	}
	//#endregion
}

/**
 * draw cycle
 */
function draw() {
	var now = new Date().getTime();
	dt = (now - (time || now)) / 1000;
	time = now;

	requestAnimationFrame(draw);
	context.clearRect(0, 0, options.width, options.height);
	drawMeterBackground();
	drawFluid(dt);
	if (options.drawText) {
	drawText();
	}
	drawMeterForeground();
}

function drawMeterBackground() {
	context.save();
	context.fillStyle = options.backgroundColor;
	context.beginPath();
	context.arc(options.size / 2, options.size / 2, getMeterRadius() / 2 - options.borderWidth, 0, 2 * Math.PI);
	context.closePath();
	context.fill();
	context.restore();
}

function drawMeterForeground() {
	context.save();
	context.lineWidth = options.borderWidth;
	context.strokeStyle = options.foregroundColor;
	context.beginPath();
	context.arc(options.size / 2, options.size / 2, getMeterRadius() / 2 - options.borderWidth / 2, 0, 2 * Math.PI);
	context.closePath();
	context.stroke();
	context.restore();
}
/**
 * draws the fluid contents of the meter
 * @param  {} dt elapsed time since last frame
 */
function drawFluid(dt) {
	context.save();
	context.arc(options.size / 2, options.size / 2, getMeterRadius() / 2 - options.borderWidth, 0, Math.PI * 2);
	context.clip();
	drawFluidLayer(backgroundFluidLayer, dt);
	drawFluidLayer(foregroundFluidLayer, dt);
	if (options.drawBubbles) {
	drawFluidMask(foregroundFluidLayer, dt);
	drawBubblesLayer(dt);
	}
	context.restore();
}


/**
 * draws the foreground fluid layer
 * @param  {} dt elapsed time since last frame
 */
function drawFluidLayer(layer, dt) {
	// calculate wave angle
	if (layer.angularSpeed > 0) {
	layer.angle += layer.angularSpeed * dt;
	layer.angle = layer.angle < 0 ? layer.angle + 360 : layer.angle;
	}

	// calculate horizontal position
	layer.horizontalPosition += layer.horizontalSpeed * dt;
	if (layer.horizontalSpeed > 0) {
	layer.horizontalPosition > Math.pow(2, 53) ? 0 : layer.horizontalPosition;
	}
	else if (layer.horizontalPosition < 0) {
	layer.horizontalPosition < -1 * Math.pow(2, 53) ? 0 : layer.horizontalPosition;
	}

	var x = 0;
	var y = 0;
	var amplitude = layer.maxAmplitude * Math.sin(layer.angle * Math.PI / 180);

	var meterBottom = (options.size - (options.size - getMeterRadius()) / 2) - options.borderWidth;
	var fluidAmount = currentFillPercentage * (getMeterRadius() - options.borderWidth * 2) / 100;

	if (currentFillPercentage < fillPercentage) {
	currentFillPercentage += 15 * dt;
	} else if (currentFillPercentage > fillPercentage) {
	currentFillPercentage -= 15 * dt;
	}

	layer.initialHeight = meterBottom - fluidAmount;

	context.save();
	context.beginPath();

	context.lineTo(0, layer.initialHeight);

	while (x < options.size) {
	y = layer.initialHeight + amplitude * Math.sin((x + layer.horizontalPosition) / layer.frequency);
	context.lineTo(x, y);
	x++;
	}

	context.lineTo(x, options.size);
	context.lineTo(0, options.size);
	context.closePath();

	context.fillStyle = layer.fillStyle;
	context.fill();
	context.restore();
}

/**
 * clipping mask for objects within the fluid constrains
 * @param {Object} layer layer to be used as a mask
 */
function drawFluidMask(layer) {
	var x = 0;
	var y = 0;
	var amplitude = layer.maxAmplitude * Math.sin(layer.angle * Math.PI / 180);

	context.beginPath();

	context.lineTo(0, layer.initialHeight);

	while (x < options.size) {
	y = layer.initialHeight + amplitude * Math.sin((x + layer.horizontalPosition) / layer.frequency);
	context.lineTo(x, y);
	x++;
	}
	context.lineTo(x, options.size);
	context.lineTo(0, options.size);
	context.closePath();
	context.clip();
}

function drawBubblesLayer(dt) {
	context.save();
	for (var i = 0; i < bubblesLayer.bubbles.length; i++) {
	var bubble = bubblesLayer.bubbles[i];

	context.beginPath();
	context.strokeStyle = 'white';
	context.arc(bubble.x, bubble.y, bubble.r, 2 * Math.PI, false);
	context.stroke();
	context.closePath();

	var currentSpeed = bubblesLayer.current * dt;

	bubble.velX = Math.abs(bubble.velX) < Math.abs(bubblesLayer.current) ? bubble.velX + currentSpeed : bubblesLayer.current;
	bubble.y = bubble.y - bubble.velY * dt;
	bubble.x = bubble.x + (bubblesLayer.swing ? 0.4 * Math.cos(bubblesLayer.swing += 0.03) * bubblesLayer.swing : 0) + bubble.velX * 0.5;

	// determine if current bubble is outside the safe area
	var meterBottom = (options.size - (options.size - getMeterRadius()) / 2) - options.borderWidth;
	var fluidAmount = currentFillPercentage * (getMeterRadius() - options.borderWidth * 2) / 100;

	if (bubble.y <= meterBottom - fluidAmount) {
		bubblesLayer.reset(bubble);
	}

	}
	context.restore();
}

function drawText() {

	var text = options.drawPercentageSign ?
	currentFillPercentage.toFixed(0) + "%" : currentFillPercentage.toFixed(0);

	context.save();
	context.font = getFontSize();
	context.fillStyle = options.fontFillStyle;
	context.textAlign = "center";
	context.textBaseline = 'middle';
	context.filter = "drop-shadow(0px 0px 5px rgba(0,0,0,0.4))"
	context.fillText(text, options.size / 2, options.size / 2);
	context.restore();
}

//#region helper methods
function clamp(number, min, max) {
	return Math.min(Math.max(number, min), max);
};
function getMeterRadius() {
	return options.size * 0.9;
}

function random(min, max) {
	var delta = max - min;
	return max === min ? min : Math.random() * delta + min;
}

function getFontSize() {
	return options.fontSize + " " + options.fontFamily;
}
//#endregion

return {
	init: function (env) {
	if (!env.targetContainer)
		throw "empty or invalid container";

	targetContainer = env.targetContainer;
	fillPercentage = clamp(env.fillPercentage, 0, 100);
	if (env.options) {
		options.drawShadow = env.options.drawShadow === false ? false : true;
		options.size = env.options.size;
		options.drawBubbles = env.options.drawBubbles === false ? false : true;
		options.borderWidth = env.options.borderWidth || options.borderWidth;
		options.foregroundFluidColor = env.options.foregroundFluidColor || options.foregroundFluidColor;
		options.backgroundFluidColor = env.options.backgroundFluidColor || options.backgroundFluidColor;
		options.backgroundColor = env.options.backgroundColor || options.backgroundColor;
		options.foregroundColor = env.options.foregroundColor || options.foregroundColor;

		options.drawText = env.options.drawText === false ? false : true;
		options.drawPercentageSign = env.options.drawPercentageSign === false ? false : true;
		options.bubbleAmount = Math.round(env.options.bubbleAmount) || options.bubbleAmount;
		options.fontSize = env.options.fontSize || options.fontSize;
		options.fontFamily = env.options.fontFamily || options.fontFamily;
		options.fontFillStyle = env.options.fontFillStyle || options.fontFillStyle;
		// fluid settings

		if (env.options.foregroundFluidLayer) {
		foregroundFluidLayer.fillStyle = env.options.foregroundFluidLayer.fillStyle || foregroundFluidLayer.fillStyle;
		foregroundFluidLayer.angularSpeed = env.options.foregroundFluidLayer.angularSpeed || foregroundFluidLayer.angularSpeed;
		foregroundFluidLayer.maxAmplitude = env.options.foregroundFluidLayer.maxAmplitude || foregroundFluidLayer.maxAmplitude;
		foregroundFluidLayer.frequency = env.options.foregroundFluidLayer.frequency || foregroundFluidLayer.frequency;
		foregroundFluidLayer.horizontalSpeed = env.options.foregroundFluidLayer.horizontalSpeed || foregroundFluidLayer.horizontalSpeed;
		}

		if (env.options.backgroundFluidLayer) {
		backgroundFluidLayer.fillStyle = env.options.backgroundFluidLayer.fillStyle || backgroundFluidLayer.fillStyle;
		backgroundFluidLayer.angularSpeed = env.options.backgroundFluidLayer.angularSpeed || backgroundFluidLayer.angularSpeed;
		backgroundFluidLayer.maxAmplitude = env.options.backgroundFluidLayer.maxAmplitude || backgroundFluidLayer.maxAmplitude;
		backgroundFluidLayer.frequency = env.options.backgroundFluidLayer.frequency || backgroundFluidLayer.frequency;
		backgroundFluidLayer.horizontalSpeed = env.options.backgroundFluidLayer.horizontalSpeed || backgroundFluidLayer.horizontalSpeed;
		}
	}



	bubblesLayer.init();
	setupCanvas();
	draw();
	},
	setPercentage(percentage) {

	fillPercentage = clamp(percentage, 0, 100);
	}
}
};