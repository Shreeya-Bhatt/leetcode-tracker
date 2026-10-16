with recent_3_reviews as(
    select
        employee_id,
        review_date,
        rating,
        row_number() over(
            partition by employee_id 
            order by review_date desc
            ) as rnk
    from performance_reviews
),
check_rating_improvement as (
    select
        employee_id,
        rating,
        rating - lead(rating) over(
            partition by employee_id 
            order by review_date desc
            )as improvement
    from recent_3_reviews
    where rnk <= 3
)
select
    e.employee_id,
    e.name,
    max(rt.rating) - min(rt.rating) as improvement_score
from check_rating_improvement rt
join employees e
    on rt.employee_id = e.employee_id
where rt.improvement > 0
    or rt.improvement is NULL
group by e.employee_id,e.name
having count(*) = 3
order by 3 desc, 2 asc