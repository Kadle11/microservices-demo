local socket = require("socket");
math.randomseed(socket.gettime() * 1000);
math.random();
math.random();
math.random();

local products = {'0PUK6V6EV0', '1YMWWN1N4O', '2ZYFJ3GM2N', '66VCHSJNUP', '6E92ZMYYFZ', '9SIQT8TOJO', 'L9ECAV7KIM',
                  'LS4PSXUNUM', 'OLJCESPC7Z'};

local currencies = {'USD', 'EUR', 'CAD', 'JPY'};

local path = "http://10.244.2.240"
local POSTMethod = "POST"
local GETMethod = "GET"
local headers = {}
headers["Content-Type"] = "application/json"

init = function(args)
    local r = {}

    -- Set Currency 
    local currencyBody = '{"currency":"' .. currencies[math.random(1, #currencies)] .. '"}'
    r[1] = wrk.format(POSTMethod, path .. "/setCurrency", headers, currencyBody)

    -- Get Product
    r[2] = wrk.format(GETMethod, path .. "/product/" .. products[math.random(1, #products)], nil, nil)

    -- Add Product to Cart
    local addProductBody = '{"product_id":' .. products[math.random(1, #products)] .. ', "quantity":' ..
                               math.random(1, 10) .. '}';
    r[3] = wrk.format(POSTMethod, path .. "/cart", headers, addProductBody);


    -- View Cart
    r[4] = wrk.format(GETMethod, path .. "/cart", nil, nil)

    -- Checkout
    local checkoutBody =
        '{"email":"someone@example.com", "street_address":"1600 Amphitheatre Parkway", "zip_code" : "94043", "city": "Mountain View", "state": "CA", "country": "United States",  "credit_card_number":"1234567890123456", "credit_card_expiration_month":"12", "credit_card_expiration_year":"2020", "credit_card_cvv":"123"}';
    r[5] = wrk.format(POSTMethod, path .. "/cart/checkout", headers, checkoutBody);

    -- Pipeline all requests
    req = table.concat(r)
end

request = function()
    return req
end