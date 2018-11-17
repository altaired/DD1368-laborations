xquery version "3.1";
(: declare namespace math = "java:java.lang.Math"; :)

let $document := doc("mondial.xml")/mondial

let $distance := (
  let $cities := (
    for $city in $document/country/city
    let $latestPopulation := $city/population[@year = max($city/population/@year)]
    where $latestPopulation > 900000
    return <city name="{$city/name}" population="{$latestPopulation}">{$city/longitude}{$city/latitude}</city>
  )
  
  
  let $diff := (
   for $city in $cities
   let $latdiff2 := ($city/latitude - $city/latitude)*($city/latitude - $city/latitude) 
   let $longdiff2 := (($city/latitude mod 360) - ($city/latitude mod 360))*(($city/latitude mod 360) - ($city/latitude mod 360))
   let $dist := math.sqrt($latdiff2+$longdiff2)
   (: $x := math.sqrt($city/longitude) as xs:double? :)
   
   return 13  
  )  
  return 12
)


return max($distance)
