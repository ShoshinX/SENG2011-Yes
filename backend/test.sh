#!/bin/sh

echo "Which port is being used?"
read port
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "unsw", "ProdDate": "2019-11-02", "ExpDate": "2020-02-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "ree", "ProdDate": "2019-11-02", "ExpDate": "2020-02-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "oki", "ProdDate": "2019-11-02", "ExpDate": "2020-02-01", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "urdad", "ProdDate": "2019-11-02", "ExpDate": "2020-02-02", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "A", "Location": "peepo", "ProdDate": "2019-11-02", "ExpDate": "2020-02-02", "IsOkay": "True"}'

curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "garb", "ProdDate": "2019-11-01", "ExpDate": "2020-03-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "NA", "ProdDate": "2019-11-01", "ExpDate": "2020-03-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "host", "ProdDate": "2019-11-01", "ExpDate": "2020-02-01", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "WA", "ProdDate": "2019-11-01", "ExpDate": "2020-03-02", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "AB", "Location": "wool", "ProdDate": "2019-11-01", "ExpDate": "2020-03-02", "IsOkay": "True"}'

curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "baka", "ProdDate": "2019-11-01", "ExpDate": "2020-03-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "reee", "ProdDate": "2019-11-01", "ExpDate": "2020-03-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "urma", "ProdDate": "2019-11-01", "ExpDate": "2020-03-01", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "uts", "ProdDate": "2019-11-01", "ExpDate": "2020-03-05", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "usyd", "ProdDate": "2019-11-01", "ExpDate": "2020-03-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "B", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-03-10", "IsOkay": "True"}'

curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "NP=P", "ProdDate": "2019-11-01", "ExpDate": "2020-03-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "reima", "ProdDate": "2019-11-01", "ExpDate": "2020-03-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "baka", "ProdDate": "2019-11-01", "ExpDate": "2020-03-06", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "weeb", "ProdDate": "2019-11-01", "ExpDate": "2020-03-06", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "bakan", "ProdDate": "2019-11-01", "ExpDate": "2020-03-03", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "big", "ProdDate": "2019-11-01", "ExpDate": "2020-03-04", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "mark", "ProdDate": "2019-11-01", "ExpDate": "2020-03-09", "IsOkay": "True"}'
curl http://localhost:$port/api/addBR -H "Content-Type: application/json" -d '{"BloodType": "O", "Location": "unsw", "ProdDate": "2019-11-01", "ExpDate": "2020-03-06", "IsOkay": "True"}'
