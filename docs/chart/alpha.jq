jq -r '.["Time Series (5min)"] | to_entries[] | [.key, .value["5. volume"]] | @csv' junk.json | grep 6-17

jq -r '.["Time Series (5min)"] | to_entries[] | [.key, .value["5. volume"], .value["2. high"]] | @csv' junk.json | grep 6-18

