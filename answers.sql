/*
1. Select a distinct list of ordered airports codes. Be sure to name the column correctly. Be sure to order the results correctly.
*/
SELECT DISTINCT departAirport AS Airports FROM flight ORDER BY Airports;

/*
2. Provide a list of delayed flights departing from San Francisco (SFO).
*/

SELECT airline.name, flight.flightNumber, flight.scheduledDepartDateTime, flight.arriveAirport, flight.status FROM flight INNER JOIN airline ON flight.airlineID = airline.ID WHERE flight.departAIRPORT = 'SFO' AND flight.status = 'DELAYED';

/*
3. Provide a distinct list of cities that American airlines departs from.
*/
SELECT DISTINCT departAirport AS Cities FROM flight WHERE airlineID = 1 ORDER BY Cities;

/*
4. Provide a distinct list of airlines that conducts flights departing from ATL.
*/
SELECT DISTINCT airline.name AS Airline FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE departAirport = 'ATL' ORDER BY Airline;

/*
5. Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
*/
SELECT airline.name, flight.flightNumber, flight.departAirport, flight.arriveAirport FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE flight.scheduledDepartDateTime = flight.actualDepartDateTime;

/*
6. Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. Order your results by the arrival time.
*/
SELECT airline.name AS Airline, flight.flightNumber AS Flight, flight.gate AS Gate, TIME(flight.scheduledArriveDateTime) AS Arrival, flight.status AS Status FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE flight.arriveAirport = 'CLT' AND DATE(flight.scheduledArriveDateTime) = '2017-10-30' ORDER BY Arrival;

/*
7. List the number of reservations by flight number. Order by reservations in descending order.
*/
SELECT flight.flightNumber AS flight, COUNT(reservation.flightID) AS reservations FROM flight INNER JOIN reservation ON flight.ID = reservation.flightID GROUP BY flight  ORDER BY reservations DESC;

/*
8. List the average ticket cost for coach by airline and route. Order by AverageCost in descending order.
*/
SELECT DISTINCT airline.name AS airline, flight.departAirport, flight.arriveAirport, AVG(reservation.cost) AS AverageCost FROM airline INNER JOIN flight ON airline.ID = flight.airlineID INNER JOIN reservation ON reservation.flightID = flight.ID WHERE reservation.class = 'coach' GROUP BY flight.ID ORDER BY AverageCost DESC;

/*
9. Which route is the longest?
*/
SELECT departAirport, arriveAirport, miles FROM flight ORDER BY miles DESC LIMIT 1;

/*
10. List the top 5 passengers that have flown the most miles. Order by miles.
*/
SELECT passenger.firstName, passenger.lastName, SUM(flight.miles) AS miles FROM passenger INNER JOIN reservation ON passenger.ID = reservation.passengerID INNER JOIN flight ON reservation.flightID = flight.ID GROUP BY passenger.ID ORDER BY miles DESC LIMIT 5;

/*
11. Provide a list of American airline flights ordered by route and arrival date and time. Your results must look like this:
*/
SELECT airline.name AS Name, CONCAT(flight.departAirport, ' --> ', flight.arriveAirport) AS Route, DATE(flight.scheduledArriveDateTime) AS `Arrive Date`, TIME(flight.scheduledArriveDateTime) AS `Arrive Time` FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE airline.ID = 1 ORDER BY route, DATE(scheduledArriveDateTime), TIME(scheduledArriveDateTime);


/*
12. Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) by Airline, flight, and route. Order the report by total revenue in descending order.
*/

SELECT airline.name AS Airline, flight.flightNumber AS Flight, CONCAT(flight.departAirport, ' --> ', flight.arriveAirport) AS Route, COUNT(reservation.flightID) AS `Reservation Count`, SUM(reservation.cost) AS Revenue FROM airline INNER JOIN flight ON airline.ID = flight.airlineID INNER JOIN reservation ON reservation.flightID = flight.ID GROUP BY flight.ID ORDER BY `Revenue` DESC;

/*
13. List the average cost per reservation by route. Round results down to the dollar.
*/
SELECT CONCAT(flight.departAirport, ' --> ', flight.arriveAirport) AS Route, FLOOR(AVG(reservation.cost)) AS `Avg Revenue` FROM flight INNER JOIN reservation ON flight.ID = reservation.flightID GROUP BY flight.ID ORDER BY `Avg Revenue` DESC;

/*
14. List the average miles per flight by airline.
*/
SELECT airline.name AS Name, AVG(flight.Miles) AS `Avg Miles Per Flight` FROM airline INNER JOIN flight ON airline.ID = flight.airlineID GROUP BY airline.Name ORDER BY airline.name;


/*
15. Which airlines had flights that arrived early?
*/
SELECT DISTINCT airline.name AS Airline FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE TIMEDIFF(TIME(flight.scheduledArriveDateTime), TIME(flight.actualArriveDateTime)) > 0;