if not locals then locals ={} end
locals["EN"] = {
  ["uiTitle"]                  ="PLT Lumberjack Jobs",
  ["uiCuttingTitle"]           ="Tree Cuttings",
  ["uiCuttingComment"]         ="Tree cutting works with chainsaw and transporting logs to the stand with the telehandler.",
  ["uiCuttingMoneyText"]       ="Each tree",
  ["uiStackingTitle"]          ="Stacking Pallet of Lumbers",
  ["uiStackingComment"]        ="Placing the pallet of lumbers on empty trailers or parking the forklift on a suitable trailer.",
  ["uiStacking1MoneyText"]     ="Each pallet",
  ["uiStacking2MoneyText"]     ="Parking each forklift",
  ["uiDeliveryTitle"]          ="Delivery of Lumbers",
  ["uiDeliveryComment"]        ="Transporting the pallet of lumbers to the construction with a truck, handing over and bringing the turck back.",
  ["uiDelivery1MoneyText"]     ="Each delivery",
  ["uiDelivery2MoneyText"]     ="Travel expenses",
  ["uiJobOutfitTitle"]         ="Workwear",
  ["uiDailyOutfitTitle"]       ="Casual Clothes",
  ["uiCancelJobTitle"]         ="Cancel the Job&nbsp;",
  ["uiAlreadyWorking"]         ={type="error",duration=5000,text="You are already working."},
  ["uiAlreadyNotWorking"]      ={type="error",duration=5000,text="You are already out of work."},
  ["uiCantThisJob"]            ={type="error",duration=5000,text="You don't have the authorization to do this job."},
  ["uiAlreadyWearJob"]         ={type="error",duration=5000,text="You are already wearing your workwear."},
  ["uiAlreadyWearDaily"]       ={type="error",duration=5000,text="You are already wearing your casual clothes."},
  ["goForCuttableTree"]        ="Go to a suitable tree to begin the job, get off the telehandler and get close to the tree. Check GPS for coordination.",
  ["goForCutWood"]             ="Get close to the marked zone to be able to start cutting.",
  ["needGetInTelehandler"]     ="Get on to the telehandler to continue the work.",
  ["needGetInForklift"]        ="Get on to the forklift to continue the work.",
  ["needGetInTruck"]           ="Get on to the truck to continue the work.",
  ["loadWoodToTelehandler"]    ="Load the logs to the telehandler.",
  ["forksNeedCloserToMarker"]  ="Drive the telehandler to the log just like shown with the marks.",
  ["forksNeedParallelMarker"]  ="Bring the telehandler forks to the marked zone.",
  ["dropWoodsLikeMarker"]      ="Leave the logs to the marked zone just like shown with the marks.",
  ["moveWoodsToDeliveryPoint"] ="Bring the logs to the '%s' on the map.",
  ["takeWoodOrParkForklift"]   ="Load pallet of lumbers to the forklift or drive and park the forklift on the marked truck.",
  ["goTakeWoodpile"]           ="Load pallet of lumbers with the forklift.",
  ["goParkForklift"]           ="Drive and park the forklift on the marked truck. There is no available truck to load pallet of lumbers.",
  ["noMoreJobStacking"]        ="There is no more work to do here. Deliver the forklift and finish the job.",
  ["slowDown"]                 ="Slow down...",
  ["forkliftParallelToTrailer"]="Forklift has to point same direction as the trailer.",
  ["parkForkliftLikeMarker"]   ="To be able to park the forklift on the trailer, drive the forklift just like shown with the marks.",
  ["moveForksUpDown"]          ="Move the forks of the forklift up/down.",
  ["moveForksLikeMarker"]      ="Place the forks of the forklift as marked.",
  ["dropWoodPileToTrailer"]    ="Load the pallet of lumbers on one of the marked trailer.",
  ["WoodpileParellelToTrailer"]="Pallet of lumbers has to be parallel with the trailer.",
  ["moveWoodpileToMarker"]     ="Fill the green zone with the pallet.",
  ["noTrailerDeliveryForklift"]="There is no available truck to load pallet of lumbers. Deliver the forklift.",
  ["attachTrailerToTruck"]     ="Load the trailer to the truck.",
  ["goAnyConstructionDelivery"]="Deliver the pallet of lumbers. Delivery points (%s) are marked on your GPS. You will gain more money if you deliver farther.",
  ["noConstructionsInDistance"]="There is to available delivery point around or this construction needs no lumbers. Park the forklift on the trailer again.",
  ["getOutTrailerForDelivery"] ="Park the truck if you want to deliver the lumbers. You will get '%s' for the delivery and '%s' for travel expenses.",
  ["getInForkliftTakeWoodpile"]="Get on the forklift to pick up the lumbers.",
  ["takeWoodpileFromTrailer"]  ="pick up the lumbers from the trailer.",
  ["forkliftPerpenToTrailer"]  ="Forklift has to be vertical to the trailer.",
  ["MoveWoodpileLikeMarker"]   ="Place the pallet of lumbers on the green zone.",
  ["setWoodpileHeadingMarker"] ="The direction of the pallet of lumbers has to be like blue lines.",
  ["parkForliftToTrailer"]     ="Park the forklift on to the trailer.",
  ["nearSeatShouldEmpty"]      ="The passenger seat has to be empty!",
  ["trailerParallelToTrailer"] ="The truck and the trailer has to be parallel.",
  ["truckHeadingNeedParallel"] ="The direction of the truck has to be just like shown with the marks.",
  ["parkTruckLikeMarker"]      ="Park the truck on the marked zone.",
  ["goToJobCenter"]            ="Drive and deliver the truck back.",
  ["getOutOfForklift"]         ="Get off the Forklift.",
  ["clearAreaForWoodpile"]     ="Make room for the upcoming pallet of lumbers.",
  ["clearAreaForTruck"]        ="~w~This area is for the trucks only. Do not leave your vehicle here!!!",
  ["interactionToAction"]      ={key=46,button={{"Interaction:", 46}},text ="Interact to take action."},
  ["interactionToDelivery"]    ={key=46,button={{"Interaction:", 46}},text ="The truck is ready for delivery of lumbers. Interact to start the job."},
  ["interactionCompltCutting"] ={key=46,button={{"Interaction:", 46}},text ="Interact to deliver the telehandler and to finish the job."},
  ["interactionWantCuttinTree"]={key=46,button={{"Interaction:", 46}},text ="Interact to start cutting down the tree."},
  ["interactionCuttinWood"]    ={key=46,button={{"Interaction:", 46}},text ="Interact to start cutting."},
  ["interactionDropToWoodPile"]={key=46,button={{"Interaction:", 46}},text ="Interact to leave the pallet of lumbers."},
  ["interactionCompltStacking"]={key=46,button={{"Interaction:", 46}},text ="Interact to deliver the forklift and finish the job."},
  ["interactionForUseForklift"]={key={33,32},button={{"Interactions:", {33,32}}},text ="Interact to start driving the forklift."},
  ["interactionForkliftToPark"]={key=46,button={{"Interaction:", 46}},text ="Interact to park the forklift on to the trailer."},
  ["interactionCancelAnim"]    ={key=177,button={{"Interactions :", {177,25,202}}},text ="Interact to cancel the process. Chainsaw sound volume is '%s' if you want to change type; '/%s 15.2'"},
  ["interactionForApprovePos"] ={key=46,button={{"Approve :", 46},{"Speed up", 21},{"",{207,208,109,108,110,111}}},text ="Would you like to add this tree to this position?"},
  ["interactionForAddAngle"]   ={key=46,button={{"Add:", 46},{"don't add:", 177}},text ="Do you want to approve the angle of the falling tree?"},
  ["interactionNewConsBlip"]   ={key=46,button={{"Interaction:", 46}},text ="Interact to add construction delivery blip."},
  ["interactionNewConsFirst"]  ={key=46,button={{"Interaction:", 46}},text ="Interact to add the first pallet of lumber position."},
  ["interactionNewConsPos"]    ={key=46,button={{"Approve:",46},{"Finish",73},{"Speed up",21},{"",{172,174,173,175,207,208,108,109,110,111,117,118,314}}},text ="Set the position of the pallet of lumbers, approve or finish if you are done adding."},
  ["interactionNewConsSide"]   ={key=46,button={{" Approve:",46},{"Speed up",21},{"",{172,173,174,175}}},text ="Where would be the new pallet of lumbers be, please choose."},
  ["deliveyWoodToStand"]       ={type="error",  duration=10000,text="To finish the job deliver the logs to the '/%s' on the GPS."},
  ["cantFellingThisHeading"]   ={type="error",  duration=15000,text="There is a vehicle at the place the tree will fall. Plase remove the vehicle or change the tree's falling direction."},
  ["startCuttingJob"]          ={type="inform", duration=15000,text="A random tree is marked on your GPS. You can cut another tree as well if you would like to."},
  ["startStackingJob"]         ={type="inform", duration=15000,text="Pick up the marked pallet of lumbers. Place the lumbers on a marked trailer or park the forklift on a marked trailer."},
  ["startDeliveryJob"]         ={type="inform", duration=15000,text="A random construction is marked on your GPS. You can deliver to a different construction if you would like to."},
  ["vehicleSpawnPointsFull"]   ={type="error",  duration=10000,text="All the vehicle spawn points are full!"},
  ["noAnyWoodpile"]            ={type="error",  duration=10000,text="There are none pallet of lumbers available right now."},
  ["woodpileCantloadToTruck"]  ={type="error",  duration=10000,text="All the trucks are not avaible for placing the pallet of lumbers to trailer."},
  ["forkliftCantPartToTruck"]  ={type="error",  duration=10000,text="All the trucks are not avaible for parking the forklift to trailer."},
  ["newChainSawVolume"]        ={type="inform", duration=20000,text="New voice level of chainsaw is set to '%s' ",},
  ["wrongChainSawVolume"]      ={type="warning",duration=20000,text="Please enter a number between 0.0 and 100. For example '/%s 15.2' "},
  ["clothesForYou"]            ={type="error",  duration=10000,text="There are no clothes for your size!"},
  ["jobCancelledDied"]         ={type="error",  duration=15000,text="!!! ERROR Your job was cancelled because you died!"},
  ["jobWillCancelAwayToCenter"]={type="warning",duration=4000 ,text="!!! WARNING You've gone too far from the job center. If you go further, the job will be cancelled!"},
  ["jobWillCancelAwayToEntity"]={type="warning",duration=2000 ,text="!!! WARNING You are getting too far away from '%s'!"},
  ["jobCancelledAwayToCenter"] ={type="error",  duration=25000,text="!!! ERROR Your job was cancelled because you've gone too far from the job center!"},
  ["jobCancelledAwayToEntity"] ={type="error",  duration=25000,text="!!! ERROR Your job was cancelled because you've gone too far from the  '%s'!"},
  ["jobCancelledEntityNtFound"]={type="error",  duration=25000,text="!!! ERROR Your job was cancelled because '%s' is no more!"},
  ["jobWillCancelEngine"]      ={type="warning",duration=2000 ,text="!!! WARNING The engine of the '%s' received too much damage!"},
  ["jobCancelledEngine"]       ={type="error",  duration=25000,text="!!! ERROR Your job was cancelled. because the engine of the '%s' received too much damage!"},
  ["jobWillCancelBody"]        ={type="warning",duration=15000,text="!!! WARNING Warning '%s' took too much body damage! Receiving more damage can couse your job to be cancelled."},
  ["FailedToLoadAnim"]         ={type="error",  duration=25000,text="!!! ERROR '%s' Failed to load Animation Dictionary please make sure you have uploaded the all stream files."},
  ["FailedToLoadProp"]         ={type="error",  duration=25000,text="!!! ERROR '%s' Failed to load asset please make sure you have uploaded the all stream files.!"},
  ["FailedToLoadVehicle"]      ={type="error",  duration=25000,text="!!! ERROR '%s' Failed to load vehicle please make sure you have uploaded the all stream files.!"},
  ["angleAdded"]               ={type="inform", duration=10000,text="'%s' angle is saved."},
  ["angleNotAdded"]            ={type="warning",duration=10000,text="'%s' angle is not saved."},
  ["DatasCopied"]              ={type="success",duration=25000,text="Datas copied! Please add this data to the bottom of the Config.lua. Data also sent to server console, you can always copy from cmd."},
  ["alreadyHaveJob"]           ={type="error",  duration=10000,text="You are occupied with a different work."},
  ["noAnyTruckForDelivery"]    ={type="error",  duration=10000,text="There is no available truck at this moment."},
  ["willPayCutting"]           ={type="inform", duration=15000,text="You will get +'%s$' for cutting down the tree and delivering the logs. You can cut more trees if you'd like to or you can finish the job by delivering the telehandler. You will receive the cash once you deliver the telehandler"},
  ["willPayWoodpile"]          ={type="inform", duration=15000,text="You will get +'%s$' for loading the pallet of lumbers to the trailer. You will receive the cash once you deliver the forklift."},
  ["willPayforklift"]          ={type="inform", duration=15000,text="You will get +'%s$' for parking the forklift on to the trailer."},
  ["willPayGasolineFirst"]     ={type="inform", duration=15000,text="You will get +'%s$' extra for travel expenses. You will receive the cash once you deliver the truck.."},
  ["willPayGasolineSecond"]    ={type="inform", duration=15000,text="You will get +'%s$' extra for travel expenses for returning. You will receive the cash once you deliver the truck."},
  ["paidCutting"]              ={type="success",duration=25000,text="You received +'%s$' for all the wood cutting and delivering."},
  ["paidStacking"]             ={type="success",duration=25000,text="You received +'%s$' for all the loading lumbers and loading forklifts to the trailers."},
  ["paidDelivery"]             ={type="success",duration=25000,text="You received +'%s$' for delivering the lumbers to constructions and you also received +'%s$' for the traveling expenses. Your total gain is '%s$'"},
}