JobConfig = {
    bossmenu = {
        coords = vector3(-126.13, -641.67, 168.82),
        length = 3.3,
        width = 1.9,
        heading = 6,
        minZ = 167.82,
        maxZ = 170.02
    },
    useJob = true,
    job_name = 'rea',
    realEstateFee = 0,   -- how much should realestate pay to create the house? Percentage of the house price, set to 0 to disable
    rentPercentage = 20, -- how much should realestate company receive from rent payments
    grade = {
        createhome = 0,
        deletehome = 1,
        createdoor = 1,
        frontyard = 1,
    },
    sellHome = {
        allowed = true,         -- allow homeowners to sell their home
        resellPercentage = 80,  -- percentage from the initial home price
        resellToCompany = false -- if true then it will use the company money to rebuy the home
    },
    furnishOtherHouse = false,
    furnitureSoldByCompany = false -- Furniture money that is sold will be sent to company
}
