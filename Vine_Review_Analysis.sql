-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

--select COUNT(*) from vine_table; 

--1 Filter the data and create a new DataFrame or table to retrieve all the rows where the total_votes count is equal to or greater than 20
SELECT *
INTO vine_20plus_votes 
FROM vine_table 
WHERE total_votes>=20;

--2 Filter the new DataFrame or table created in Step 1 and create a new DataFrame or table to retrieve all the rows where the number of helpful_votes divided by total_votes is equal to or greater than 50%.
SELECT * 
INTO helpful_votes    
FROM vine_20plus_votes 
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

--3 Filter the DataFrame or table created in Step 2, and create a new DataFrame or table that retrieves all the rows where a review was written as part of the Vine program (paid), vine == 'Y'.
SELECT * 
FROM helpful_votes 
WHERE vine ='Y';

--4 Repeat Step 3, but this time retrieve all the rows where the review was not part of the Vine program (unpaid), vine == 'N'.
SELECT * 
FROM helpful_votes 
WHERE vine ='N';

--5 Determine the total number of reviews, the number of 5-star reviews, and the percentage of 5-star reviews for the two types of review (paid vs unpaid).
SELECT vine, COUNT(review_id) AS REVIEWS
	, COUNT(CASE WHEN STAR_RATING =5 THEN 'Y' ELSE NULL END ) AS FIVE_STAR_REVIEWS
	, CAST(COUNT(CASE WHEN STAR_RATING =5 THEN 'Y' ELSE NULL END ) AS FLOAT)/CAST(COUNT(review_id) AS FLOAT) AS FIVE_STAR_REVIEW_PERCENT
FROM helpful_votes GROUP BY vine ;
