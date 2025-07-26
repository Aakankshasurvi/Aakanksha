select m.movie_id, title, budget, revenue, currency, unit,
case
when unit='billions' then round((revenue-budget)*1000,2)
when unit='thousands' then round((revenue-budget)/1000,2)
else (revenue-budget)
end as profit_mln,
case
when unit='billions' then round((((revenue-budget)*1000)/(budget*1000))*100,2)
when unit='thousands' then round((((revenue-budget)/1000)/(budget/1000))*100,2)
else round(((revenue-budget)/budget)*100,2)
end as profit_percent
from movies m join financials f 
on m.movie_id=f.movie_id
where industry='bollywood'
*******************************************************************************
select 
a.name, group_concat(m.title) as movies, count(m.title) as movie_count
from actors a 
join movie_actor ma on ma.actor_id=a.actor_id
join movies m on m.movie_id=ma.movie_id
group by a.actor_id
order by movie_count desc
*******************************************************************************
select title, currency, unit,
case
when unit='billions' then round(revenue*1000,2)
when unit='thousands' then round(revenue/1000,2)
else revenue
end as revenue_mln
from movies m join financials f on
m.movie_id=f.movie_id
join languages l on 
l.language_id=m.language_id
where l.name='hindi'
order by revenue_mln desc

