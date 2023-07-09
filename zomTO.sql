select * from goldusers_signup;
select * from product;
select * from sales ;
select * from users;


Q1. what is total amount spent by each customers?

select sales.userid, sum(product.price)
from sales
left join product
on product.product_id = sales.product_id
group by sales.userid;


Q2. How many days each customers visited the shop?


SELECT USERID,count(created_date) from sales
group by userid
order by userid;

Q3.  What was the first product purchsed by each customer?

with sale as
(select created_date,userid,product_id,
rank() over(partition by userid order by created_date) as rank_num
from sales
)
 select  * from sale where rank_num = 1;
 
 Q4. What is most purchased item and number of times was it purchased by all customers
 
 
select userid, count(product_id) as times_purchase from sales where product_id=(
select  product_id  from sales
group by product_id
order by  count(product_id) desc limit 1 )
group by userid

Q5. Which item is the most popular for each customer?

select userid, count(product_id)  from sales
group by userid



Q6. which item


select * ,rank() over(partition by userid order by created_date) as rak_num
from  
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a 
inner join goldusers_signup b on a.userid= b.userid
where created_date>=gold_signup_date)d
where rak_num = 1;

Q7.











Q8. What is the total orders and amount spend for each customer before they became a member?

select a.userid,count(a.product_id) as order_purchased,sum(product.price) from sales a
inner join product 
on a.product_id  = product.product_id
inner join goldusers_signup g
on a.userid =  g.userid
where a.created_date <= g.gold_signup_date
group by a.userid
order by a.userid


Q9. If buying product generates points for eg . 5 rs =2 points and each product has different points
    for p1 eg 5rs = 1 point, for p2 10 points and for p3 5 rs =1 point
	
	calculate points collected by each customer and  for which product most points have given till now? 


with fibre as (select a.userid,sum(b.price)as amounts,a.product_id from sales a
inner join product b
on a.product_id = b.product_id
group by a.userid,a.product_id
order by a.userid),
pnt as(select *,
case
	when product_id = 1 then 5
	when product_id = 2 then 2
	when product_id = 3 then 5
	else 0
end as points
 from fibre)
 select fibre.amounts/pnt.points as totl_pnt
 from fibre,pnt
 
 select userid,sum(total_amt.totl_pnt) from fibre,total_amt 
 group by userid
 
 Q10. In the 
 
 
 SELECT *,.5 *  d.money as points FROM 
(select a.userid, sum(b.price) AS MONEY,a.created_date,g.gold_signup_date
 from sales a
 inner join product b
 on a.product_id = b.product_id
 inner join goldusers_signup g
 on a.userid = g.userid
 where a.created_date>= g.gold_signup_date   and created_date < gold_signup_date+365
 group by a.userid,a.created_date,g.gold_signup_date) AS D
 
 
Q11. rank all transaction of customers

select *,rank() over(partition by userid order by created_date) from sales

Q12.  

