function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

CreateThread(function()
	AddTextEntry("tr_pdchar_livery10", "[TR] State Interceptor")
	AddTextEntry("tr_pdcv_livery10", "[TR] State Interceptor")
	AddTextEntry("tr_pddm_livery10", "[TR] State Interceptor")
	AddTextEntry("tr_pddurango_livery10", "[TR] State Interceptor")
	AddTextEntry("tr_pdmstang_livery10", "[TR] State Interceptor")
end)

--[[ Carcol.lua for each vehicle
    -- Charger
<Item>
<modelName>tr_pdchar_livery10</modelName>
<modShopLabel>tr_pdchar_livery10</modShopLabel>
<linkedModels />
<turnOffBones />
<type>VMT_LIVERY_MOD</type>
<bone>chassis</bone>
<collisionBone>chassis</collisionBone>
<cameraPos>VMCP_DEFAULT</cameraPos>
<audioApply value="1.000000" />
<weight value="20" />
<turnOffExtra value="false" />
<disableBonnetCamera value="false" />
<allowBonnetSlide value="true" />
</Item>

-- Demon
<Item>
<modelName>tr_pddm_livery10</modelName>
<modShopLabel>tr_pddm_livery10</modShopLabel>
<linkedModels />
<turnOffBones />
<type>VMT_LIVERY_MOD</type>
<bone>chassis</bone>
<collisionBone>chassis</collisionBone>
<cameraPos>VMCP_DEFAULT</cameraPos>
<audioApply value="1.000000" />
<weight value="20" />
<turnOffExtra value="false" />
<disableBonnetCamera value="false" />
<allowBonnetSlide value="true" />
</Item>

-- cv
<Item>
<modelName>tr_pdcv_livery10</modelName>
<modShopLabel>tr_pdcv_livery10</modShopLabel>
<linkedModels />
<turnOffBones />
<type>VMT_LIVERY_MOD</type>
<bone>chassis</bone>
<collisionBone>chassis</collisionBone>
<cameraPos>VMCP_DEFAULT</cameraPos>
<audioApply value="1.000000" />
<weight value="20" />
<turnOffExtra value="false" />
<disableBonnetCamera value="false" />
<allowBonnetSlide value="true" />
</Item>

-- durango
<Item>
<modelName>tr_pddurango_livery10</modelName>
<modShopLabel>tr_pddurango_livery10</modShopLabel>
<linkedModels />
<turnOffBones />
<type>VMT_LIVERY_MOD</type>
<bone>chassis</bone>
<collisionBone>chassis</collisionBone>
<cameraPos>VMCP_DEFAULT</cameraPos>
<audioApply value="1.000000" />
<weight value="20" />
<turnOffExtra value="false" />
<disableBonnetCamera value="false" />
<allowBonnetSlide value="true" />
</Item>

-- Mustang
<Item>
<modelName>tr_pdmstang_livery10</modelName>
<modShopLabel>tr_pdmstang_livery10</modShopLabel>
<linkedModels />
<turnOffBones />
<type>VMT_LIVERY_MOD</type>
<bone>chassis</bone>
<collisionBone>chassis</collisionBone>
<cameraPos>VMCP_DEFAULT</cameraPos>
<audioApply value="1.000000" />
<weight value="20" />
<turnOffExtra value="false" />
<disableBonnetCamera value="false" />
<allowBonnetSlide value="true" />
</Item> ]]
