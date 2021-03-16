CREATE DATABASE IF NOT EXISTS book1;

USE book2;

CREATE TABLE IF NOT EXISTS sheet1 (
	saklar_lampu	VARCHAR(3)
);

 DELETE FROM sheet1;

 ALTER TABLE sheet1
	DROP PRIMARY KEY;

ALTER  TABLE sheet1
	ADD PRIMARY KEY(saklar_lampu);

-- Memasukkan 2 record sekaligus
INSERT INTO sheet1 (saklar_lampu) VALUES
	('ON'),
	('OFF'); 

/*INSERT INTO sheet1 (saklar_lampu) VALUES
	('ON'),
	('OFF'); 
*/

/* debug untuk jumlah Record */
SELECT saklar_lampu as 'Nama Saklar Lampu'
	   /* Tidak Disarankan*/ ,
	   COUNT(saklar_lampu) as Status_Saklar_Lampu
FROM   sheet1
GROUP BY saklar_lampu
ORDER BY saklar_lampu ASC;

SELECT saklar_lampu AS 'SAKLAR LAMPU',
		IF(saklar_lampu='ON','Nyala','Mati') AS STATUS_LAMPU
FROM sheet1;