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
  
  for $city in $cities
  let $diff := (
   (: Where do I declare the different cities? :)
   let $latdiff := ($city1/latitude - $city2/latitude)*($city1/latitude - $city2/latitude) 
   let $longdiff := (($city1/latitude mod 360) - ($city2/latitude mod 360))*(($city1/latitude mod 360) - ($city2/latitude mod 360))
   
   (: Why is sqrt not recognized here? But only sometimes?! :)
   return math.sqrt($latdiff+$longdiff)
  )
    
  return $distance
)

let $rightdist := (
  for $dist in $distance
  (: smaller of the two distances between two cities -> choose else other one. should be nested differently? :)
  (: declare th distances seperately here? :)
  if($dis1 <= $dis2)
  then(
    (: send $dis1 to $rightdist :)
  )
  else(
    (: send $dis2 to $rightdist :)   
  )
  return $rightdist 
)


return max($rightdist)
