xquery version "3.1";
let $document := doc("mondial.xml")/mondial
let $countries := $document/country
let $continents := $document/continent

return <result>{
for $continent in $continents/@id
return 
<continent name="{$continent}">{
    for $country in $countries[encompassed/@continent = $continent]
    for $city in $country/city[@id = $country/@capital]
    where min($city/population) > 3000000
    return 
    <country capital="{$city/name}">
        {$country/name}
        {$city/population}
    </country>
}</continent>
}</result>