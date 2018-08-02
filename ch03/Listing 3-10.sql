max(version) over (partition by dt order by version 
rows between unbounded preceding and unbounded following) 
latest_version