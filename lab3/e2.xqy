xquery version "3.1";
let $document := doc("mondial.xml")/mondial

return <result>{
for $sea in $document/sea
let $borders := tokenize($sea/@bordering, '\s')
order by count($borders) ascending
return 
<sea borderingSeas="{count($borders)}">{$sea/name}</sea>
}</result>