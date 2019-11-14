#!/bin/sh

curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-01", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-01", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-01", "IsOkay": "True"}'
curl http://localhost:5000/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-01-01", "IsOkay": "True"}'

curl http://localhost:5000/api/viewBRLevels

curl http://localhost:5000/api/viewBR
