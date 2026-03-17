$baseUrl = "http://192.168.108.138:8181/ords/orassuitpdb/orassadm/referentiel"
$outFile = "d:\testLundi\testApex\test_apis_out.txt"

"==========================================" | Out-File $outFile
"TESTING ORDS REST APIs" | Out-File $outFile -Append
"==========================================`n" | Out-File $outFile -Append

"1. GET /branches/" | Out-File $outFile -Append
(curl.exe -s "$baseUrl/branches/") | Out-File $outFile -Append

"`n2. POST /clients/" | Out-File $outFile -Append
$clientPayload = '{"code_client": "CLI-API-TEST3", "type_client": "PHYSIQUE", "nom": "API3", "prenom": "Tester", "date_naissance": "1990-01-01", "email": "api3.test@email.com"}'
(curl.exe -s -X POST "$baseUrl/clients/" -H "Content-Type: application/json" -d $clientPayload) | Out-File $outFile -Append

"`n3. GET /clients/recherche?nom=API" | Out-File $outFile -Append
(curl.exe -s "$baseUrl/clients/recherche?nom=API") | Out-File $outFile -Append

"`n4. GET /formules/" | Out-File $outFile -Append
(curl.exe -s "$baseUrl/formules/") | Out-File $outFile -Append

"`n5. PUT /sinistres/4/statut" | Out-File $outFile -Append
$sinistrePayload = '{"statut": "REGLE", "montant_regle": 5000}'
(curl.exe -s -X PUT "$baseUrl/sinistres/4/statut" -H "Content-Type: application/json" -d $sinistrePayload) | Out-File $outFile -Append

"`n==========================================" | Out-File $outFile -Append
"TESTS COMPLETED" | Out-File $outFile -Append
"==========================================" | Out-File $outFile -Append
