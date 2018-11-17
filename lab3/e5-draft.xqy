xquery version "3.1";

declare function local:toRadians($degree as xs:double) as xs:double {
    let $p1 := ($degree * math:pi())
    let $const := (180)
    return ($p1 div $const)
};

declare function local:distance($lat1, $lat2, $lon1, $lon2) as xs:double {
    let $dist1 := local:toRadians($lat1)
    let $dist2 := local:toRadians($lat2)
    let $lambda := local:toRadians($lon2 - $lon1)
    let $r := xs:double('6371e3')
    let $innerLeft := math:sin($dist1) * math:sin($dist2)
    let $innerRight := math:cos($dist1) * math:cos($dist2) * math:cos($lambda)
    let $distance := math:acos($innerLeft + $innerRight) * $r
    return $distance
};

declare function local:start() {
    let $document := doc("mondial.xml")/mondial
    let $cities := (
        for $city in $document/country/city
        let $latestPopulation := $city/population[@year = max($city/population/@year)]
        where $latestPopulation > 900000
        return <city name="{$city/name}">{$city/longitude}{$city/latitude}</city>
    )

    for $city1 in $cities[position() mod 2 = 0]
    let $lat1 := xs:double(data($city1/latitude))
    let $lon1 := xs:double(data($city1/longitude))
    let $result := (
        for $city2 in $cities[not(position() mod 2 = 0)]
        let $lat2 := xs:double(data($city2/latitude))
        let $lon2 := xs:double(data($city2/longitude))
        return <line distance="{format-number(local:distance($lat1, $lat2, $lon1, $lon2), '00.000')}">
            {$city1}
            {$city2}
        </line>
    )
  let $temp :=(
    for $res in $result
    where $res/@distance > 0
    order by $res/@distance
    return $res
  )
  for $a in $temp [@distance = max($temp/@res)]
  return $a    
};
  


<result>{
 (: for $a in local:start()[$res/@distance = max(local:start
 return $a  :)
  local:start()
}</result>
