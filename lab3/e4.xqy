xquery version "3.1";
let $document := doc("mondial.xml")/mondial

let $cities := (
    for $city in $document/country/city
    let $latestPopulation := $city/population[@year = max($city/population/@year)]
    where $latestPopulation > 900000
    return <city name="{$city/name}" population="{$latestPopulation}">{$city/longitude}{$city/latitude}</city>
)

return $cities