xquery version "3.1";


declare function local:bfs($queue, $visited, $step, $total, $result) {
    if(empty($queue)) then $result
    else (
        let $tos := $queue[1]
        let $neighbors := (
            for $neighbour in $tos/border/@country[not(. = $visited/@car_code)]
            let $country := $tos/../country[@car_code = $neighbour]
            return $country
        )
        let $newTotal := $total + count($neighbors)
        let $res := (<cross num="{$step}" sum="{$newTotal}">{
            for $c in $neighbors
            return <country>{data($c/name)}</country>
        }</cross>)
        let $steps := (if (count($neighbors) > 0) then (
            $step + 1
        ) else (
            $step
        ))
        return local:bfs(($queue[position() > 1], $neighbors), ($visited, $neighbors), $steps, $newTotal, ($result, $res))
    )
};

declare function local:start() {
    let $countries := doc('mondial.xml')//country[@car_code = 'S']
    return local:bfs($countries, $countries, 1, 0, ())[count(country) > 0]
};

<from_swe_cross>{local:start()}</from_swe_cross>