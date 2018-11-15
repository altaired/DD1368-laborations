xquery version "3.1";
let $document := doc("mondial.xml")/mondial
let $lakes := $document/lake

let $res := (
    for $lake in $lakes
    for $country in tokenize($lake/@country, '\s')
    group by $country
    order by count($lake)
    return <country count="{count($lake)}">{$country}</country>
)

let $filteredCountries := (
    let $avgLakes := avg($res/@count)
    for $country in $res
    let $lakeCount := $country/@count
    where $lakeCount > $avgLakes
    return $country
)

let $multiFinalResult := (
    for $country in $filteredCountries
    let $count := $country/@count
    group by $count
    return <entry countries="{count($country)}" lakes="{$count}"/>
)

for $entry in $multiFinalResult
where $entry/@countries = max($multiFinalResult/@countries)
return $entry



