xquery version "3.1";

declare function local:cities() as element()+ {
    let $document := doc("mondial.xml")/mondial
    for $city in $document/country/city
    let $latestPopulation := $city/population[@year = max($city/population/@year)]
    where $city/latitude > 0 and $latestPopulation > 0
    return <city name="{$city/name}" population="{$latestPopulation}">{$city/longitude}{$city/latitude}</city>
};

declare function local:northern($latitude as xs:double) as element()+ {
    let $document := doc("mondial.xml")/mondial
    for $city in local:cities()
    where $city/latitude >= $latitude
    let $sum := $city/@population
    return <res city="{$city/@name}">{$sum}</res>
};

declare function local:southern($latitude as xs:double) as element()+ {
    let $document := doc("mondial.xml")/mondial
    for $city in local:cities()
    where $city/latitude < $latitude
    let $sum := $city/@population
    return <res city="{$city/@name}">{$sum}</res>
};

declare function local:diff($latitude as xs:double) as element()+ {
    let $north := sum(local:northern($latitude)/@population)
    let $south := sum(local:southern($latitude)/@population)
    let $ratio := $south div $north
    return <ratio latitude="{$latitude}" ratio="{$ratio}"/>
};

declare function local:find() as element()+ {
    for $lat in 1 to xs:int(max(local:cities()/latitude))
    return local:diff($lat) 
};

declare function local:minLat() as element()+ {
    let $result := local:find()
    let $abs := (
        for $res in $result
        let $newRatio := abs($res/@ratio - 1)
        order by $newRatio  
        return <res ratio="{$newRatio}" lat="{$res/@latitude}"/>
    )
    for $a in $abs[@ratio = min($abs/@ratio)]
    return $a
};

<result>{local:minLat()}</result>