-- Did you know you can make multiple CTEs? Here's the syntax
WITH <name> AS (Query)
, <name> AS (Query)
, <name> AS (Query)
SELECT ....


-- Get all actors that have been in the same films as the most popular actor
-- OPTION: Try to get it all in one go, or do this in steps (see HINTS on the repo)
WITH most_popular_actor AS(
    SELECT actor_id, COUNT(film_id) AS total_film
    FROM film 
    JOIN film_actor USING(film_id)
    GROUP BY actor_id
    ORDER BY total_film DESC
    LIMIt 1
), film_with_most_popular_actor AS(
        SELECT film_id
        FROM film_actor
        JOIN most_popular_actor USING(actor_id)
        WHERE actor_id = most_popular_actor.actor_id
) SELECT DISTINCT actor_id
    FROM film_actor
    WHERE film_id IN (SELECT film_id FROM film_with_most_popular_actor); 