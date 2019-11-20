#!/bin/sh

echo "Which port is being used?"
read port
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-01", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-02", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-02", "IsOkay": "True"}'

curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-01", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-02", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-02", "IsOkay": "True"}'

curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-01", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-05", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-10", "IsOkay": "True"}'

curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-06", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-06", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-09", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-06", "IsOkay": "True"}'
