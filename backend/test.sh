#!/bin/sh

curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-03", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-04", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-01", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-02", "IsOkay": "True"}'

curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-03", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-04", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-01", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-02", "IsOkay": "True"}'


curl http://localhost:5000/api/viewBRLevels

curl http://localhost:5000/api/viewBR

