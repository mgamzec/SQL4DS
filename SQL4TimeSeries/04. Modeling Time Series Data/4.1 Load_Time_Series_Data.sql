/* 

Loading Data 

*/


COPY time_series.location_temp(event_time, location_id, temp_celcius)
FROM 'C:\Users\merve\Desktop\SQL_Time_Series\04\data\location_temp.txt' DELIMITER ',';
