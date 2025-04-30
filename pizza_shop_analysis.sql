create Database pizza;
use pizza;
select * from pizzas;
select * from order_details;
select * from  pizza_types;
select * from orders;

-- Q1 Retrieve the total number of orders placed.

select count(order_id) as total_orders from orders;



-- Q2  Calculate the total revenue generated from pizza sales.

select round(sum(pizzas.price * order_details.quantity),2) as total_sales from pizzas join order_details 
on pizzas.pizza_id = order_details.pizza_id;


-- Q3 Identify the highest-priced pizza.

select pizza_types.name,pizzas.price from pizzas join pizza_types 
on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by pizzas.price desc
limit 1;


-- Q4 Identify the most common pizza size ordered.

select pizzas.size,count(order_details.order_details_id) from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by count(pizzas.size) desc 
limit 1;


--  Q5  List the top 5 most ordered pizza types along with their quantities.

select pizzas.pizza_type_id as pizza_type, count(order_details.pizza_id) as total_Quantity from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.pizza_type_id
order by count(pizzas.pizza_type_id) desc
limit 5;



--   Q6 Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category, count(order_details.quantity) from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.category
order by count(order_details.quantity) desc;


--  Q7 Determine the distribution of orders by hour of the day.

select hour(orders.time) as time, count(order_details.quantity) as total_quantity from orders join order_details
on orders.order_id = order_details.order_id
group by hour(orders.time)
order by count(order_details.quantity);


-- Q8  Join relevant tables to find the category-wise distribution of pizzas.

select pizza_types.category, count(order_details.quantity) from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category;


--  Q9  Group the orders by date and calculate the number of pizzas ordered on same day.

select orders.date, count(order_details.quantity) from orders join order_details
on orders.order_id = order_details.order_id
group by orders.date;




-- Q10  Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name, sum(pizzas.price*order_details.quantity) from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name
order by sum(pizzas.price*order_details.quantity) desc 
limit 3;

-- Q11 Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.name,
round((round(sum(pizzas.price*order_details.quantity),1)/ 
(select round(sum(pizzas.price*order_details.quantity),1) as total_revenue from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id )),2)*100 as revenue_perct from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id 
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
 
group by pizza_types.name
order by revenue_perct desc;




