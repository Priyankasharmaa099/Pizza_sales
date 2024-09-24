-- Determine the top 3 most ordered pizza types based on revenue for each pizza category

SELECT name, revenue
FROM (
    SELECT
        category,
        name,
        SUM(order_details.quantity * pizzas.price) AS revenue,
        RANK() OVER (PARTITION BY category ORDER BY SUM(order_details.quantity * pizzas.price) DESC) AS rn
    FROM pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.category, pizza_types.name
) AS ranked_data
WHERE rn <= 3;