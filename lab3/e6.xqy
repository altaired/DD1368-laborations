xquery version "3.1";


declare function local:dfs($queue, $visited, $step, $total, $result) {
    if(empty($queue)) then $result
    else (
        let $tos := $queue[1]
        let $neighbors := (
            for $neighbour in $tos/border/@country[not(. = $visited/@car_code)]
            let $country := $tos/../country[@car_code = $neighbour]
            return $country
        )
        let $res := (<cross num="{$step}" sum="{$total}">{
            for $c in $neighbors
            return <country>{data($c/name)}</country>
        }</cross>)
        return local:dfs(($neighbors, $queue[position() > 1]), ($visited, $neighbors), $step + 1, $total + count($neighbors), ($result, $res))
    )
};

declare function local:start() {
    let $countries := doc('mondial.xml')//country[@car_code = 'S']
    return local:dfs($countries, $countries, 1, count($countries), ())[count(country) > 0]
};

<from_swe_cross>{local:start()}</from_swe_cross>