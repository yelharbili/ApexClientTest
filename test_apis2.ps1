$baseUrl = "http://192.168.108.138:8181/ords/orassuitpdb/orassadm/referentiel"
$outFile = "d:\testLundi\testApex\test_apis_out2.txt"

"==========================================" | Out-File $outFile -Encoding utf8
"TESTING ORDS REST APIs" | Out-File $outFile -Append -Encoding utf8
"==========================================`n" | Out-File $outFile -Append -Encoding utf8

"1. GET /branches/" | Out-File $outFile -Append -Encoding utf8
(Invoke-RestMethod -Uri "$baseUrl/branches/" | ConvertTo-Json -Depth 5) | Out-File $outFile -Append -Encoding utf8

"`n2. POST /clients/" | Out-File $outFile -Append -Encoding utf8
$clientPayload = @{
    code_client = "CLI-API-TEST3"
    type_client = "PHYSIQUE"
    nom = "API3"
    prenom = "Tester"
    date_naissance = "1990-01-01"
    email = "api3.test@email.com"
} | ConvertTo-Json
(Invoke-RestMethod -Uri "$baseUrl/clients/" -Method Post -ContentType "application/json" -Body $clientPayload -ErrorAction Stop | ConvertTo-Json -Depth 5) | Out-File $outFile -Append -Encoding utf8

"`n3. GET /clients/recherche?nom=API" | Out-File $outFile -Append -Encoding utf8
(Invoke-RestMethod -Uri "$baseUrl/clients/recherche?nom=API" | ConvertTo-Json -Depth 5) | Out-File $outFile -Append -Encoding utf8

"`n4. GET /formules/" | Out-File $outFile -Append -Encoding utf8
(Invoke-RestMethod -Uri "$baseUrl/formules/" | ConvertTo-Json -Depth 5) | Out-File $outFile -Append -Encoding utf8

"`n5. PUT /sinistres/4/statut" | Out-File $outFile -Append -Encoding utf8
$sinistrePayload = @{
    statut = "REGLE"
    montant_regle = 5000
} | ConvertTo-Json
(Invoke-RestMethod -Uri "$baseUrl/sinistres/4/statut" -Method Put -ContentType "application/json" -Body $sinistrePayload -ErrorAction SilentlyContinue | ConvertTo-Json -Depth 5) | Out-File $outFile -Append -Encoding utf8

"`n==========================================" | Out-File $outFile -Append -Encoding utf8
"TESTS COMPLETED" | Out-File $outFile -Append -Encoding utf8
"==========================================" | Out-File $outFile -Append -Encoding utf8
